(use kirjasto)
(use panna.kaava)

(define kaava          (make-parameter "gauche"))

(define (install tynnyri)
  (use-clang)
  (system
    '(./DIST gen)
    `(./configure ,(string-append "--prefix=" tynnyri)
                  --with-iconv=/usr/local
                  )
    '(make)
    '(make install)
    )
  )


