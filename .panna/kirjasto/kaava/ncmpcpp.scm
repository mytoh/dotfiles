(use panna)

(define kaava  (make-parameter "ncmpcpp"))
(define riisi (make-parameter (build-path (git-kansio) (kaava))))
(define panna   (make-parameter (resolve-path (sys-getenv "PANNA_PREFIX"))))
(define kellari (make-parameter (build-path (panna) "kellari")))
(define tynnyri (make-parameter (build-path (kellari) (kaava))))


(define (install)
  (use-clang)
  (commands
    '(./autogen.sh)
    `(./configure ,(string-append "--prefix=" (tynnyri))
                  --enable-outputs
                  --enable-visualizer
                  --enable-clock
                  --enable-unicode)
    '(make clean)
    '(make)
    '(make install)
    ))
