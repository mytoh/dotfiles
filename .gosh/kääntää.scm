#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use rfc.http)
(use kirjasto)
(require-extension (srfi 13))

(define (main args)
  (let* ((from-lang (cadr args))
        (to-lang   (caddr args))
        (text      (cadddr args))
    (translated 
      (string-delete (rxmatch->string  #/"[^"]*"/
                        (string-incomplete->complete
                          (values-ref (http-get "translate.google.com" 
                                                (http-compose-query
                                                  "/translate_a/t"
                                                  `((client "t")
                                                    (ie "UTF-8")
                                                    (sl ,from-lang)
                                                    (tl ,to-lang)
                                                    (text ,text))))
                            2)
                          :omit))
                     #\")))
  (print (string-append
           text
           " -> "
           (make-colour 123 translated)))
  )
)

; http://translate.google.com/translate_a/t?client=t&ie=UTF-8&text=talikko&sl=fi&tl=en
