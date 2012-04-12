
(use gauche.process)
(use gauche.parameter)
(use file.util)
(use kirjasto)
(use panna)

(define kaava  (make-parameter "feh"))
(define riisi-kansio (make-parameter (build-path (git-kansio) (kaava))))
(define panna-kansio   (make-parameter (resolve-path (sys-getenv "PANNA_PATH"))))
(define kellari-kansio (make-parameter (build-path (panna-kansio) "kellari")))
(define tynnyri-kansio (make-parameter (build-path (kellari-kansio) (kaava))))

(cond
  ((eq? (get-os-type) 'freebsd)
   (define (build)
     (sys-putenv (string-append "PREFIX=" (tynnyri-kansio)))
     (use-clang)
     (commands
     '(gmake clean)
     '(gmake)
     '(gmake install)
     )))

     ; (run-process '(gmake clean) :wait #t)
     ; (run-process '(gmake) :wait #t)
     ; (run-process '(gmake install) :wait #t)))

  (else
    (define (build)
      (sys-putenv (string-append "PREFIX=" (tynnyri-kansio)))
      (use-clang)
      (commands
      '(make clean)
      '(make)
      '(make install)))
    ))

