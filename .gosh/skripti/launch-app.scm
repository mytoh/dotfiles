#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use util.match)
(use file.util)

(define (launch app)
  (if (find-file-in-paths (car app))
    (begin 
      (display "launching ")  
      (display (car  app))  
      (newline)  
      (run-process app
                   :detached #t
                   :output :null
                   :error :null))
    (print (string-append "no such command " 
             (car app)))
    ))

(define (main args)
  (launch (cdr args)))
