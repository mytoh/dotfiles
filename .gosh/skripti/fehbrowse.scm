#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use util.match)
(use file.util)
(use kirjasto.arkisto)
(load "unpack.scm")

(define (usage status) (exit status "usage: ~a <file>\n" *program-name*))


(define (main args)
  (cond ((< (length args) 2)
    (run-process `(feh) :wait #t))
    (else
    (let-args (cdr args) ((#f "h|help" (usage 0)) . args)
      (match (car args)
        ((? file-is-directory? dir)
         (run-process `(feh "-F" ,dir)) :wait #t)
        ((? file-is-archive? file)
         (let ((temp (build-path
                       (temporary-directory)
                       "fehbrowse"
                       (string-incomplete->complete
                         (sys-basename
                           (path-sans-extension file))))))
           (make-directory* temp)
           (unpack file temp)
           (run-process `(feh -F -Z -r -q ,temp) :wait #t)
           (remove-directory* temp)
           ))
        ((? file-is-regular? file)
         (run-process `(feh -Z -F  -q --start-at ,(sys-realpath file) ,(sys-dirname (sys-realpath file))) :wait #t))
        (_ (usage 1))))))
  0)
