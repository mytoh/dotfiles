#!/usr/local/bin/gosh

(use gauche.process) ; run-process 
(use file.util) ; directory-list, current-directory

(define gitdir  "~/local/git/")

(define (update-gitdir gitdir)
  (let ((dirs (list (directory-list (expand-path gitdir) :children? #t :add-path? #t))))
       (let loop ((dirs (car dirs)))
            (if (null? dirs)
                (display "update finied!\n")
                (begin
                  (display (car dirs) )
                  (display "\n" )
                  (current-directory (car dirs)) ;change directory to argument 
                  (run-process '(git pull) :wait #t)
                  (display "\n")
                  (loop (cdr dirs)))))))

(update-gitdir gitdir)
