#!/usr/local/bin/gosh

(use gauche.process) ; run-process 
(use file.util) ; directory-list, current-directory

(define gitdir  "~/local/git/")

(define (update-gitdir git)
  (let ((dirs (directory-list (expand-path git) :children? #t :add-path? #t)))
       (let loop ((dir dirs))
            (if (null? dir)
                (display "update finied!")
                (begin
                  (current-directory (car dir)) ;change directory to argument 
                  (run-process '(git pull) )
                (loop (cdr dir)))))))

(update-gitdir gitdir)
