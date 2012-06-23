#!/usr/bin/env gosh

(use kirjasto) ; swget mkdir cd colour-string
(use gauche.parseopt)
(use gauche.collection)
(use sxml.ssax)
(use sxml.sxpath)
(use file.util)
(use rfc.http)
(use rfc.uri)
(require-extension
  (srfi 1 11))


(define (get-post-page page-number tag)
  (receive (status head body)
           (http-get "danbooru.donmai.us" (string-append "/post?page=" (number->string page-number) "&tags=" tag))
           body))

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
                                                                   (cond
                                                                     (match (match 1))
                                                                     (else #f))))
                                                               (cut read-line in #t )))))))))
    (zip
      (parse-element parse-image-id body)
      (parse-element parse-image-url body))))


(define (swget uri filename)
  (let-values (((scheme user-info hostname port-number path query fragment)
                (uri-parse uri)))
    (let ((file (receive (a f ext) (decompose-path path) #`",|filename|.,|ext|")))
      (when (not (file-is-readable? file))
        (http-get hostname path
                  :sink (open-output-file file) :flusher (lambda (s h) (print file) #t))))))

(define (get-image id-num-list)
  (let loop ((lst  id-num-list))
    (when (not (null?  lst))
      (let ((id (car (car lst)))
            (url (cadr   (car lst))))
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
           1))

(define (get-posts-all tag)
  (print tag)
  (let ((last (x->number (parse-last-page-number (get-post-page 1 tag)))))
    (print (string-append (colour-string 82 (number->string last))
                          " pages found"))
    (dotimes (num last)
      (print (string-append (colour-string 99 "getting page ") (colour-string 33 (number->string (+ num 1)))))
       (get-image (parse-post-number-url (get-post-page (+ num 1) tag))))))

  (define (main args)
    (let-args (cdr args)
              ((tag "t|tag=s")
               . rest)
              (mkdir tag)
              (cd tag)
              (get-posts-all tag)
              (cd "..")))








