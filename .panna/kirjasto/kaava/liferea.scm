
(use panna.kaava)

(define kaava   "liferea")

(define (install tynnyri)
  (with-clang)
  (system
  '(gmake clean)
  '(gmake distclean)
  '(./autogen.sh)
  `(./configure   ,(string-append "--prefix=" tynnyri))
  '(gmake)
  '(gmake install)
  ))
