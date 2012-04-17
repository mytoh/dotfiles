
(use panna)

(define kaava  "git")
(define riisi  (build-path (git-kansio) kaava))

(define (install tynnyri)
  (use-clang)
  (commands
    '(gmake clean)
    `(gmake ,(string-append "prefix=" tynnyri))
    `(gmake ,(string-append "prefix=" tynnyri) install)
    ))
