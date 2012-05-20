(use panna.kaava)

(define kaava  "ncmpcpp")


(define (install tynnyri)
  ; (use-clang)
  (use-panna-library)
  (system
    '(./autogen.sh)
    `(./configure ,(string-append "--prefix=" tynnyri)
                  --enable-outputs
                  --enable-visualizer
                  --enable-clock
                  --enable-unicode)
    '(make)
    '(make install)
    '(make clean)
    ))
