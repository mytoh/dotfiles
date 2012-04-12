#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parameter)
(use file.util)
(use kirjasto)
(use panna)

(define kaava  (make-parameter "liferea"))
(define riisi-kansio (make-parameter  (build-path (git-kansio) (kaava))))
(define panna-kansio   (make-parameter (resolve-path (sys-getenv "PANNA_PATH"))))
(define kellari-kansio (make-parameter (build-path (panna-kansio) "kellari")))
(define tynnyri-kansio (make-parameter (build-path (kellari-kansio) (kaava))))

(define (build)
  (use-clang)
  (commands
  '(./autogen.sh)
  '(gmake clean)
  '(gmake distclean)
  `(./configure   ,(string-append "--prefix=" (tynnyri-kansio)))
  '(gmake)
  '(gmake install)
  ))
