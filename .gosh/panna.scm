#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use util.match)
(use file.util)
(require-extension
  (srfi 98))
(load (build-path (sys-getenv "PANNA_PATH") "kirjasto" "komento"))


(define (usage status)
  (exit status "usage: ~a <command> <package-name>\n" *program-name*))

(define (main args)
  (let-args (cdr args)
    ((#f "h|help" (usage 0))
     . rest)
    (load-build-file (cadr rest))
    (cd (riisi-directory))
    (match (car rest)
      ((or "update" "up")
       (update))
      ("build"
       (build))
      ("install"
       (build)
       (install))
      ("edit"
       (edit (cadr rest)))
      (_ (usage 1))))
  0)

