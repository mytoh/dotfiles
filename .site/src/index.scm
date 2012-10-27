
(use gauche.threads)
(use text.html-lite)
(use srfi-1)
(use www.cgi)
(use makiki)
(use sxml.tools)
(use sxml.sxpath)
(use sxml.ssax)
(use text.tree)
(use file.util)
(use rfc.uri)
(require-extension
  (srfi 13))
(use kirjasto.verkko) ;define-page-handler

(define tag-link
  (lambda (url seg lst)
    (map
      (lambda (tag)
        `(a (@ (href ,(string-append url seg (uri-encode-string tag)))
               (target "_blank"))
            ,tag))
      lst)))

(define tag-pages
  (lambda (title seg)
    (lambda (url lst)
      `(p (@ (class ,title))
          "(" (a (@ (href ,url)
                    (target _blank))
                 ,title) (br)
          (span "(")
          ,@(tag-link url seg lst)
          "))"))))

(define delicious
  (tag-pages "delicious" "/tag/recent/")
  )

(define reddit
  (tag-pages "reddit" "/r/"))
(define reddit-tags
  '("linuxactionshow"
    "scheme"
    "lisp_ja"
    "lisp"
    "clojure"
    "emacs"
    "bsd"
    "freebsd"
    "screenshots"
    "commandline"
    "xmonad"
    "unixporn"
    "desktops"
    "unix"
    "rust"
    "vim"
    "programming"))

(define hatena
  (tag-pages "hatena" "/t/"))

(define github
  (tag-pages "github" "/languages/"))

(define github-tags
  '("clojure"
    "common lisp"
    "scheme"
    "viml"
    "ruby"
    "rust"
    "shell"))

(define yotsuba
  (lambda (title-url tag-url tag-list)
    (let ((tag-link
            (lambda (url lst)
              (map
                (lambda (e)
                  `(a (@ (href ,(string-append url "/" (car e)))
                         (target "_blank"))
                      ,(car e)
                      (span (@ (class popup))
                            ,(cdr e))))
                lst))))
      `(p (@ (class "yotsuba"))
          "(" (a (@ (href ,title-url) (target "_blank")) "4chan") (br)
          (span "(")
          ,@(tag-link tag-url tag-list)
          "))"))))


(define make-link
  (lambda (lst)
    (map
      (lambda (e)
        `(a (@ (href ,(car e)) (target "_blank"))
            ,(cdr e)))
      lst)))


(define make-paren-link
  (lambda (cname main-link main-title link-list)
    `(p (@ (class ,cname))
        "(" (a (@ (href ,main-link) (target "_blank")) ,main-title) (br)
        (span "(" )
        ,@(make-link link-list)
        "))")
    ))

(define script-reject-ie
  (lambda ()
    `(script
       ,(string-append
          "var isMSIE = /*@cc_on!@*/false;"
          "if (isMSIE) {"
          "if (confirm('this site hates IE ')==true) {"
          "location.href=\"http://www.google.co.jp/chrome/intl/ja/landing_ff.html\";"
          "} else {"
          "}"
          ))))

(define div-loader
  (lambda ()
    `(div (@ (class "loader"))
          (span)
          (span)
          (span))))

(define background-image
  (lambda (req)
    (let* ((browser (request-header-ref req "user-agent")))
      (if (string=? browser "Opera") ; browser supporting webp
        '(img (@ (class "bg") (src "image/sicp-mod.webp") (alt "")))
        '(img (@ (class "bg") (src "image/sicp-mod.png") (alt "")))))))

(define index-page
  (lambda (req)
    (html5
      `(
        (title "start page")
        (link (@ (rel "stylesheet") (href "css/style.css")))
        (link (@ (rel "stylesheet") (href "//fonts.googleapis.com/css?family=Convergence")))
        (script (@ (src "//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js")))
        (script (@ (src "js/pointer.js")))
        ,(script-reject-ie)
        ,(robots-noindex)

        ; ,(background-image req)

        (div (@ (class "bookmark"))
             ,(delicious "//d.me"
                         '("zsh"
                           "emacs"
                           "vim"
                           "scheme"
                           "lisp"
                           "clojure"
                           "musiikki"
                           "xmonad"
                           "tmux"
                           "ruby"
                           "javascript"
                           "css"
                           "pytohn"
                           ))
             ,(hatena "//b.hatena.ne.jp"
                      '("vim"
                        "emacs"
                        "zsh"
                        "scheme"
                        "lisp"
                        "clojure"
                        "bash"
                        "freebsd"
                        "tmux"
                        "perl"
                        "ruby"
                        "javascript"
                        "css"
                        "xmonad"
                        "python"
                        ))
             ,(make-paren-link "arch"
                               "//archlinux.org"
                               "archlinux"
                               '(("//bbs.archlinux.org" "forum")
                                 ("//bbs.archlinux.org/viewforum.php?id=47" "artwork_screenshots")))
             ,(make-paren-link "crunchbang"
                               "//crunchbanglinux.org"
                               "#!"
                               '(("//crunchbanglinux.org/forums/forum/6/artwork-screenshots"
                                  "artwork_screenshots")))
             ,(make-paren-link "freebsd"
                               "//forums.freebsd.org"
                               "freebsd"
                               '(("//forums.freebsd.org/forumdisplay.php?f=38" "Xorg")))
             ,(reddit "//reddit.com"
                      reddit-tags)

             ,(yotsuba "//www.4chan.org"
                       "//boards.4chan.org"
                       '(("g" "technology")
                         ("b" "random")
                         ("e" "ecchi")
                         ("h" "hentai")
                         ("int" "international")
                         ("w" "anime wallpaper")
                         ("t" "torrent")
                         ("r" "request")
                         ("s" "sexy beautiful women")
                         ("hr" "high resolution")
                         ("u" "yuri")))

             ,(github "//github.com"
                      github-tags)

             (p (@ (class "gauche"))
                "(" (a (@ (href "//practical-scheme.net/gauche/man/gauche-refj.html")
                          (target "_blank"))
                       "gauche-manual") (br)
                (span "(" )
                (a (@ (href "//www.callcc.net/gauche/refj/")
                      (target "_blank"))
                   "refj"
                   (span (@ (class popup)) "ref search"))
                (a (@ (href "//practical-scheme.net/gauche/man/?l=jp&p=file.util")
                      (target "_blank"))
                   "file.util"
                   (span (@ (class popup)) "file-util"))
                "))"))

        ,(make-link '(("/niconico" "nico")))
        (br)
        ,(make-link '(("/feedtest" "feed-test")))

        (p (@ (id "test"))
           (a (@ (href "/test") (target "_blank"))
              "test"))

        (footer
          (p (@ (id "ddg"))
             (a (@ (href "//duckduckgo.com") (target "_blank")) "ddg")))
        (form (@ (id "searchbox") (action "//duckduckgo.com/?kl=jp-jp&kp=-1") (target "_blank"))
              (input (@ (type "text") (name "q") (value "")))
              (input (@ (type "submit") (value "Search")))
              (input (@ (type "hidden") (name "t") (value ""))))))))



;;
;; http-handlers
;;


(define-page
  #/^\/$/
  index-page)



(define-http-handler #/.*\.css$/
                     (file-handler))
(define-http-handler #/.*\.js$/
                     (file-handler))
(define-http-handler #/.*\/image\/.*/
                     (file-handler))


