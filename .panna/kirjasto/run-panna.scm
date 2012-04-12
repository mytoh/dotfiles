#!/usr/bin/env gosh

;  .-----.---.-.-----.-----.---.-.
;  |  _  |  _  |     |     |  _  |
;  |   __|___._|__|__|__|__|___._|
;  |_|

(use gauche.process)
(use gauche.parseopt)
(use gauche.parameter)
(use util.match)
(use file.util)

(use panna)

(define (usage status)
  (exit status "usage: ~a <command> <package-name>\n" *program-name*))

(define (main args)
  (let-args (cdr args)
    ((#f "h|help" (usage 0))
     . rest)
    (let ((app (cadr rest)))
      (load-build-file app)
      (cd (riisi-kansio))
      (match (car rest)
        ((or "update" "up")
         (update))
        ("build"
         (build))
        ("install"
         (build)
         (install app))
        ("edit"
         (edit app))
        (_ (usage 1))))
    )
  0)

