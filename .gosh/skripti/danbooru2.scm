#!/usr/bin/env gosh

(use kirjasto) ;swget,mkdir,cd,colour-string
(use gauche.parseopt)
(use gauche.collection)
(use sxml.ssax)
(use sxml.sxpath)
(use file.util)
(use srfi-1)
(use rfc.http)
(use rfc.uri)

(define *danbooru-host* "testbooru.donmai.us")



(define (parse-image-url url-list)
  (let ((get (lambda (url)
              (let ((parse-url
                      (lambda (u) (rxmatch-let (rxmatch #/^http:\/\/([-A-Za-z\d.]+)(:(\d+))?(\/.*)?/ u)
                                    (#f h #f pt ph)
                                    (values h pt (uri-decode-string ph))))))
                (receive (host port path)
                  (parse-url url)
                  (receive (status head body)
                    (http-get host path)
                    body))))))
    (map
      (lambda (u)
        (string-append "http://testbooru.donmai.us/"
                       (rxmatch->string
                         #/\"(\/data\/original\/\w+\.[a-z]+)\"/
                         (get u) 1)))
      url-list)

))

(define (parse-page-number str)
  ; html -> string-list
  (let ((parse-number
          (lambda (e m)
            (rxmatch->string
              #/<a href\=\"\/posts\/(\d+)\">/ e m)))
        (parse-element
          (lambda (proc e)
                         (remove not
                                 (delete-duplicates
                                   (let loop ((s e))
                                     (let ((match proc))
                                       (if (not s)
                                         '()
                                         (cons (match s 1)
                                               (loop (match s 'after)))))))))))
      (parse-element parse-number str)
    ))

(define (gen-id-url-list str)
  (let ((num-list (parse-page-number str)))
    (zip
      num-list
      (parse-image-url
        (map
          (lambda (e) (build-path "http://testbooru.donmai.us/posts" e))
          num-list)))))

(define (swget url filename)
  (let ((parse-url
          (lambda (u) (rxmatch-let (rxmatch #/^http:\/\/([-A-Za-z\d.]+)(:(\d+))?(\/.*)?/ u)
                                   (#f h #f pt ph)
                                   (values h pt (uri-decode-string ph))))))
    (receive (host port path) (parse-url url)
             (let ((file (receive (a f ext) (decompose-path path) #`",|filename|.,|ext|")))
               (if (not (file-is-readable? file))
                 (http-get host path
                           :sink (open-output-file file) :flusher (lambda (s h) (print file) #t)))))))

(define (get-image id-num-list)
  (let loop ((lst  id-num-list))
    (if (not (null?  lst))
      (let ((id (car (car lst)))
            (url (cadr   (car lst)))
            )
        (swget url id)
        (loop (cdr lst))))))

(define (get-posts page-number tag)
  (receive (status head body)
           (http-get *danbooru-host* (string-append "/post?page=" (number->string page-number) "&tags=" tag))
           body
           ))

(define (parse-last-page-number str)
  (if-let1 pagination  (rxmatch->string #/<div class\=\"paginator\">.*?<\/div>/
                                        str)
           (let ((page (call-with-input-string  pagination  (lambda (in)
                                                              (ssax:xml->sxml in ())))))
             (caddr (find-max
                     ((node-closure (ntype-names?? '(a))) page)
                     :key (lambda (e) (x->number (caddr e))))))
           1
           ))

(define (get-posts-all tag)
  (let ((last-number (x->number (parse-last-page-number (get-posts 1 tag)))))
    (print (string-append (colour-string 82 last-number)
                          " pages found"))
    (dotimes (num last-number)
      (print (string-append
               (colour-string 99 "getting page ")
               (colour-string 33  (+ num 1))))
      (get-image (gen-id-url-list (get-posts (+ num 1)  tag))))))

(define (main args)
  (let-args (cdr args)
    ((tag "t|tag=s")
     . rest)
    (mkdir tag)
    (cd tag)
    (get-posts-all tag)
    (cd "..")))

