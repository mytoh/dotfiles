

(use gauche.process)
(use gauche.parameter)
(use file.util)
(use kirjasto)
(use panna)

(define kaava (make-parameter "dswm"))
(define riisi-kansio (make-parameter (build-path (git-kansio) (kaava))))
(define panna-kansio   (make-parameter (resolve-path (sys-getenv "PANNA_PATH"))))
(define kellari-kansio (make-parameter (build-path (panna-kansio) "kellari")))
(define tynnyri-kansio (make-parameter (build-path (kellari-kansio) (kaava))))

(define (build)
  (use-clang)
  (commands
    '(make clean)
    '(make distclean)
    '(autoconf)
    `(./configure ,(string-append "--prefix=" (tynnyri-kansio)))
    '(make)
    '(make install)
    ))
