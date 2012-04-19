(use panna.kaava)

(define kaava   "mplayer")


(define (install tynnyri)
  (system
  '(gmake clean)
  '(gmake distclean)
  `(./configure   ,(string-append "--prefix=" tynnyri))
  '(gmake)
  '(gmake install)
  ))
