#!/usr/bin/env gosh

(use gauche.process)
(use util.list) ; slices
(require-extension (srfi 1))    ; iota

(define (colour-names)
  (let ((ls (slices (iota 256) 16))
        (colour-numbers (lambda (n)
                          (display
                            (format " ~a"
                                    (string-append "[38;5;" (x->string n) "m" (x->string n) "[0m" ))))))
    (newline)

    (print "system colours")
    (for-each colour-numbers
              (car ls))
    (newline)
    (newline)

    (print "other colours")
    (let loop ((l (cdr ls)))
      (cond 
        ((null? l)  
        '())  
         (else
          (for-each colour-numbers
            (car l))
          (newline)
          (loop (cdr l)))))))

(define (main args)
  (colour-names))

