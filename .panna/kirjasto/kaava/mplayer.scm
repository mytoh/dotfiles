(use panna)

(define kaava   "mplayer")


(define (install tynnyri)
  (commands
  '(gmake clean)
  '(gmake distclean)
  `(./configure   ,(string-append "--prefix=" tynnyri))
  '(gmake)
  '(gmake install)
  ))
