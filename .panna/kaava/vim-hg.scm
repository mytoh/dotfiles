#!/usr/bin/env gosh

(use gauche.process)
(use file.util)
(use gauche.parameter)
(use kirjasto)
(load (build-path (sys-getenv "PANNA_PATH") "ympäristö"))

(define kaava  (make-parameter "vim"))
(define srcdir (make-parameter (build-path (hgdir) (kaava))))
(define panna-directory   (make-parameter (resolve-path (sys-getenv "PANNA_PATH"))))
(define kellari-directory (make-parameter (build-path (panna-directory) "kellari")))
(define tynnyri-directory (make-parameter (build-path (kellari-directory) (kaava))))

(define (update)
  (run-command '(hg pull))
  (run-command '(hg update)))

(define (build)
  (run-process '(make clean) :wait #t)
  (run-process '(make distclean) :wait #t)
  (sys-putenv "CC=clang")
  (run-process `(./configure   ,(string-append "--prefix=" (tynnyri-directory)) "--enable-multibyte" "--enable-perlinterp=yes" "--enable-pythoninterp=yes" "--enable-xim" "--enable-fontset" "--disable-darwin" "--disable-selinux" "--with-x" "--with-features=huge") :wait #t)
  (run-process '(make) :wait #t)
  (run-process '(make install) :wait #t))

(define (stow-install)
  (run-process `(stow -v ,(kaava) -d ,(kellari-directory) -t ,(panna-directory))) :wait #t)
