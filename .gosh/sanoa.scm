#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use rfc.uri)
(use kirjasto)

(define (main args)
  (let1 url (string-append "http://translate.google.com/translate_tts?ie=UTF-8&tl=JA&q=" (cadr args))
  (run-command `(mplayer -really-quiet ,url ))
  )
  )
