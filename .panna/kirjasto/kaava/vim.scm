(use panna.kaava)

(define kaava  "vim")

(define (install tynnyri)
  (use-clang)
  (system
  '(gmake clean)
  '(gmake distclean)
  `(./configure   ,(string-append
                     "--prefix=" tynnyri)
                  "--enable-multibyte"
                  "--enable-perlinterp"
                  "--enable-pythoninterp"
                  ; "--enable-mzschemeinterp"
                  "--enable-xim"
                  "--enable-fontset"
                  "--disable-darwin"
                  "--disable-selinux"
                  "--with-x"
                  "--with-features=huge")
  '(gmake)
  '(gmake install)
  ))

