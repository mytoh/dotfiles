

(use panna.kaava)

(define kaava "tmux")

(define (install tynnyri)
  (use-clang)
  (system
    '(make clean)
    '(make distclean)
    '(aclocal)
    '(automake --add-missing --force-missing --copy --foreign)
    '(autoreconf)
    `(./configure ,(string-append "--prefix=" tynnyri))
    '(make)
    '(make install)
    ))
