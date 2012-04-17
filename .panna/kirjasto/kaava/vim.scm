(use panna)

(define kaava  "vim")
(define riisi (build-path (hg-kansio) kaava))

(define (install tynnyri)
  (use-clang)
  (commands
  '(gmake clean)
  '(gmake distclean)
  `(./configure   ,(string-append
                     "--prefix=" tynnyri)
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

