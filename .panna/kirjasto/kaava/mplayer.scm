(use panna)

(define kaava  (make-parameter "mplayer"))
(define riisi (make-parameter (build-path (svn-kansio) (kaava))))
(define panna   (make-parameter (resolve-path (sys-getenv "PANNA_PREFIX"))))
(define kellari (make-parameter (build-path (panna) "kellari")))
(define tynnyri (make-parameter (build-path (kellari) (kaava))))


(define (install)
  (commands
  '(gmake clean)
  '(gmake distclean)
  `(./configure   ,(string-append "--prefix=" (tynnyri)))
  '(gmake)
  '(gmake install)
  ))
