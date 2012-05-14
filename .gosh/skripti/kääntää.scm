#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use gauche.charconv)
(use rfc.http)
(use kirjasto)
(require-extension (srfi 13))

(define (main args)
  (let* ((source-lang (cadr args))
         (target-lang   (caddr args))
         (text      (cadddr args))
         (translated
           (rxmatch->string #/\"([^"]*)\"/
                            (string-delete
                              (ces-convert
                                (values-ref (http-get "translate.google.com"
                                                      (http-compose-query
                                                        "/translate_a/t"
                                                        `((client "t")
                                                          (ie "UTF-8")
                                                          (sl ,source-lang)
                                                          (tl ,target-lang)
                                                          (text ,text))))
                                  2)
                                "iso-8859-1")
                              #[\[\],])
                            1)))
    (print
      (string-append
        text
        " -> "
        (make-colour 123 translated)
        ))))

; http://translate.google.com/translate_a/t?client=t&ie=UTF-8&text=talikko&sl=fi&tl=en
