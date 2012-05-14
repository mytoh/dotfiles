#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use rfc.uri)
(require-extension (srfi 13))
(use kirjasto)

(define (sanoa lang word)
  (let1 url (string-append
              "http://translate.google.com/translate_tts?ie=UTF-8&tl="
              (string-upcase lang)
              "&q="
              word)
  (run-command `(mplayer -really-quiet ,url ))
  )
  )

(define (main args)
  (sanoa (cadr args)
         (caddr args))
  )
