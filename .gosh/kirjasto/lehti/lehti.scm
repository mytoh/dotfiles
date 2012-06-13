#!/usr/bin/env gosh
;; -*- coding: utf-8 -*-

(use gauche.process)
(use gauche.parseopt)
(use util.match)
(use file.util)
(require-extension
  (srfi 1))
(use kirjasto.verkko.scm)

(define *lehti-dist-directory*
  (build-path (home-directory)
              ".lehti/dist"))

(define *lehti-cache-directory*
  (build-path (home-directory)
              ".lehti/cache"))

(define (usage status)
  (exit status "usage: ~a <command> <package-name>\n" *program-name*))

(define package-list
  (lambda ()
    (file->sexp-list
      "lehtifile")))

(define install
  (lambda (package)
    (let ((lehtifile (string-append package
                                    ".leh"))
          (prefix-directory  (build-path  *lehti-dist-directory*
                                          package)))
      (and-let*
        ((url  (cadr  (assoc 'url (file->sexp-list lehtifile))))
         (commands (cadr (assoc 'install (file->sexp-list lehtifile)))))
        (current-directory (fetch url package))
        (for-each
          (lambda (c) ( eval c (interaction-environment)))
          commands)
        (remove-directory* (build-path *lehti-cache-directory* package))
        ))))


(define fetch
  (lambda (url package)
    (let ((tmpdir *lehti-cache-directory*))
      (make-directory* tmpdir)
      (current-directory tmpdir)
      (cond
        ((url-is-git? url)
             (run-process `(git clone ,url ,package) :wait #t))
        (else
          exit)
        )
      (build-path tmpdir package)
      )))

(define lehti
  (lambda (args)
    (let-args (cdr args)
      ((#f "h|help" (usage 0))
       . rest)
      (when (null-list? rest)
        (usage 0))
      (match (car  rest)
        ("install"
         (install (cadr rest))) 

        (_ (usage 0))))))



(define (main args)
  (lehti args))
