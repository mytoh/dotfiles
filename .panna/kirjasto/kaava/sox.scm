#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parameter)
(use file.util)
(use kirjasto)
(load (build-path (sys-getenv "PANNA_PATH") "kirjasto" "ympäristö"))

(define kaava (make-parameter "sox"))
(define riisi-directory (make-parameter (build-path (gitdir) (kaava))))
(define panna-directory   (make-parameter (resolve-path (sys-getenv "PANNA_PATH"))))
(define kellari-directory (make-parameter (build-path (panna-directory) "kellari")))
(define tynnyri-directory (make-parameter (build-path (kellari-directory) (kaava))))


(define (update)
  (run-process '(git pull) :wait #t))

(define (build)
  (use-clang)
  (run-process '(autoreconf -i))
  (run-process '(make clean) :wait #t)
  (run-process '(make distclean) :wait #t)
  (run-process `(./configure ,(string-append "--prefix=" (tynnyri-directory))) :wait #t)
  (run-process '(make -s) :wait #t)
  (run-process '(make install) :wait #t))
