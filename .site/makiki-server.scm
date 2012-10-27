#!/usr/bin/env gosh
;; -*- coding: utf-8 -*-

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

(include "src/index.scm")
(include "src/niconico.scm")
(include "src/test.scm")
(include "src/feedtest.scm")

(define document-root
  (build-path (home-directory) ".site"))

(define (main args)
  (start-server))

(define start-server
  (lambda ()
    (start-http-server :access-log #t :error-log #t
                       :document-root document-root
                       :port 8888)))

