;; -*- coding: utf-8 -*-

(define-module kirjasto.verkko.merkintä
  (export
   html5
   robots-noindex)
  (use text.tree)
  (use sxml.tools)
  )
(select-module kirjasto.verkko.merkintä)

(define doctype-html
  "<!doctype html>" )

(define charset-utf8
  "<meta charset=\"utf-8\">")

(define html5
  (lambda (body-list)
    (tree->string
     `(,doctype-html
       ,charset-utf8
       ,(sxml:sxml->xml
         body-list)))))

(define robots-noindex
  (lambda ()
    '(meta (@ (name "robots")
              (content "noindex,nofollow")))))
