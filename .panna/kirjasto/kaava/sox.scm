(use panna.kaava)


(define kaava   "sox")


(define (install tynnyri)
  (use-clang)
  (system
    '(autoreconf -vfi)
    `(./configure ,(string-append "--prefix=" tynnyri)
                  )
    '(make -s)
    '(make install)))
