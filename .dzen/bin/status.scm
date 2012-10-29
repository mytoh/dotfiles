#!/usr/bin/env gosh
;; -*- coding: utf-8 -*-

(use gauche.process)
(use gauche.parseopt)
(use gauche.sequence)
(use util.match)
(use text.tree)
(use file.util)
(use srfi-1)
(use srfi-13)
(use srfi-19)
(use kirjasto.grafiikka)

(define-syntax forever
  ;;macro for endless loop
  (syntax-rules ()
    ((_ e1 e2 ...)
     (let loop () e1 e2 ...
       (sys-sleep 3) ; sleep 5 minutes
       (loop)))))

;; dzen helper
(define fg
  (lambda (colour)
    (tree->string
      `("^fg(" ,colour ")"))))

(define bg
  (lambda (colour)
    (cond
      (colour
        (string-concatenate
          `("^bg(" ,colour ")")))
      (else
        "^bg()")
      )))


(define fn
  (lambda (font)
    (tree->string
      `("^fn(" ,font ")"))))

;; xpm from powerline.el www.emacswiki.org/emacs/powerline.el
(define make-temp-dir
  (lambda ()
    (make-directory*
      (build-path (temporary-directory)
                  "dzen"))
    (build-path (temporary-directory)
                "dzen")))

(define arrow-left
  "/* XPM */

  static char * arrow_left[] = {
  /* <width/cols> <height/rows> <colors> <char on pixel>*/
  \"10 12 2 1\",
  \". c ~a\",
  \"  c ~a\",
  \"         .\",
  \"        ..\",
  \"       ...\",
  \"      ....\",
  \"     .....\",
  \"    ......\",
  \"    ......\",
  \"     .....\",
  \"      ....\",
  \"       ...\",
  \"        ..\",
  \"         .\",
  };
  "
  )

(define arrow-left-xpm
  (lambda (c1 c2)
    (let ((icon-name
            (build-path (make-temp-dir)
                        (string-append
                          "arrow-left"
                          "_"
                          (string-trim  c1 #\#) "_"
                          (string-trim  c2 #\#)
                          ".xpm"))))
      (make-xpm icon-name arrow-left c1 c2))))

(define icon
  (lambda (name)
    (string-concatenate
      `("^i("
        ,name
        ")"))))


;; printers
(define (date)
  (string-concatenate
    `(,(fg "#303633")
       ,(date->string (current-date)))))

(define (memory)
  (fifth
    (take-right
      (string-split
        (process-output->string "vmstat -h")
        " ")
      19)))

(define (fs)
  (let* ((fs-lst (map (lambda (s) (string-split s #/\s+/))
                      (cdr  (process-output->string-list "df -h"))))
         (find-fs (lambda (lst fs-name)
                    (find (lambda (l)
                            (cond ((string=? (sixth l) fs-name)
                                   l)
                              (else
                                #f)))
                          lst)))
         (root (find-fs fs-lst "/"))
         (quatre (find-fs fs-lst "/nfs/quatre"))
         (mypassport (find-fs fs-lst "/nfs/mypassport"))
         (deskstar (find-fs fs-lst "/nfs/deskstar"))
         (fs-remain (lambda (n)
                      (- (string->number (subseq (second n) 0 3))
                         (string->number (subseq (third n) 0 3))))))
    (list
      (cond ((list? root)
             (list
               (string-append
                 (fg "#b8b843")
                 "/ "
                 (fg "#acacac" )
                 (subseq  (third root) 0 3) "/" (second  root))))
        (else
          ""))
      (if (list? quatre)
        (list
          " "
          (fg "#f2a2a2")
          "q "
          (fg "#acacac" )
          (fs-remain quatre)
          "G" )
        "")
      (if (list? mypassport)
        (list
          " " (fg "#f282a2")
          "m "
          (fg "#ffffff" )
          (fs-remain mypassport)
          "G" )
        "")
      (if (list? deskstar)
        (list
          " "
          (fg "#f282a2")
          "d "
          (fg "#ffffff" )
          (fs-remain deskstar)
          "G")
        ""))))

(define (volume)
  (let ((vol (string-split (process-output->string "mixer -S vol") ":"))
        (pcm (string-split (process-output->string "mixer -S pcm") ":")))
    (list
      (fg "#43be93")
      (car  vol)
      " "
      (cadr vol)
      " "
      (car  pcm)
      " "
      (cadr pcm))))

(define (mpd)
  (let ((current-song (and (find-file-in-paths "mpc")
                        (process-output->string "mpc current"))))
    (cond
      (current-song
        (list
          (fg "#baafa9")
          current-song))
      (else
        (list
          "Not playng")))))

(define ip
  (lambda ()
    (process-output->string "curl --silent --ssl -x http://127.0.0.1:8118 ifconfig.me/ip")))


(define (dzen)
  (tree->string
    (list
      (icon (arrow-left-xpm "#292929" "None"))
      (bg "#292929")
      (mpd)
      (icon (arrow-left-xpm "#303633" "#292929"))
      (bg "#303633")
      (memory)
      (icon (arrow-left-xpm "#444444" "#303633"))
      (bg "#444444")
      (fs)
      (icon (arrow-left-xpm "#555555" "#444444"))
      (bg "#555555")
      (volume)
      (icon (arrow-left-xpm "#858180" "#555555"))
      (bg "#858080")
      (date) " ")))

(define (main args)
  (let loop ()
    (print
      (dzen))
    (loop)))
