#!/usr/bin/env gosh

(use gauche.process)
(use file.util)
(use kirjasto)

(define *package* "Gauche")
(define *gitdir* (build-path (home-directory) "local/git"))
(define *srcdir* (build-path *gitdir* *package*))
(define *stow-directory* (build-path (home-directory) "local/stow"))
(define *prefix-directory* (build-path *stow-directory* *package*))

(define (build)
  (run-process `(./configure ,(string-append "--prefix=" *prefix-directory*)) :wait #t)
  (run-process '(make clean) :wait #t)
  (run-process '(make) :wait #t)
  (run-process '(make install) :wait #t))

(define (stow-install)
  (cd *stow-directory*)
  (run-process `(stow -v ,*package*)) :wait #t)

(define (main args)
  (cd *srcdir*)
  (build)
  (stow-install))
