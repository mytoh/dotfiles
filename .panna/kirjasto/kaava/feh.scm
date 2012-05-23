
(use panna.kaava)

(define kaava   "feh")
(define homepage "dummy")

(cond
  ; freebsd
  ((eq? (get-os-type) 'freebsd)
   (define (install tynnyri)
     (system
       '(gmake clean))
     (add-environment-variable "PREFIX" tynnyri)
     (add-environment-variable "CPPFLAGS" "-I/usr/local/include")
     (add-environment-variable "LDFLAGS"   "-L/usr/local/lib")
     (use-clang)
     (system
       '(gmake)
       '(gmake install)
       )))

  (else
    (define (install tynnyri)
      (sys-putenv (string-append "PREFIX=" tynnyri))
      (use-clang)
      (system
        '(make clean)
        '(make)
        '(make install)))
    ))

