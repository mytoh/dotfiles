
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


;; test page

(define test-page
  (lambda (req)
    (html5
      '(
        (title "test")
        (p "test page")
        (object (@ (type "image/svg+xml")
                   (data "image/temp.svg")))))))

(define-page
  #/^\/test/
  test-page)

