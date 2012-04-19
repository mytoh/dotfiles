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
    (run-process `(git clone ,(string-append "git://github.com/" url)) :wait #t)
    )
  )

(define  (git args)
  (match (car args)
    ("clone"
     (git-clone (cadr args)))
    ("st"
     (run-process `(git status) :wait #t))
    (_  ( run-process `(git ,@args) :wait #t))
    )
  )

(define (svn args)
  (match  (car args)
    ("st"
     (run-process '(svn status) :wait #t))
    (_
      (run-process `(svn ,@args) :wait #t))
    )
  )

  (define (hg args)
    (match (car args)
      ("st"
       (run-process '(hg status) :wait #t))
      (_
        (run-process `(hg ,@args) :wait #t))
      )
    )


  (define (hub args)
    (cond
      ((file-exists? (build-path (current-directory) ".hg"))
       (hg args))
      ((file-exists? (build-path (current-directory) ".git"))
       (git args))
      ((file-exists? (build-path (current-directory) ".svn"))
       (svn args))
      (else
        (git args))
      )
    )



  (define (main args)
    (hub (cdr args))
    )
