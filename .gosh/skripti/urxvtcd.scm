#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use util.match)

(define (urxvtcd)
  (run-process '(urxvtd -q -o -f) :wait #t)
  (run-process '(urxvtc) :wait #t 
                       :detached #t
                        :error  :null
                        :output :null)
  )

(define (main args)
  (urxvtcd)
  )
