(use panna.kaava)

(define kaava   "sox")


(define (install tynnyri)
  (use-clang)
  (system
    '(make clean)
    '(make distclean)
    '(autoreconf -i)
    `(./configure ,(string-append "--prefix=" tynnyri)
                  )
    '(make -s)
    '(make install)))
