#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use util.match)
(use text.tree)
(require-extension (srfi 1 13 19))

(define-syntax forever
  ;;macro for endless loop
  (syntax-rules ()
    ((_ e1 e2 ...)
     (let loop () e1 e2 ...
       (sys-sleep 3) ; sleep 5 minutes
       (loop)))))

(define (date)
  (date->string (current-date))
  )

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
         (root (find (lambda (l) (if (string= (sixth l) "/")
                                   l
                                   #f))
                     fs-lst))
         (mypassport (find (lambda (l) (if (string= (sixth l) "/mnt/mypassport")
                                         l #f))
                           fs-lst))
         )
    (string-append
      "/ " (third root) "/" (second  root)
      "  "
      "mypassport " (third mypassport) "/" (second mypassport)
      ))) 

(define (volume)
  (let ((vol (string-split (process-output->string "mixer -S vol") ":"))
        (pcm (string-split (process-output->string "mixer -S pcm") ":")))
    (string-append
      (car  vol)  
      " "
      (cadr vol)
      " "
      (car  pcm)
      " "
      (cadr pcm))))

(define (colour fg bg)
  (tree->string
    `(
      "^fg(" ,fg ")"
      "^bg(" ,bg ")")))

(define (dzen)
  (tree->string
    `(
      ,(colour "#ffffff" "#000000")
      " " ,(volume) " "
      ,(colour "#ffffff" "#111111")
      " " ,(memory) " "
      ,(colour "#ffffff" "#222222")
      " " ,(fs) " "
      ,(colour "#ffffff" "#444444")
      " " ,(date) " "
      )))

(define (main args)
  (let loop ()
    (print
      (dzen))
    (sys-nanosleep 100000000)
    (loop )))
