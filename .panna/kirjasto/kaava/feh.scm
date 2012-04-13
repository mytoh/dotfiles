
(use kirjasto)
(use panna)

(define kaava  (make-parameter "feh"))
(define riisi (make-parameter (build-path (git-kansio) (kaava))))
(define panna   (make-parameter (resolve-path (sys-getenv "PANNA_PREFIX"))))
(define kellari (make-parameter (build-path (panna) "kellari")))
(define tynnyri (make-parameter (build-path (kellari) (kaava))))

(cond
  ; freebsd
  ((eq? (get-os-type) 'freebsd)
   (define (install)
     (sys-putenv (string-append "PREFIX=" (tynnyri)))
     (use-clang)
     (commands
     '(gmake clean)
     '(gmake)
     '(gmake install)
     )))

  (else
    (define (install)
      (sys-putenv (string-append "PREFIX=" (tynnyri)))
      (use-clang)
      (commands
      '(make clean)
      '(make)
      '(make install)))
    ))

