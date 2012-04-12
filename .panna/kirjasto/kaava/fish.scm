#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parameter)
(use file.util)
(use kirjasto)
(use panna)

(define kaava (make-parameter "fishfish"))
(define riisi-kansio (make-parameter (build-path (git-kansio) (kaava))))
(define panna-kansio  (make-parameter (resolve-path (sys-getenv "PANNA_PATH"))))
(define kellari-kansio (make-parameter (build-path (panna-kansio) "kellari")))
(define tynnyri-kansio (make-parameter (build-path (kellari-kansio) (kaava))))

(cond
  ((eq? (get-os-type) 'freebsd)
   (define (build)
     (use-clang)
     (sys-putenv "CPPFLAGS=-I/usr/local/include")
     (sys-putenv "LDFLAGS=-L/usr/local/lib")
     (commands
     `(./configure ,(string-append "--prefix=" (tynnyri-kansio)) --without-xsel)
     '(gmake clean)
     '(gmake)
     '(gmake install))))
  (else
    (define (build)
      (commands
      `(./configure ,(string-append "--prefix=" (tynnyri-kansio)))
      '(make distclean clean)
      '(make)
      '(make install)
      ))))

