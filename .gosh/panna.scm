#!/usr/bin/env gosh

(use gauche.process)
(use file.util)

(define-constant *apps-directory*
  (build-path (home-directory) ".gosh/build"))


(define (panna app)
  (run-process `(gosh ,(find-file-in-paths (string-append app ".scm")
                          :paths `(,*apps-directory*)
                          :pred file-is-readable?))
                   :wait #t))

(define (main args)
  (panna (cadr args))
  0)
