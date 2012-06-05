

(use panna.kaava)

(define kaava "rxvt-unicode")


(define (install tynnyri)
  (with-usr-local)
  (system
    '("./autogen.sh")
    `("./configure" ,(string-append "--prefix=" tynnyri)
                  "--enable-256-color"
                  "--enable-xft"
                  "--enable-unicode3"
                  "--enable-combining"
                  "--enable-font-styles"
                  "--enable-pixbuf"
                  "--enable-startup-notification"
                  "--enable-transparency"
                  "--enable-fading"
                  "--enable-perl"
                  "--enable-xim"
                  "--enable-mousewheel"
                  "--enable-frills"
                  "--enable-utmp")
    '(make)
    '(make install)
    '(make clean)
    '(make distclean)
    ))
