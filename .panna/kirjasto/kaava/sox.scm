#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parameter)
(use file.util)
(use kirjasto)
(load (build-path (sys-getenv "PANNA_PATH") "kirjasto" "ympäristö"))

(define kaava (make-parameter "sox"))
(define riisi-directory (make-parameter (build-path (git-kansio) (kaava))))
(define panna-directory   (make-parameter (resolve-path (sys-getenv "PANNA_PATH"))))
(define kellari-directory (make-parameter (build-path (panna-directory) "kellari")))
(define tynnyri-directory (make-parameter (build-path (kellari-directory) (kaava))))


(define (update)
  (run-process '(git pull) :wait #t))

(define (build)
  (use-clang)
  (commands
  '(autoreconf -i)
  '(make clean)
  '(make distclean)
  `(./configure ,(string-append "--prefix=" (tynnyri-directory)))
  '(make -s)
  '(make install)))
