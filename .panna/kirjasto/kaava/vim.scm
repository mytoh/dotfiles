#!/usr/bin/env gosh

(use gauche.process)
(use file.util)
(use gauche.parameter)
(use kirjasto)
(load (build-path (sys-getenv "PANNA_PATH") "kirjasto" "ympäristö"))

(define kaava  (make-parameter "vim"))
(define riisi-directory (make-parameter (build-path (hgdir) (kaava))))
(define panna-directory   (make-parameter (resolve-path (sys-getenv "PANNA_PATH"))))
(define kellari-directory (make-parameter (build-path (panna-directory) "kellari")))
(define tynnyri-directory (make-parameter (build-path (kellari-directory) (kaava))))

(define (update)
  (run-command '(hg pull))
  (run-command '(hg update)))

(define (build)
  (use-clang)
  (run-process '(gmake clean) :wait #t)
  (run-process '(gmake distclean) :wait #t)
  (run-process `(./configure   ,(string-append 
                                  "--prefix=" (tynnyri-directory))
                               "--enable-multibyte"
                               "--enable-perlinterp=yes"
                               "--enable-pythoninterp=yes"
                               "--enable-xim"
                               "--enable-fontset"
                               "--disable-darwin"
                               "--disable-selinux"
                               "--with-x"
                               "--with-features=huge")
               :wait #t)
  (run-process '(gmake)         :wait #t)
  (run-process '(gmake install) :wait #t))

