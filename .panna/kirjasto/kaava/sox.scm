(use panna)

(define kaava (make-parameter "sox"))
(define riisi (make-parameter (build-path (git-kansio) (kaava))))
(define panna   (make-parameter (resolve-path (sys-getenv "PANNA_PREFIX"))))
(define kellari (make-parameter (build-path (panna) "kellari")))
(define tynnyri (make-parameter (build-path (kellari) (kaava))))


(define (install)
  (use-clang)
  (commands
    '(autoreconf -i)
    '(make clean)
    '(make distclean)
    `(./configure ,(string-append "--prefix=" (tynnyri)))
    '(make -s)
    '(make install)))
