
(use panna.kaava)
(use file.util)

(define kaava "tmux")

(define (install tynnyri)
  (make-directory* "etc" )
  (system
    ; '(make clean)
    ; '(make distclean)
    '(aclocal)
    '(automake --add-missing --force-missing --copy --foreign)
    '(autoreconf)
    `(./configure ,(string-append "--prefix=" tynnyri)
                  ,(string-append "--exec-prefix=" tynnyri))
    '(make)
    '(make install)
    ))
