#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use file.util)
(use util.match)
(use kirjasto)

(define (git-clone url)
  (if (rxmatch->string #/^http:\/\/.*|^git:\/\/.*/ url)
    (run-process `(git clone ,url) :wait #t)
    ; clone github repository
    (run-process `(git clone ,(string-append "git://github.com/" url)) :wait #t)))

(define git-create
  (lambda (repo-name)
    (let ((user (process-output->string
                  "git config --get github.user"))
          (token (process-output->string 
                   "git config --get github.token")))
      )
    ))

(define  (git args)
  (cond
    ((null? args)
     (run-process '(git) :wait #t ))
    (else
      (match (car args)
        ("clone"
         (git-clone (cadr args)))
        ("st"
         (run-process `(git status) :wait #t))
        ("up"
         (run-process '(git pull) :wait #t))
        ("create"
         (git-create args))
        (_  (run-process `(git ,@args) :wait #t))))))

(define (svn args)
  (cond
    ((null? args)
     (run-process '(svn) :wait #t))
    (else
      (match  (car args)
        ("st"
         (run-process '(svn status) :wait #t))
        (_
          (run-process `(svn ,@args) :wait #t))))))

(define (hg args)
  (cond
    ((null? args)
     (run-process '(hg) :wait #t))
    (else
      (match (car args)
        ("st"
         (run-process '(hg status) :wait #t))
        (_
          (run-process `(hg ,@args) :wait #t))))))

(define (cvs args)
  (cond
    ((null? args)
    (run-process '(cvs) :wait #t))
   (else
     (match (car args)
      ("up"
       (run-process '(cvs update) :wait #t))
      (_
        (run-process `(cvs ,@args) :wait #t))))))

(define (darcs args)
  (cond  
    ( (null? args)  
    (run-process '(darcs) :wait #t))  
    (else  
      (match (car args)
      ("up"
       (run-process '(darcs pull) :wait #t))
      (_
        (run-process `(darcs ,@args) :wait #t))))))

(define (hub args)
  (cond
    ((file-exists? (build-path (current-directory) ".hg"))
     (hg args))
    ((file-exists? (build-path (current-directory) ".git"))
     (git args))
    ((file-exists? (build-path (current-directory) ".svn"))
     (svn args))
    ((file-exists? (build-path (current-directory) "CVS"))
     (cvs args))
    ((file-exists? (build-path (current-directory) "_darcs"))
     (darcs args))
    (else
      (print "not vcs directory launching GIT.")
      (git args))))



(define (main args)
  (hub (cdr args)))
