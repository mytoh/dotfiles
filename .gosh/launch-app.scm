#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use util.match)

(define (launch app)
  (display "launching ")
  (display app)
  (newline)
  (run-process app
               :detached #t
               :output :null
               :error :null))

(define (main args)
  (launch (cdr args)))
