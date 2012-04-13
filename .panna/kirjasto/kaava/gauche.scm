(use kirjasto)
(use panna)

(define kaava          (make-parameter "Gauche"))
(define riisi   (make-parameter (build-path (git-kansio) (kaava))))
(define panna   (make-parameter (resolve-path (sys-getenv "PANNA_PREFIX"))))
(define kellari (make-parameter (build-path (panna) "kellari")))
(define tynnyri (make-parameter (build-path (kellari) (kaava))))

(define (install)
  (use-clang)
  (commands
    '(make clean)
    '(make distclean)

    '(./DIST gen)
    `(./configure ,(string-append "--prefix=" (tynnyri))
                  --with-iconv=/usr/local
                  )
    '(make)
    '(make install)
    ))


