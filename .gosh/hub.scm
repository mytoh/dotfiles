#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use util.match)
(use kirjasto)

(define (clone url)
  (if (rxmatch->string #/^http:\/\/.*|^git:\/\/.*/ url)
  (run-process `(git clone ,url) :wait #t)
  ; clone github repository
  (run-process `(git clone ,(string-append "git://github.com/" url)) :wait #t)
    )
  )

(define (hub args)
  (if  (string=? "clone" (cadr args))
    (clone (caddr args))
    (run-process `(git ,@(cdr args)) :wait #t)
    )
  )

(define (main args)
  (hub args)
  )
