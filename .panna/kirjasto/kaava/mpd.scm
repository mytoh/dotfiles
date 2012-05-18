(use panna.kaava)
(use kirjasto)

(define kaava "mpd")
(define homepage "mpd.wikia.com")
(define repository "git://git.musicpd.org/master/mpd.git")


(define (install tynnyri)
    (sys-putenv "CPPFLAGS=-I/usr/local/include")
    (sys-putenv "LDFLAGS=-L/usr/local/lib")
  (system
    '(./autogen.sh)
    `(./configure ,(string-append "--prefix=" tynnyri)
                  "--disable-soundcloud")
    '(make)
    '(make install)
    '(make clean)
    '(make distclean)
    ))
