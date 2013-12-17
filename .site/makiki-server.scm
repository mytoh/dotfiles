#!/usr/bin/env gosh
;; -*- coding: utf-8 -*-

(use gauche.threads)
(use text.html-lite)
(use www.cgi)
(use makiki)
(use sxml.tools)
(use sxml.sxpath)
(use sxml.ssax)
(use text.tree)
(use file.util)
(use rfc.uri)
(require-extension
  (srfi 1 13))
(use kirjasto.verkko) ;define-page-handler


(load (build-path (sys-dirname (current-load-path)) "src/index.scm"))
(load (build-path (sys-dirname (current-load-path)) "src/niconico.scm"))
(load (build-path (sys-dirname (current-load-path)) "src/feedtest.scm"))
(load (build-path (sys-dirname (current-load-path)) "src/test.scm"))

(define document-root
  (build-path (home-directory) ".site"))

(define (main args)
  (start-server))

(define start-server
  (lambda ()
    (start-http-server :access-log #t :error-log #t
                       :document-root document-root
                       :port 8888)))

