(use panna)

(define kaava   "sox")


(define (install tynnyri)
  (use-clang)
  (commands
    '(make clean)
    '(make distclean)
    '(autoreconf -i)
    `(./configure ,(string-append "--prefix=" tynnyri)
                  )
    '(make -s)
    '(make install)))
