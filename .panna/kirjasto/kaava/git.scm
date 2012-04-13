
(use panna)

(define kaava (make-parameter "git"))
(define riisi (make-parameter (build-path (git-kansio) (kaava))))
(define panna   (make-parameter (resolve-path (sys-getenv "PANNA_PREFIX"))))
(define kellari (make-parameter (build-path (panna) "kellari")))
(define tynnyri (make-parameter (build-path (kellari) (kaava))))

(define (install)
  (use-clang)
  (commands
    '(gmake clean)
    `(gmake ,(string-append "prefix=" (tynnyri)))
    `(gmake ,(string-append "prefix=" (tynnyri)) install)
    ))
