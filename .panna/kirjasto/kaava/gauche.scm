(use kirjasto)
(use panna.kaava)

(define kaava          (make-parameter "gauche"))

(define (install)
  (use-clang)
  (system
    '(make clean)
    '(make distclean)

    '(./DIST gen)
    `(./configure ,(string-append "--prefix=" (tynnyri))
                  --with-iconv=/usr/local
                  )
    '(make)
    '(make install)
    ))


