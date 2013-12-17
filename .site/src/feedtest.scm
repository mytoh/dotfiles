

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
(use rfc.http)
(use rfc.json)
(use util.list)
(require-extension
  (srfi 13))
(use kirjasto.verkko) ;define-page-handler


(define feed-url "http://www.digg.com/rss/index.xml")



(define (feed-test)
  (let* ((feed (cddar (parse-json-string
                      (values-ref
                        (http-get "ajax.googleapis.com"
                                  (string-append
                                    "/ajax/services/feed/load?v=1.0&q="
                                    feed-url))
                        2))))
        (entries (assoc-ref feed 'entries)))
    entries
    ))

(print (feed-test))

;; test page

(define feed-test-page
  (lambda (req)
    (html5
      `((title "feedtest")
        (p
          ,(feed-test))
        ))))

(define-page
  #/^\/feedtest/
  feed-test-page)

