#!/usr/bin/env gosh
;; -*- coding: utf-8 -*-

(add-load-path ".")
(use gauche.threads)
(use text.html-lite)
(use srfi-1)
(use www.cgi)
(use makiki)
(use sxml.tools)
(use sxml.sxpath)
(use sxml.ssax)
(use file.util)
(use rfc.uri)
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

(define tag-pages
  (lambda (title seg)
    (lambda (url lst)
      `(p (@ (class ,title))
          "(" (a (@ (href ,url)
                    (target _blank))
                 ,title) (br)
          (span "(")
          ,@(tag-link url seg lst)
          "))"))
    ))

(define delicious
  (tag-pages "delicious" "/tag/recent/")
  )

(define reddit
  (tag-pages "reddit" "/r/"))

(define hatena
  (tag-pages "hatena" "/t/"))

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



(define index-page
  (lambda (req)
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
                ,(hatena "http://b.hatena.ne.jp"
                         '("vim"
                           "zsh"
                           "scheme"
                           "lisp"
                           "bash"
                           "freebsd"
                           "tmux"
                           "perl"
                           "ruby"
                           "python"))
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
                (p (@ (class "gauche"))
                   "(" (a (@ (href "http://practical-scheme.net/gauche/man/gauche-refj.html")
                             (target "_blank"))
                          "gauche-manual") (br)
                   (span "(" )
                   (a (@ (href "http://www.callcc.net/gauche/refj/")
                         (target "_blank"))
                      "refj"
                      (span (@ (class popup)) "ref search"))
                   (a (@ (href "http://practical-scheme.net/gauche/man/?l=jp&p=file.util")
                         (target "_blank"))
                      "file.util"
                      (span (@ (class popup)) "file-util"))
                   "))")
                )

           (p (@ (id "nico"))
              (a (@ (href "/niconico") (target "_blank"))
                    "nico"))

           (footer
             (p (@ (id "ddg"))
                (a (@ (href "http:/duckduckgo.com") (target "_blank")) "ddg")))
           (form (@ (id "searchbox") (action "http://duckduckgo.com/?kl=jp-jp&kp=-1") (target "_blank"))
                 (input (@ (type "text") (name "q") (value "")))
                 (input (@ (type "submit") (value "Search")))
                 (input (@ (type "hidden") (name "t") (value ""))))
           )))))

;; niconico
(define nico-page
  (lambda (req)
    `(sxml
       (html
         (head (title "nico")
               (link (@ (rel "stylesheet") (href "css/nico.css") (type "text/css")))
               )
         (body
           (div (@ (id "wrapper"))
                (div (@ (id "header"))
                     (h1 "niconico playlist") (br))
                (div (@ (id "navigation"))
                     ,(nico-page-navigation))
                (div (@ (id "content"))
                     ,(nico-page-content-videos))
                ))
         ))))


(define nico-get-video-info
  (lambda (video-number)
    (ssax:xml->sxml
      (open-input-string
        (open (uri-merge "http://ext.nicovideo.jp/api/getthumbinfo/"
                         video-number)))
      '())))

(define nico-page-navigation
  (lambda ()
    `((ul
        (li (a (@ (href "#")) "video"))
        (li (a (@ (href "#")) "playlist"))
        ))))

(define nico-page-content-videos
  (lambda ()
    (map
      (lambda (m)
        (let* ((video-number (symbol->string m))
               (video-info (nico-get-video-info video-number))
               (title         (cadr ((car-sxpath "//title") video-info)))
               (thumbnail-url (cadr ((car-sxpath "//thumbnail_url") video-info)))
               (watch-url     (cadr ((car-sxpath "//watch_url") video-info)))
               )
          `((div (@ (class "video"))
              (a (@ (href ,watch-url)
                       (target "_blank"))
                    (img (@  (class "video-img")
                             (alt "")
                             (src ,thumbnail-url)
                             (height "50px")
                             (width  "50px"))))
             (a (@ (class "video-title")
                       (href ,watch-url)
                       (target "_blank"))
                    ,title)))
          ))
      (file->list
        read
        (build-path (home-directory) "nico/movies"))
      )))


;;
;; http-handles
;;

(define-http-handler
  #/^\/$/
  (^(req app)
    (respond/ok
      req
      (index-page req)
      )))

(define-http-handler
  #/^\/niconico/
  (^(req app)
    (respond/ok
      req
      (nico-page req))))


(define-http-handler #/.*\.css$/
                     (file-handler))

(define-http-handler #/.*\/image\/.*/
                     (file-handler))


