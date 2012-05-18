#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use gauche.sequence)
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

(define fg
  (lambda (c)
    (tree->string
      `("^fg(" ,c ")"))))

(define bg
  (lambda (c)
    (tree->string
      `("^bg(" ,c ")"))))


(define fn
  (lambda (f)
    (tree->string
      `("^fn(" ,f ")"))))

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
         (quatre (find (lambda (l) (if (string= (sixth l) "/mnt/quatre")
                                     l #f))
                       fs-lst))
         (mypassport (find (lambda (l) (if (string= (sixth l) "/mnt/mypassport")
                                         l #f))
                           fs-lst))
         (deskstar (find (lambda (l) (if (string= (sixth l) "/mnt/deskstar")
                                       l #f))
                         fs-lst))
         (fs-remain (lambda (n)
                      (- (string->number (subseq (second n) 0 3))
                         (string->number (subseq (third n) 0 3)))))
         )
    (list
        (if (list? root)
          (list
            (string-append
              (fg "#294282")
              "/ "
              (fg "#acacac" )
              (subseq  (third root) 0 3) "/" (second  root)))
          "")
        (if (list? quatre)
            (list
              " "
              (fg "#f2a2a2")
              "q "
              (fg "#acacac" )
              (fs-remain quatre)
              "/" (second quatre))
          "")
        (if (list? mypassport)
            (list
              " " (fg "#f282a2")
              "m "
              (fg "#ffffff" )
              (fs-remain mypassport)
              "/" (second mypassport))
          "")
        (if (list? deskstar)
            (list
              " "
              (fg "#f282a2")
              "d "
              (fg "#ffffff" )
              (fs-remain deskstar)
              "/"
              (second deskstar))
          ""))
))

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

(define (mpd)
 (let ((current-song (process-output->string "mpc current")))
   (if (null? current-song)
     (list "Not playng")
     (list
       (fg "#ababab")
     current-song)
     )))


(define (dzen)
  (tree->string
    `(
      " " ,(mpd) " "
      " " ,(volume) " "
      " " ,(memory) " "
      " " ,(fs) " "
      " " ,(date) " ")))

(define (main args)
  (let loop ()
    (print
      (dzen))
    (sys-nanosleep 1000000000)
    (loop )))
