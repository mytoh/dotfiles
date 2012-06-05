#!/usr/bin/env gosh
;; -*- coding: utf-8 -*-

(use gauche.process)
(use gauche.parseopt)
(use gauche.sequence)
(use util.match)
(use text.tree)
(use file.util)
(require-extension (srfi 1 13 19))

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
\"12 16 2 1\",
\". c ~a\",
\"  c ~a\",
\"           .\",
\"          ..\",
\"         ...\",
\"        ....\",
\"       .....\",
\"      ......\",
\"     .......\",
\"    ........\",
\"    ........\",
\"     .......\",
\"      ......\",
\"       .....\",
\"        ....\",
\"         ...\",
\"          ..\",
\"           .\", };
"
  )

(define arrow-left-xpm
  (lambda (c1 c2)
  (make-xpm "arrow_left" c1 c2 arrow-left)))

(define make-xpm
  (lambda (name c1 c2 data)
    (let ((icon-name
            (build-path (make-temp-dir)
                        (string-append
                          name
                          "_"
                          (string-trim  c1 #\#) "_"
                          (string-trim  c2 #\#)
                          ".xpm"))))
      (cond
        ((file-is-readable? icon-name)
         icon-name)
        (else
          (call-with-output-file
            icon-name
            (lambda (out)
              (format
                out
                data
                c1 c2))
            :if-exists #f
            :if-does-not-exist :create)
          icon-name)))))

(define icon
  (lambda (name)
    (string-concatenate
      `("^i("
        ,name
        ")"
        ))))


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
         (quatre (find-fs fs-lst "/mnt/quatre"))
         (mypassport (find-fs fs-lst "/mnt/mypassport"))
         (deskstar (find-fs fs-lst "/mnt/deskstar"))
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
      (car  vol)
      " "
      (cadr vol)
      " "
      (car  pcm)
      " "
      (cadr pcm))))

(define (mpd)
  (let ((current-song (process-output->string "mpc current")))
    (cond
      (current-song
        (list
          (fg "#ababab")
          current-song))
      (else
        (list
          "Not playng")))))


(define (dzen)
  (tree->string
    `(
      " " ,(mpd) " "
      ,(icon (arrow-left-xpm "#303633" "None"))
      ,(bg "#303633")
      " " ,(memory) " "
      ,(icon (arrow-left-xpm "#444444" "#303633"))
      ,(bg "#444444")
      " " ,(fs) " "
      ,(icon (arrow-left-xpm "#555555" "#444444"))
      ,(bg "#555555")
      " " ,(volume) " "
      ,(icon (arrow-left-xpm "#c5d1c0" "#555555"))
      ,(bg "#c5d1c0")
      " " ,(date) " ")))

(define (main args)
  (let loop ()
    (print
      (dzen))
    (loop )))
