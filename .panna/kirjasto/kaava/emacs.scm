(use panna.kaava)

(define kaava "emacs")
(define homepage "http://gnu.org/s/emacs")
(define repository "git://git.savannah.gnu.org/emacs.git")

(define (install tynnyri)
  (use-clang)
  (system
    '(gmake clean)
    '(gmake distclean)
    '(./autogen.sh)
    `(./configure ,(string-append "--prefix=" tynnyri))
    '(gmake)
    '(gmake install)
    ))

