#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parameter)
(use file.util)
(use kirjasto)
(use panna)

(define kaava  (make-parameter "ncmpcpp"))
(define riisi-kansio (make-parameter (build-path (git-kansio) (kaava))))
(define panna-kansio   (make-parameter (resolve-path (sys-getenv "PANNA_PATH"))))
(define kellari-kansio (make-parameter (build-path (panna-kansio) "kellari")))
(define tynnyri-kansio (make-parameter (build-path (kellari-kansio) (kaava))))


(define (build)
  (use-clang)
  (commands
    '(./autogen.sh)
    `(./configure ,(string-append "--prefix=" (tynnyri-kansio))
                  --enable-outputs
                  --enable-visualizer
                  --enable-clock
                  --enable-unicode)
    '(make clean)
    '(make)
    '(make install)
    ))
