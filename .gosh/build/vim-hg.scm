#!/usr/bin/env gosh

(use gauche.process)
(use file.util)
(use kirjasto)

(define *package* "vim")
(define *hgdir* (build-path (home-directory) "local/hg"))
(define *srcdir* (build-path *hgdir* *package*))
(define *stow-directory* (build-path (home-directory) "local/stow"))
(define *prefix-directory* (build-path *stow-directory* *package*))

(define (update)
  (run-process '(hg pull))
  (run-process '(hg update)))

(define (build)
  (run-process `(./configure   ,(string-append "--prefix=" *prefix-directory*) "--enable-multibyte" "--enable-perlinterp=yes" "--enable-xim" "--enable-fontset" "--disable-darwin" "--disable-selinux" "--with-x" "--with-features=huge") :wait #t)
  (run-process '(make clean) :wait #t)
  (run-process '(make) :wait #t)
  (run-process '(make install) :wait #t))

(define (stow-install)
  (cd *stow-directory*)
  (run-process `(stow -v ,*package*)))

(define (main args)
  (print *prefix-directory*)
  (cd *srcdir*)
  (update)
  (build)
  (stow-install))
