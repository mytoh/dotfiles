(use panna.kaava)

(define kaava  "vim")

(define (install tynnyri)
  (with-clang)
  (system
  '(gmake clean)
  '(gmake distclean)
  `(./configure   ,(string-append
                     "--prefix=" tynnyri)
                  "--with-features=huge"
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

