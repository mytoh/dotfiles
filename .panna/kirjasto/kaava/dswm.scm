
(use gauche.process)
(use gauche.parameter)
(use file.util)
(use kirjasto)
(use panna)

(define kaava (make-parameter "dswm"))
(define riisi (make-parameter (build-path (git-kansio) (kaava))))
(define panna   (make-parameter (resolve-path (sys-getenv "PANNA_PREFIX"))))
(define kellari (make-parameter (build-path (panna) "kellari")))
(define tynnyri (make-parameter (build-path (kellari) (kaava))))

(define (install)
  (use-clang)
  (commands
    '(make clean)
    '(make distclean)
    '(autoconf)
    `(./configure ,(string-append "--prefix=" (tynnyri)))
    '(make)
    '(make install)
    ))
