#!/usr/bin/env gosh

(add-load-path ".")
(use gauche.threads)
(use text.html-lite)
(use srfi-1)
(use www.cgi)
(use makiki)
(use sxml.tools)
(use file.util)
(load "kirjasto") ;daemonize

(define (main args)
  (daemonize
  (start-http-server :access-log #t :error-log #t
                     :document-root #`",(home-directory)/.site"
                     :port 8888))
  )

(define-http-handler #/^\/$/
  (^[req app]
    (respond/ok req
  `(sxml
    (html
     (head (title "start page")
           (link (@ (rel "stylesheet") (href "css/style.css") (type "text/css")))
           (link (@ (rel "stylesheet") (href "http://fonts.googleapis.com/css?family=Convergence") (type "text.css")))
           )
     (body
       (img (@ (class "bg") (src "image/sicp-mod.png") (alt "")))
       (div (@ (id "bookmark"))
            (p (@ (class "delicious"))
             "(" (a (@ (href "http://d.me") (target "_blank")) "delicious") (br)
             (span "(" )
                  (a (@ (href "http://d.me/tag/recent/zsh")      (target "_blank")) "zsh")
                  (a (@ (href "http://d.me/tag/recent/vim")      (target "_blank")) "vim")
                  (a (@ (href "http://d.me/tag/recent/scheme")   (target "_blank")) "scheme")
                  (a (@ (href="http://d.me/tag/recent/musiikki") (target "_blank")) "musiikki")
                  "))")

            (p (@ (class "hatena"))
             "(" (a (@ (href "http://b.hatena.ne.jp") (target "_blank")) "hatena") (br)
             (span "(" )
                  (a (@ (href "http://b.hatena.ne.jp/t/vim") (target "_blank")) "vim")
                  (a (@ (href "http://b.hatena.ne.jp/t/zsh") (target "_blank")) "zsh")
                  (a (@ (href "http://b.hatena.ne.jp/t/scheme") (target "_blank")) "scheme")
                  (a (@ (href "http://b.hatena.ne.jp/t/bash") (target "_blank")) "bash")
                  "))")

            (p (@ (class "arch"))
             "(" (a (@ (href "http://archlinux.org") (target "_blank")) "archlinux") (br)
             (span "(" )
                  (a (@ (href="http://bbs.archlinux.org") (target "_blank")) "forum")
                  "))")

            (p (@ (class "crunchbang"))
             "(" (a (@ (href "http://crunchbanglinux.org") (target "_blank")) "#!") (br)
             (span "(" )
                  (a (@ (href "http://crunchbanglinux.org/forums/6/artwork-screenshots")    (target "_blank")) "artwork_screenshots")
                  "))")

            (p (@ (class "reddit"))
             "(" (a (@ (href "http://www.reddit.com") (target "_blank")) "reddit") (br)
             (span "(" )
                  (a (@ (href "http://www.reddit.com/r/linuxactionshow")    (target "_blank")) "LAS")
                  (a (@ (href "http://www.reddit.com/r/scheme")    (target "_blank")) "scheme")
                  (a (@ (href "http://www.reddit.com/r/freebsd")    (target "_blank")) "freebsd")
                  (a (@ (href "http://www.reddit.com/r/screenshots")    (target "_blank")) "screenshots")
                  (a (@ (href "http://www.reddit.com/r/commandline")    (target "_blank")) "commandline")
                  "))")

            (p (@ (class "fourchan"))
             "(" (a (@ (href "http://www.4chan.org") (target "_blank")) "4chan") (br)
             (span "(" )
                  (a (@ (href "http://boards.4chan.org/g") (target "_blank")) "g" (span (@ (class popup)) "technology"))
                  (a (@ (href "http://boards.4chan.org/b") (target "_blank")) "b" (span (@ (class popup)) "random"))
                  (a (@ (href "http://boards.4chan.org/e") (target "_blank")) "e" (span (@ (class popup)) "ecchi"))
                  (a (@ (href "http://boards.4chan.org/h") (target "_blank")) "h" (span (@ (class popup)) "hentai"))
                  (a (@ (href "http://boards.4chan.org/w") (target "_blank")) "w" (span (@ (class popup)) "anime wallpaper"))
                  (a (@ (href "http://boards.4chan.org/t") (target "_blank")) "t" (span (@ (class popup)) "torrent"))
                  (a (@ (href "http://boards.4chan.org/r") (target "_blank")) "r" (span (@ (class popup)) "request"))
                  (a (@ (href "http://boards.4chan.org/s") (target "_blank")) "s" (span (@ (class popup)) "sexy bautiful woman"))
                  (a (@ (href "http://boards.4chan.org/u") (target "_blank")) "u" (span (@ (class popup)) "yuri"))
                  "))")
            ) ;div
       (footer
         (p (@ (id "ddg"))
            (a (@ (href "http:/duckduckgo.com") (target "_blank")) "ddg")))
         (form (@ (id "searchbox") (action "http://duckduckgo.com/?kl=jp-jp&kp=-1") (target "_blank"))
               (input (@ (type "text") (name "q") (value "")))
               (input (@ (type "submit") (value "Search")))
               (input (@ (type "hidden") (name "t") (value ""))))
       ))
    )
  )))


(define-http-handler #/.*\.css$/
            (file-handler))

(define-http-handler #/.*\/image\/.*/
            (file-handler))
    
                
