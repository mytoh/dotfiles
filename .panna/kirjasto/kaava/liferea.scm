
(use panna)

(define kaava   "liferea")

(define (install tynnyri)
  (use-clang)
  (commands
  '(./autogen.sh)
  '(gmake clean)
  '(gmake distclean)
  `(./configure   ,(string-append "--prefix=" tynnyri))
  '(gmake)
  '(gmake install)
  ))
