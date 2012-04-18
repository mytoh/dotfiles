
(use kirjasto)
(use panna)

(define kaava   "feh")

(define homepage "dummy")

(cond
  ; freebsd
  ((eq? (get-os-type) 'freebsd)
   (define (install tynnyri)
     (sys-putenv (string-append "PREFIX=" tynnyri))
     (use-clang)
     (commands
     '(gmake clean)
     '(gmake)
     '(gmake install)
     )))

  (else
    (define (install)
      (sys-putenv (string-append "PREFIX=" tynnyri))
      (use-clang)
      (commands
      '(make clean)
      '(make)
      '(make install)))
    ))

