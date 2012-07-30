#!/usr/bin/env gosh
;; -*- coding: utf-8 -*-

;;  example usage in shell's rc:
; alias komento='gosh komento.scm'
; alias rm='komento rm'

(use gauche.process)
(use gauche.parseopt)
(use util.match)
(use file.util)
(use pikkukivi)


(define (main args)
  (pikkukivi (cdr args)))


