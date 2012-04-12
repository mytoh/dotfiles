#!/usr/bin/env gosh

(use gauche.process)
(use file.util)
(use gauche.parameter)
(use kirjasto)
(use panna)

(define kaava  (make-parameter "vim"))
(define riisi-kansio (make-parameter (build-path (hg-kansio) (kaava))))
(define panna-kansio   (make-parameter (resolve-path (sys-getenv "PANNA_PATH"))))
(define kellari-kansio (make-parameter (build-path (panna-kansio) "kellari")))
(define tynnyri-kansio (make-parameter (build-path (kellari-kansio) (kaava))))

(define (build)
  (use-clang)
  (commands
  '(gmake clean)
  '(gmake distclean)
  `(./configure   ,(string-append
                     "--prefix=" (tynnyri-kansio))
                  "--enable-multibyte"
                  "--enable-perlinterp=yes"
                  "--enable-pythoninterp=yes"
                  "--enable-xim"
                  "--enable-fontset"
                  "--disable-darwin"
                  "--disable-selinux"
                  "--with-x"
                  "--with-features=huge")
  '(gmake)
  '(gmake install)
  ))

