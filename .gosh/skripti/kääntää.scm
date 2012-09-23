#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use gauche.charconv)
(use rfc.http)
(use rfc.json)
(use kirjasto)
(require-extension (srfi 13))


(define get-google-translate
  (lambda (sl tl text)
    (rxmatch->string #/\"([^\"]*)\"/
                     (string-delete
                       (ces-convert
                         (values-ref (http-get "translate.google.com"
                                               (http-compose-query
                                                 "/translate_a/t"
                                                 `((client "t")
                                                   (ie "UTF-8")
                                                   (sl ,sl)
                                                   (tl ,tl)
                                                   (text ,text))))
                           2)
                         "iso-8859-1")
                       #[\[\],])
                     1)) )

(define (google-translate args)
  (let* ((source-lang (cadr args))
         (target-lang   (caddr args))
         (text      (cadddr args))
         (translated (get-google-translate source-lang target-lang text))
         )
    (print
      (string-append
        text
        " -> "
        (colour-string 123 translated)))))

(define (sanakirja word)
  )


; http://translate.google.com/translate_a/t?client=t&ie=UTF-8&text=talikko&sl=fi&tl=en
