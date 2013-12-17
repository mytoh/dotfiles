

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

;; niconico
(define nico-page
  (lambda (req)
    (html5
      `(
        (title "nico")
        (link (@ (rel "stylesheet") (href "css/nico.css") (type "text/css")))

        ,(div-loader)
        (div (@ (id "wrapper"))
             (header
               (h1 "niconico playlist") (br))
             (nav ,(nico-page-navigation))

             (article
               ,(nico-page-content-videos)))))))


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
        (li (a (@ (href "#")) "playlist"))))))

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
                    ,title)))))
      (file->list
        read
        (build-path document-root "nico/videos")))))


(define-page
  #/^\/niconico/
  nico-page)

