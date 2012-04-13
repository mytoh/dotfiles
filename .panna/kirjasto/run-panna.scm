#!/usr/bin/env gosh

;   .-----.---.-.-----.-----.---.-.
;   |  _  |  _  |     |     |  _  |
;   |   __|___._|__|__|__|__|___._|
;   |_|
;   panna olutta
;
;   package management with gauche scheme
;   maybe similar to homebrew, pacman, emerge
;
; first set environment variable
; $PANNA_PREFIX, and set $PANNA_PREFIX/bin to $PATH
;
; kaava    - package name, also build file name    - $PANNA_PREFIX/kirjasto/kaava/foo
; riisi    - source directory                      - $HOME/local/git/foo
; panna    - panna directory, all files here       - $PANNA_PREFIX
; tynnyri  - package install prefix directory      - $PANNA_PREFIX/kellari/foo
; kellari  - all tynnyri goes under this directory - $PANNA_PREFIX/kellari
;
; build           - function you have to define normally
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
    (let ((app (cadr rest)))
      (load-build-file app)
      (current-directory (riisi))
      (match (car rest)
        ((or "update" "up")
         (update))
        ("install"
         (install)
         (link app))
        ((or "ln" "link")
         (link app))
        ("edit"
         (edit app))
        ((or "ls" "list")
         (list-package))
        ((or "home" "homepage")
         (homepage))
        ((or "rm" "uninstall" "remove")
         (uninstall app))
        ((or "abv" "info")
         (info app))
        ((or "env" "environment")
         (environment))
        (_ (usage 1))))
    )
  0)

