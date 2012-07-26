#!/usr/bin/env gosh

(use gauche.process)
(use util.list) ; slices
(require-extension (srfi 1))    ; iota
(use kirjasto)

(define (colour-names)
  (let ((ls (slices (iota 256) 16))
        (colour-numbers (lambda (n)
                          (display
                            (format " ~a"
                                    (concat "[38;5;" (number->string n) "m"
                                            (number->string n) "[0m" ))))))
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

