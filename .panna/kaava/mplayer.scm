#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parameter)
(use file.util)
(use kirjasto)
(load (build-path (sys-getenv "PANNA_PATH") "ympäristö"))

(define kaava  (make-parameter "mplayer"))
(define srcdir (make-parameter (build-path (svndir) (kaava))))
(define panna-directory   (make-parameter (resolve-path (sys-getenv "PANNA_PATH"))))
(define kellari-directory (make-parameter (build-path (panna-directory) "kellari")))
(define tynnyri-directory (make-parameter (build-path (kellari-directory) (kaava))))

(define (update)
  (run-command '(svn update)))

(define (build)
  (run-process '(gmake clean) :wait #t)
  (run-process '(gmake distclean) :wait #t)
  (sys-putenv "CC=clang")
  (run-process `(./configure   ,(string-append "--prefix=" (tynnyri-directory))) :wait #t)
  (run-process '(gmake) :wait #t)
  (run-process '(gmake install) :wait #t))

(define (stow-install)
  (run-process `(stow -v ,(kaava) -d ,(kellari-directory) -t ,(panna-directory))) :wait #t)
