

(use panna.kaava)

(define kaava "m4")

(define repository  "git://git.sv.gnu.org/m4.git"  )	


(define (install tynnyri)
  (with-clang)
  (system
    '(gmake clean)
    '(./bootstrap)
    `(./configure ,(string-append "--prefix=" tynnyri))
    '(gmake)
    '(gmake install)
    ))
