
(use panna)

(define kaava  "git")

(define (install tynnyri)
  (use-clang)
  (commands
    '(gmake clean)
    `(gmake ,(string-append "prefix=" tynnyri))
    `(gmake ,(string-append "prefix=" tynnyri) install)
    ))
