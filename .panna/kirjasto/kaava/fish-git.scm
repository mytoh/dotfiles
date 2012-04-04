#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parameter)
(use file.util)
(use kirjasto)
(load (build-path (sys-getenv "PANNA_PATH") "kirjasto" "ympäristö"))

(define kaava (make-parameter "fishfish"))
(define riisi-directory (make-parameter (build-path (gitdir) (kaava))))
(define panna-directory  (make-parameter (resolve-path (sys-getenv "PANNA_PATH"))))
(define kellari-directory (make-parameter (build-path (panna-directory) "kellari")))
(define tynnyri-directory (make-parameter (build-path (kellari-directory) (kaava))))

(define (update)
  (run-process '(git pull) :wait #t))

(cond
  ((eq? (get-os-type) 'freebsd)
   (define (build)
     (use-clang)
     (sys-putenv "CPPFLAGS=-I/usr/local/include")
     (sys-putenv "LDFLAGS=-L/usr/local/lib")
     (run-process `(./configure ,(string-append "--prefix=" (tynnyri-directory)) --without-xsel) :wait #t)
     (run-process '(gmake clean) :wait #t)
     (run-process '(gmake) :wait #t)
     (run-process '(gmake install) :wait #t)))
  (else
    (define (build)
      (run-process `(./configure ,(string-append "--prefix=" (tynnyri-directory))) :wait #t)
      (run-process '(make distclean clean) :wait #t)
      (run-process '(make) :wait #t)
      (run-process '(make install) :wait #t))))

