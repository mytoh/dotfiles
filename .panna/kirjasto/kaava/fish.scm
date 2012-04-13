(use kirjasto)
(use panna)

(define kaava (make-parameter "fishfish"))
(define riisi (make-parameter (build-path (git-kansio) (kaava))))
(define panna  (make-parameter (resolve-path (sys-getenv "PANNA_PREFIX"))))
(define kellari (make-parameter (build-path (panna) "kellari")))
(define tynnyri (make-parameter (build-path (kellari) (kaava))))

(cond
  ((eq? (get-os-type) 'freebsd)
   (define (install)
     (use-clang)
     (sys-putenv "CPPFLAGS=-I/usr/local/include")
     (sys-putenv "LDFLAGS=-L/usr/local/lib")
     (commands
     `(./configure ,(string-append "--prefix=" (tynnyri)) --without-xsel)
     '(gmake clean)
     '(gmake)
     '(gmake install))))
  (else
    (define (install)
      (commands
      `(./configure ,(string-append "--prefix=" (tynnyri)))
      '(make distclean clean)
      '(make)
      '(make install)
      ))))

