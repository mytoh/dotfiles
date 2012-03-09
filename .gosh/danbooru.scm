#!/usr/bin/env gosh

(use kirjasto) ; swget mkdir cd make-colour
(use gauche.parseopt)
(use gauche.collection)
(use sxml.ssax)
(use sxml.sxpath)
(use file.util)
(use srfi-1)
(use rfc.http)
(use rfc.uri)



(define (get-posts page-number tag)
  (receive (status head body)
           (http-get "danbooru.donmai.us" (string-append "/post?page=" (number->string page-number) "&tags=" tag))
           body
           ))

(define (parse-post-number-url body)
  (let ((parse-image-url (lambda (line) (rxmatch #/\"file_url\"\:\"(http\:\/\/[[:alpha:]]+\.donmai\.us\/data\/[^\"]+)/ line)))
        (parse-image-id  (lambda (line) (rxmatch #/\"id\"\:(\d+)/ line)))
        (parse-element (lambda (proc str) 
                         (remove not
                                 (delete-duplicates
                                   (call-with-input-string str
                                                           (lambda (in)
                                                             (port-map
                                                               (lambda (line)
                                                                 (let ((match (proc line)))
                                                                   (if match
                                                                     (match 1) #f)))
                                                               (cut read-line in #t )))))))))
    (zip
      (parse-element parse-image-id body)
      (parse-element parse-image-url body))))

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

(define (parse-last-page-number str)
  (if-let1 pagination  (rxmatch->string #/<div class\=\"pagination\">.*?<\/div>/
                                        str)
           (let ((page (call-with-input-string  pagination  (lambda (in)
                                                              (ssax:xml->sxml in ())))))
             (caddr (find-max
                     ((node-closure (ntype-names?? '(a))) page)
                     :key (lambda (e) (x->number (caddr e))))))
           1
           ))

(define (get-posts-all tag)
  (let ((last (x->number (parse-last-page-number (get-posts 1 tag)))))
    (print (string-append (make-colour 82 last)
                          " pages found"))
    (dotimes (num last)
      (print (string-append (make-colour 99 "getting page ") (make-colour 33 (+ num 1))))
       (get-image (parse-post-number-url (get-posts (+ num 1) tag))))
    ))

  (define (main args)
    (let-args (cdr args)
              ((tag "t|tag=s")
               . rest)
              (mkdir tag)
              (cd tag)
              (get-posts-all tag)
              (cd "..")
              ))

