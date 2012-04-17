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
; $PANNA_PREFIX, and set $PANNA_PREFIX/bin to $PATH
;
; terms:
; kaava    - build file name    - $PANNA_PREFIX/kirjasto/kaava/foo
; riisi    - source directory                      - $HOME/local/git/foo
; panna    - panna directory, all files here       - $PANNA_PREFIX
; tynnyri  - package install prefix directory      - $PANNA_PREFIX/kellari/foo
; kellari  - all tynnyri goes under this directory - $PANNA_PREFIX/kellari
;
; commands:
; install    - function you have to define normally
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
    (let* ((pullo (if (>= (length rest) 2)
                 (cadr rest)
                 #f))
           (kaava pullo))
      ; (if kaava
      ;   ()
        ; (begin
          ; (load-build-file kaava)
          ; (initialize kaava)
          ; (current-directory riisi)))
      (match-let  ((command (car rest)))
        (if kaava
          (run-process `(gosh ,(build-path (sys-getenv "PANNA_PREFIX")
                                          (string-append "kirjasto/panna/komento/" command ".scm"))
                             ,kaava)
                      :wait #t)
         (run-process `(gosh ,(build-path (sys-getenv "PANNA_PREFIX")
                                          (string-append "kirjasto/panna/komento/" command ".scm")))
                      :wait #t)
         ))
      ; )
    ))

        ; ((or "update" "up")
        ;  (update kaava)
        ;  )
        ; ("install"
        ;  ; (install)
        ;  ; (link kaava)
        ;  (run-process `(gosh ,(build-path (sys-getenv "PANNA_PREFIX")
        ;                                   "kirjasto/komento/install.scm")
        ;                      ,kaava)
        ;               :wait #t)
        ;  )
        ; ((or "ln" "link")
        ;  (link kaava))
        ; ("edit"
        ;  (edit kaava))
        ; ((or "ls" "list")
        ;  (list-package))
        ; ((or "home" "homepage")
        ;  (print-homepage kaava))
        ; ((or "rm" "uninstall" "remove")
        ;  (uninstall kaava))
        ; ((or "abv" "info")
        ;  (info kaava))
        ; ((or "env" "environment")
        ;  (environment))
        ; ("test"
        ;  (test))
        ; (_ (usage 1)))))
  0)

