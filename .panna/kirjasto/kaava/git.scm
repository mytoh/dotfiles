#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parameter)
(use file.util)
(use kirjasto)
(load (build-path (sys-getenv "PANNA_PATH") "kirjasto" "ympäristö"))

(define kaava (make-parameter "git"))
(define riisi-directory (make-parameter (build-path (gitdir) (kaava))))
(define panna-directory   (make-parameter (resolve-path (sys-getenv "PANNA_PATH"))))
(define kellari-directory (make-parameter (build-path (panna-directory) "kellari")))
(define tynnyri-directory (make-parameter (build-path (kellari-directory) (kaava))))


(define (update)
  (run-process '(git pull) :wait #t))

(cond
  ((eq? (get-os-type) 'freebsd)
   (define (build)
     (use-clang)
     (run-process '(gmake clean) :wait #t)
     (run-process `(gmake ,(string-append "prefix=" (tynnyri-directory))) :wait #t)
     (run-process `(gmake ,(string-append "prefix=" (tynnyri-directory)) install)) :wait #t))
  (else
    (define (build)
      (sys-putenv (string-append "PREFIX=" (tynnyri-directory)))
      (use-clang)
      (run-process '(make clean) :wait #t)
      (run-process '(make) :wait #t)
      (run-process '(make install) :wait #t))))
