(use panna.kaava)


(define kaava   "sox")


(define (install tynnyri)
  (use-clang)
    (sys-putenv "CFLAGS=-I/usr/local/include")
    (sys-putenv "LDFLAGS=-L/usr/local/lib")
  (system
    '(autoreconf -vfi)
    `(./configure ,(string-append "--prefix=" tynnyri)
                  )
    '(make -s)
    '(make install)
    '(make clean)
    '(make distclean)
    ))
