#!/usr/bin/env gosh
;; -*- coding: utf-8 -*-

;   .-----.---.-.-----.-----.---.-.
;   |  _  |  _  |     |     |  _  |
;   |   __|___._|__|__|__|__|___._|
;   |_|
;   pannaa sina olutta
;
;   package management with gauche scheme
;   maybe similar to homebrew, pacman, emerge
;
; first set environment variable
; $OLUTPANIMO, and set $OLUTPANIMO/bin to $PATH
;
; terms:
; kaava    - build file name    - $OLUTPANIMO/kirjasto/kaava/foo
; riisi    - source directory                      - $HOME/local/git/foo
; panna    - panna directory, all files here       - $OLUTPANIMO
; tynnyri  - package install prefix directory      - $OLUTPANIMO/kellari/foo
; kellari  - all tynnyri goes under this directory - $OLUTPANIMO/kellari
;
; commands:
; install    - function you have to define normally
; update,up  - update one package or all
; edit       - edit kaava with $EDITOR or vim
; list,ls    - list installed package
;


(use gauche.process)
(use gauche.parseopt)
(use gauche.parameter)
(use util.match)
(use file.util)

(use panna)

(define (usage status)
  (exit status "usage: ~a <command> <package-name>\n" *program-name*))

(define (main args)
  (let-args (cdr args)
    ((#f "h|help" (usage 0))
     . rest)
    (when (null-list? rest)
      (usage 0))
    (let* ((kaava (if (>= (length rest) 2)
                    (cdr rest)
                    #f))
           (panna (lambda (c)
                    (cond ( kaava  
                      (run-process `(nice -n 5 gosh ,(build-path (sys-getenv "OLUTPANIMO")
                                                       (string-append "kirjasto/panna/komento/" c ".scm"))
                                          ,@kaava)
                                   :wait #t)) 
                      (else
                      (run-process `(nice -n 5 gosh ,(build-path (sys-getenv "OLUTPANIMO")
                                                       (string-append "kirjasto/panna/komento/" c ".scm")))
                                   :wait #t))))))
      (match (car rest)
        ; command aliases
        ("up"
         (panna "update"))
        ("ln"
         (pannaa "link"))
        ("ls"
         (panna "list"))
        ("home"
         (panna "homepage"))
        ((or "rm" "remove")
         (panna "install"))
        ("abv"
         (panna "info"))
        ("env"
         (panna "environment"))

        (_ (panna (car rest))))))
  0)

