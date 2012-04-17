
(use file.util)
(use kirjasto)
(use panna)

(define kaava  "dswm")
(define riisi (build-path (git-kansio) kaava))

(define homepage "http://dss-project.org")

(define (install tynnyri)
  (use-clang)
  (commands
    '(make clean)
    '(make distclean)
    '(autoconf)
    `(./configure ,(string-append "--prefix=" tynnyri)
                  )
    '(make)
    '(make install)
    ))
