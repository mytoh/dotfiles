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
(use text.tree)
(use file.util)
(use rfc.uri)
(require-extension
  (srfi 13))
(use kirjasto) ;daemonize

(define document-root
  (build-path (home-directory) ".site"))

(define (main args)
  (daemonize
    (start-http-server :access-log #t :error-log #t
                       :document-root document-root
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
          "))"))))

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


(define index-page
  (lambda (req)
    (html5
      `(
        (title "start page")
        (link (@ (rel "stylesheet") (href "css/style.css")))
        (link (@ (rel "stylesheet") (href "//fonts.googleapis.com/css?family=Convergence")))

        ,(let* ((browser (request-header-ref req "user-agent" )))
           (if (string=? browser "Opera") ; browser supporting webp
             '(img (@ (class "bg") (src "image/sicp-mod.webp") (alt "")))
             '(img (@ (class "bg") (src "image/sicp-mod.png") (alt "")))))
        (div (@ (class "bookmark"))
             ,(delicious "//d.me"
                         '("zsh"
                           "vim"
                           "scheme"
                           "lisp"
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
                        "zsh"
                        "scheme"
                        "lisp"
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
             ,(reddit "//reddit.com" '("linuxactionshow"
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

             ,(yotsuba "//www.4chan.org"
                       "//boards.4chan.org"
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
                "))")
             )

        (p (@ (id "nico"))
           (a (@ (href "/niconico") (target "_blank"))
              "nico"))

        (p (@ (id "test"))
           (a (@ (href "/test") (target "_blank"))
              "test")
           (object (@ (type "image/svg+xml")
                      (data "image/temp.svg")))
           )

        (footer
          (p (@ (id "ddg"))
             (a (@ (href "//duckduckgo.com") (target "_blank")) "ddg")))
        (form (@ (id "searchbox") (action "//duckduckgo.com/?kl=jp-jp&kp=-1") (target "_blank"))
              (input (@ (type "text") (name "q") (value "")))
              (input (@ (type "submit") (value "Search")))
              (input (@ (type "hidden") (name "t") (value ""))))
        ))))

;; niconico
(define nico-page
  (lambda (req)
    (html5
      `(
        (title "nico")
        (link (@ (rel "stylesheet") (href "css/nico.css") (type "text/css")))

        (div (@ (id "wrapper"))
             (header
               (h1 "niconico playlist") (br))
             (nav ,(nico-page-navigation))

             (article
               ,(nico-page-content-videos))
             )))))


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
        (li (a (@ (href "#content")) "video"))
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
        (build-path document-root "nico/videos")))))



;; test page


(define test-page
  (lambda (req)
    (html5
      '(
        (title "test")
        (p "test page")
        ))))

;;
;; http-handlers
;;


(define-page-handler
  #/^\/$/
  index-page )

(define-page-handler
  #/^\/niconico/
  nico-page )

(define-page-handler
  #/^\/test/
  test-page)


(define-http-handler #/.*\.css$/
                     (file-handler))

(define-http-handler #/.*\/image\/.*/
                     (file-handler))


