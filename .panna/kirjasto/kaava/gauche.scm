(use kirjasto)
(use panna)

(define kaava          (make-parameter "gauche"))

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


