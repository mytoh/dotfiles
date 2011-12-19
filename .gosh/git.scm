#!/usr/local/bin/gosh

(use gauche.process) ; run-process 
(use file.util) ; directory-list, current-directory

(define-constant gitdir  "~/local/git/")

(define (update-gitdir gitdir)
  (let ((dirs (list (directory-list (expand-path gitdir) :children? #t :add-path? #t))))
       (let loop ((dirs (car dirs)))
            (if (null? dirs)
                (display "update finished!\n")
                (begin
                  (display "=> ")
                  (display (car dirs) )
                  (newline)
                  (run-process '(git pull) :wait #t :directory (car dirs))
                  (newline)
                  (loop (cdr dirs)))))))

(update-gitdir gitdir)

