#!/usr/bin/env gosh

(add-load-path ".")
(use gauche.threads)
(use text.html-lite)
(use srfi-1)
(use www.cgi)
(use makiki)
(use sxml.tools)
(use file.util)
(use kirjasto) ;daemonize

(define (main args)
  (daemonize
    (start-http-server :access-log #t :error-log #t
                       :document-root #`",(home-directory)/.site"
                       :port 8888)))



(define tag-link
  (lambda (url seg lst)
    (map
      (lambda (tag)
        `(a (@ (href ,(string-append url seg tag))
               (target "_blank"))
            ,tag))
      lst)))

(define delicious
  (lambda (url tag-list)
    `(p (@ (class "delicious"))
        "(" (a (@ (href ,url) (target "_blank")) "delicious") (br)
        (span "(")
        ,@(tag-link url "/tag/recent/" tag-list)
        "))")))


(define reddit
  (lambda (url tag-list)
    `(p (@ (class "reddit"))
        "(" (a (@ (href ,url) (target "_blank")) "reddit") (br)
        (span "(")
        ,@(tag-link url "/r/" tag-list)
        "))")))

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
                            (cdr e))))
                lst))))
      `(p (@ (class "yotsuba"))
          "(" (a (@ (href ,title-url) (target "_blank")) "4chan") (br)
          (span "(")
          ,@(tag-link tag-url tag-list)
          "))"))))

(define-http-handler
  #/^\/$/
  (^(req app)
    (respond/ok
      req
      `(sxml
         (html
           (head (title "start page")
                 (link (@ (rel "stylesheet") (href "css/style.css") (type "text/css")))
                 (link (@ (rel "stylesheet") (href "http://fonts.googleapis.com/css?family=Convergence") (type "text.css")))
                 )
           (body
             ,(let* ((browser (request-header-ref req "user-agent" )))
                (if (string=? browser "Opera") ; browser supporting webp
                  '(img (@ (class "bg") (src "image/sicp-mod.webp") (alt "")))
                  '(img (@ (class "bg") (src "image/sicp-mod.png") (alt "")))))
             (div (@ (id "bookmark"))

                  ,(delicious "http://d.me"
                              '("zsh"
                                "vim"
                                "scheme"
                                "musiikki"
                                "xmonad"
                                "tmux"
                                "ruby"
                                "pytohn"))

                  (p (@ (class "hatena"))
                     "(" (a (@ (href "http://b.hatena.ne.jp") (target "_blank")) "hatena") (br)
                     (span "(" )
                     (a (@ (href "http://b.hatena.ne.jp/t/vim") (target "_blank")) "vim")
                     (a (@ (href "http://b.hatena.ne.jp/t/zsh") (target "_blank")) "zsh")
                     (a (@ (href "http://b.hatena.ne.jp/t/scheme") (target "_blank")) "scheme")
                     (a (@ (href "http://b.hatena.ne.jp/t/lisp") (target "_blank")) "lisp")
                     (a (@ (href "http://b.hatena.ne.jp/t/bash") (target "_blank")) "bash")
                     (a (@ (href "http://b.hatena.ne.jp/t/freebsd") (target "_blank")) "freebsd")
                     (a (@ (href "http://b.hatena.ne.jp/t/tmux") (target "_blank")) "tmux")
                     (a (@ (href "http://b.hatena.ne.jp/t/perl") (target "_blank")) "perl")
                     (a (@ (href "http://b.hatena.ne.jp/t/ruby") (target "_blank")) "ruby")
                     (a (@ (href "http://b.hatena.ne.jp/t/python") (target "_blank")) "python")
                     "))")

                  (p (@ (class "arch"))
                     "(" (a (@ (href "http://archlinux.org") (target "_blank")) "archlinux") (br)
                     (span "(" )
                     (a (@ (href "http://bbs.archlinux.org") (target "_blank")) "forum")
                     (a (@ (href "http://bbs.archlinux.org/viewforum.php?id=47")    (target "_blank")) "artwork_screenshots")
                     "))")

                  (p (@ (class "crunchbang"))
                     "(" (a (@ (href "http://crunchbanglinux.org") (target "_blank")) "#!") (br)
                     (span "(" )
                     (a (@ (href "http://crunchbanglinux.org/forums/forum/6/artwork-screenshots")    (target "_blank")) "artwork_screenshots")
                     "))")

                  (p (@ (class "freebsd"))
                     "(" (a (@ (href "http://forums.freebsd.org") (target "_blank")) "freebsd") (br)
                     (span "(" )
                     (a (@ (href "http://forums.freebsd.org/forumdisplay.php?f=38")    (target "_blank")) "X.Org")
                     "))")

                  ,(reddit "http://reddit.com" '("linuxactionshow"
                                                 "scheme"
                                                 "lisp_ja"
                                                 "lisp"
                                                 "bsd"
                                                 "freebsd"
                                                 "screenshots"
                                                 "commandline"
                                                 "xmonad"
                                                 "unixporn"
                                                 "desktops"
                                                 "vim"))

                  ,(yotsuba "http://www.4chan.org"
                            "http://boards.4chan.org"
                            '(
                              ("g" "technology")
                              ("b" "random")
                              ("e" "ecchi")
                              ("h" "hentai")
                              ("w" "anime wallpaper")
                              ("t" "torrent")
                              ("r" "request")
                              ("s" "sexy beautiful women")
                              ("hr" "high resolution")
                              ("u" "yuri")))

                  ;
                  (p (@ (class "gauche"))
                     "(" (a (@ (href "http://practical-scheme.net/gauche/man/gauche-refj.html") (target "_blank")) "gauche-manual") (br)
                     (span "(" )
                     (a (@ (href "http://www.callcc.net/gauche/refj/") (target "_blank")) "refj" (span (@ (class popup)) "ref search"))
                     (a (@ (href "http://practical-scheme.net/gauche/man/?l=jp&p=file.util") (target "_blank")) "file.util" (span (@ (class popup)) "file-util"))
                     "))"))
             (footer
               (p (@ (id "ddg"))
                  (a (@ (href "http:/duckduckgo.com") (target "_blank")) "ddg")))
             (form (@ (id "searchbox") (action "http://duckduckgo.com/?kl=jp-jp&kp=-1") (target "_blank"))
                   (input (@ (type "text") (name "q") (value "")))
                   (input (@ (type "submit") (value "Search")))
                   (input (@ (type "hidden") (name "t") (value ""))))
             ))))))


(define-http-handler #/.*\.css$/
                     (file-handler))

(define-http-handler #/.*\/image\/.*/
                     (file-handler))


