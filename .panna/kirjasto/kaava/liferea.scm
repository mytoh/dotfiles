
(use panna.kaava)

(define kaava   "liferea")

(define (install tynnyri)
  (use-clang)
  (system
  '(./autogen.sh)
  '(gmake clean)
  '(gmake distclean)
  `(./configure   ,(string-append "--prefix=" tynnyri))
  '(gmake)
  '(gmake install)
  ))
