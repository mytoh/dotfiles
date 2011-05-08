#!/usr/local/bin/gosh

(use gauche.process) ; run-process 
(use file.util) ; directory-list, current-directory

(define gitdir  "~/local/git/")

(define (update-gitdir git)
  (let ((dirs (directory-list (expand-path git) :children? #t :add-path? #t)))
       (let loop ((dirs dirs))
            (begin
              (current-directory (car dirs)) ;change directory to argument 
              (run-process '(git pull) ))
            (loop (cdr dirs)))
   ))
               


(update-gitdir gitdir)
