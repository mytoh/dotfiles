(use panna.kaava)

(define kaava  "fish")

(cond
  ((eq? (get-os-type) 'freebsd)
   (define (install tynnyri)
     (use-clang)
     (sys-putenv "CPPFLAGS=-I/usr/local/include")
     (sys-putenv "LDFLAGS=-L/usr/local/lib")
     (system
       '(autoconf)
     `(./configure ,(string-append "--prefix=" tynnyri) --without-xsel)
     '(gmake)
     '(gmake install)
     '(gmake clean)
     )))
  (else
    (define (install tynnyri)
      (system
      '(make distclean clean)
      `(./configure ,(string-append "--prefix=" tynnyri))
      '(make)
      '(make install)))))

