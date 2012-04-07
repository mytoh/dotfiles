#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parameter)
(use file.util)
(use kirjasto)
(load (build-path (sys-getenv "PANNA_PATH") "kirjasto" "ympäristö"))

(define kaava  (make-parameter "ncmpcpp"))
(define srcdir (make-parameter (build-path (git-kansio) (kaava))))
(define panna-directory   (make-parameter (resolve-path (sys-getenv "PANNA_PATH"))))
(define kellari-directory (make-parameter (build-path (panna-directory) "kellari")))
(define tynnyri-directory (make-parameter (build-path (kellari-directory) (kaava))))


(define (update)
  (run-process '(git pull) :wait #t))

(define (build)
  (use-clang)
  (run-process '(./autogen.sh) :wait #t)
  (run-process `(./configure ,(string-append "--prefix=" (tynnyri-directory))
                             --enable-outputs
                             --enable-visualizer
                             --enable-clock
                             --enable-unicode
                             ) :wait #t)
  (run-process '(make clean) :wait #t)
  (run-process '(make) :wait #t)
  (run-process '(make install) :wait #t))

(define (stow-install)
  (run-process `(stow -v ,(kaava) -d ,(kellari-directory) -t ,(panna-directory))) :wait #t)
