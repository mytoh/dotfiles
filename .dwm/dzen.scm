#!/usr/bin/env gosh

(use gauche.process)
(use file.util)

(define (date)
  (let* ((d (process-output->string '(date) ))
        (date (format
             #f
             "^fg(#607080)~a\n"
             d)))
       (display date)))

(define (main args)
  (date)
  )
