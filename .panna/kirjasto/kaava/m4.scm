

(use panna.kaava)

(define kaava "m4")

(define repository  "git://git.sv.gnu.org/m4.git"  )	


(define (update)
  (run-process '(git pull) :wait #t))

(define (install tynnyri)
  (use-clang)
  (system
    '(gmake clean)
    '(./bootstrap)
    `(./configure ,(string-append "--prefix=" tynnyri))
    '(gmake)
    '(gmake install)
    ))
