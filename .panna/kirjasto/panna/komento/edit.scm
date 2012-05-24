#!/usr/bin/env gosh

(use file.util)
(use gauche.process)
(use panna.ympäristö)
(use gauche.parameter)

(define (edit pullo)
  (let ((kaava-tiedosto (find-file-in-paths (string-append pullo ".scm")
                                            :paths `(,kaava-kansio)
                                            :pred file-is-readable?))
        (editor (sys-getenv "EDITOR")))

    (cond 
      (editor
        (run-process `(,editor ,kaava-tiedosto) :wait #t))
      (else
        (run-process `(vim     ,kaava-tiedosto) :wait #t)))))




(define (main args)
  (if (<= 2 (length args))
    (edit (cadr args))
    (print "you need specify one kaava name")
    )
  )
