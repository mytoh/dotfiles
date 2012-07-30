
(define-module pikkukivi.napa
  (export napa)
  (use gauche.process)  
  (use gauche.parseopt)  
  (use file.util)  
  (use util.match)  
  (use kirjasto.komento.työkalu)
  (require-extension (srfi 1 13))
  )
(select-module pikkukivi.napa)

(define (git-clone args)
  (let-args args
    ((private-repo "p|private=s")
     . rest)
    (cond (private-repo
            (run-command `(git clone ,(string-append "git@github.com:" private-repo))))
      (else
        (if (rxmatch->string #/^http:\/\/.*|^git:\/\/.*/ (car rest))
          (run-command `(git clone ,(car rest)))
          ; clone github repository
          (run-command `(git clone ,(string-append "git://github.com/" (car rest)))))))))

(define git-create
  (lambda (repo-name)
    (let ((user (process-output->string
                  "git config --get github.user"))
          (token (process-output->string
                   "git config --get github.token"))))))

(define  (git args)
  (cond
    ((null? args)
     (run-command '(git)))
    (else
      (match (car args)
        ("clone"
         (git-clone (cdr args)))
        ("st"
         (run-command `(git status)))
        ((or"up" "pl")
         (run-command '(git pull)))
        ("create"
         (git-create args))
        ("co"
         (run-command `(git checkout ,@(cdr args))))
        (_  (run-command `(git ,@args)))))))

(define (svn args)
  (cond
    ((null? args)
     (run-command '(svn)))
    (else
      (match  (car args)
        ("st"
         (run-command '(svn status)))
        (_
          (run-command `(svn ,@args)))))))

(define (hg args)
  (cond
    ((null? args)
     (run-command '(hg)))
    (else
      (match (car args)
        ("st"
         (run-command '(hg status)))
        (_
          (run-command `(hg ,@args)))))))

(define (cvs args)
  (cond
    ((null? args)
    (run-command '(cvs)))
   (else
     (match (car args)
      ("up"
       (run-command '(cvs update)))
      (_
        (run-command `(cvs ,@args)))))))

(define (darcs args)
  (cond
    ( (null? args)
    (run-command '(darcs)))
    (else
      (match (car args)
      ("up"
       (run-command '(darcs pull)))
      (_
        (run-command `(darcs ,@args)))))))

(define (napa args)
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

