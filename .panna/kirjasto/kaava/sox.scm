(use panna.kaava)


(define kaava   "sox")


(define (install tynnyri)
    (sys-putenv "CPPFLAGS=-I/usr/local/include")
    (sys-putenv "LDFLAGS=-L/usr/local/lib")
  (with-clang)
  (system
    '(autoreconf -vfi)
    `(./configure ,(string-append "--prefix=" tynnyri)
                  )
    '(make -s)
    '(make install)
    '(make clean)
    '(make distclean)
    ))
