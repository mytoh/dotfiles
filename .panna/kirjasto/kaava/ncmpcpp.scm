(use panna)

(define kaava  "ncmpcpp")


(define (install tynnyri)
  (use-clang)
  (commands
    '(./autogen.sh)
    `(./configure ,(string-append "--prefix=" tynnyri)
                  --enable-outputs
                  --enable-visualizer
                  --enable-clock
                  --enable-unicode)
    '(make clean)
    '(make)
    '(make install)
    ))
