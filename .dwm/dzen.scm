#!/usr/bin/env gosh

(use gauche.process)
(use file.util)

(define (date)
  (let* ((d (process-output->string '(date) ))
        (date (format
             #f
             "^fg(#607080)~10@a\n"
             d)))
       (display date)))

;(define (cpu)
  ;(let* (())
        ;))

(define (main args)
  (date)
  )
