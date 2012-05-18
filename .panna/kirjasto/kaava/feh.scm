
(use kirjasto)
(use panna.kaava)

(define kaava   "feh")
(define homepage "dummy")

(cond
  ; freebsd
  ((eq? (get-os-type) 'freebsd)
   (define (install tynnyri)
     (system 
       '(gmake clean))
     (sys-putenv (string-append "PREFIX=" tynnyri))
     (sys-putenv (string-append "CFLAGS=" "-w -I/usr/local/include -L/usr/local/lib" ))
     (print  (sys-getenv "CFLAGS"))
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

