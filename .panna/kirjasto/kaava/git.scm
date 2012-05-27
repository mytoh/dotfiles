
(use panna.kaava)

(define kaava  "git")

(define (install tynnyri)
  (with-clang)
  (system
    '(gmake clean)
    `(gmake ,(string-append "prefix=" tynnyri))
    `(gmake ,(string-append "prefix=" tynnyri) install)
    ))
