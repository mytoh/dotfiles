(use kirjasto)
(use panna.kaava)

(define kaava          (make-parameter "gauche"))

(define (install tynnyri)
  (with-clang)
  (system
    '(./DIST gen)
    `(./configure ,(string-append "--prefix=" tynnyri)
                  --with-iconv=/usr/local
                  )
    '(make)
    '(make install)
    )
  )


