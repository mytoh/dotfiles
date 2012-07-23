#!/usr/bin/env gosh

(use kirjasto) ;swget,mkdir,cd,colour-string
(use text.html-lite)
(use sxml.ssax)
(use sxml.sxpath)
(use gauche.parseopt)
(use gauche.collection)
(use srfi-1)
(use rfc.http)

(define (parse-img-url str)
  (let ((url (lambda (line) (rxmatch->string #/http\:\/\/konachan\.com\/(image|jpeg)\/[^"]+/ line))))
    (remove not ;; remove #f
            (delete-duplicates
              (call-with-input-string str
                                      (lambda (in)
                                        (port-map
                                          (lambda (line)
                                            (let ((match (url line)))
                                              match))
                                          (cut read-line in #t))))))))

(define (parse-last-page-number str)
  (if-let1 pagination  (rxmatch->string #/<div class\=\"pagination\">.*?<\/div>/
                                        str)
    (let ((page (call-with-input-string  pagination  (lambda (in)
                                                       (ssax:xml->sxml in ())))))
      (caddr (find-max
               ((node-closure (ntype-names?? '(a))) page)
               :key (lambda (e) (x->number (caddr e))))))
    1))


(define (get-tags-page page-number tag)
  (receive (status head body)
    (http-get "konachan.com" (string-append "/post?page=" (number->string page-number) "&tags=" tag))
    body ))

(define (get-tags-pages tag)
  (let ((last (x->number (parse-last-page-number (get-tags-page 1 tag)))))
    (dotimes (num last)
      (print (string-append (colour-string 99 "getting page ") (colour-string 33 (+ num 1))))
      (map
        (lambda (u)
          (swget u))
        (parse-img-url (get-tags-page (+ num 1) tag))))))

(define (main args)
  (let-args (cdr args)
    ((tag "t|tag=s")
     . rest)
    (mkdir tag)
    (cd tag)
    (get-tags-pages tag)
    (cd "..")))
