(use panna.kaava)

(define kaava   "mplayer")

(define (install tynnyri)
  (system
    `(./configure   ,(string-append "--prefix=" tynnyri))
    '(gmake)
    '(gmake install)
    '(gmake clean)
    '(gmake distclean)
    ))
