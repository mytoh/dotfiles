(use panna)

(define kaava  (make-parameter "vim"))
(define riisi (make-parameter (build-path (hg-kansio) (kaava))))
(define panna   (make-parameter (resolve-path (sys-getenv "PANNA_PREFIX"))))
(define kellari (make-parameter (build-path (panna) "kellari")))
(define tynnyri (make-parameter (build-path (kellari) (kaava))))

(define (install)
  (use-clang)
  (commands
  '(gmake clean)
  '(gmake distclean)
  `(./configure   ,(string-append
                     "--prefix=" (tynnyri))
                  "--enable-multibyte"
                  "--enable-perlinterp=yes"
                  "--enable-pythoninterp=yes"
                  "--enable-xim"
                  "--enable-fontset"
                  "--disable-darwin"
                  "--disable-selinux"
                  "--with-x"
                  "--with-features=huge")
  '(gmake)
  '(gmake install)
  ))

