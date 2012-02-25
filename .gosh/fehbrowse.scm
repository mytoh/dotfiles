#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use util.match)
(use file.util)

(define (usage status) (exit status "usage: ~a <file>\n" *program-name*))

(define (main args)
  (let-args (cdr args) ((#f "h|help" (usage 0)) . args)
    (match (car args)
      ((? file-is-directory? dir)
       (run-process `(feh ,dir)) :wait #t)
      ((? file-is-regular? file)
       (run-process `(feh "-Z" "-F" ,(sys-dirname (resolve-path file))) :wait #t))
      (_ (usage 1))))
  0)
