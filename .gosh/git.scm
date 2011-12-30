#!/usr/local/bin/gosh

(use gauche.process) ; run-process 
(use file.util) ; directory-list, current-directory

(define-constant gitdir  "~/local/git/")

(define (make-colour colour str)
    (string-append "[38;5;" (x->string colour) "m" str "[0m"))

(define (update-gitdir gitdir)
  (let ((dirs (list (directory-list (expand-path gitdir) :children? #t :add-path? #t))))
       (let loop ((dirs (car dirs)))
            (if (null? dirs)
                (display "update finished!\n")
                (begin
                  (display (make-colour 4 "=> "))
                  (display (string-append (sys-dirname (car dirs)) "/" (make-colour 3 (sys-basename (car dirs)))))
                  (newline)
                  (if (file-is-directory? (car dirs))
                  (run-process '(git pull) :wait #t :directory (car dirs))
                  #t)
                  (newline)
                  (loop (cdr dirs)))))))

(update-gitdir gitdir)

