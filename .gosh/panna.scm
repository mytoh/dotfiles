#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use util.match)
(use file.util)

(define-constant kaava-directory
  (build-path (sys-getenv "PANNA_PATH") "kirjasto" "kaava"))


(define (load-build-file app)
  (load (find-file-in-paths (string-append app ".scm")
                            :paths `(,kaava-directory)
                            :pred file-is-readable?)))

(define (usage status)
  (exit status "usage: ~a <command> <package-name>\n" *program-name*))

(define (main args)
  (let-args (cdr args)
    ((#f "h|help" (usage 0))
     . rest)
    (load-build-file (cadr rest))
    (cd (srcdir))
    (match (car rest)
      ((or "update" "up")
       (update))
      ("build"
       (build))
      ("install"
       (build)
       (stow-install))
      (_ (usage 1))))
  0)

