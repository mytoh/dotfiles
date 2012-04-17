(use kirjasto)
(use panna)

(define kaava  "fishfish")
(define riisi  (build-path (git-kansio) kaava))

(cond
  ((eq? (get-os-type) 'freebsd)
   (define (install tynnyri)
     (use-clang)
     (sys-putenv "CPPFLAGS=-I/usr/local/include")
     (sys-putenv "LDFLAGS=-L/usr/local/lib")
     (commands
     `(./configure ,(string-append "--prefix=" tynnyri) --without-xsel)
     '(gmake clean)
     '(gmake)
     '(gmake install))))
  (else
    (define (install tynnyri) 
      (commands
      `(./configure ,(string-append "--prefix=" tynnyri))
      '(make distclean clean)
      '(make)
      '(make install)
      ))))

