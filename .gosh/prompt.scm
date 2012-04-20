#!/usr/bin/env gosh
;; -*- coding: utf-8 -*-

(use gauche.process)
(use gauche.parseopt)
(use util.match)
(use file.util)
(use text.tree)
(use kirjasto)

(define (directory)
  (let ((cwd (current-directory)))
    (rxmatch-cond
      ((rxmatch (string->regexp (tree->string `("/usr" ,(home-directory))))
                cwd)
       (home)
       (regexp-replace (string->regexp home) cwd "~"))
      ((rxmatch (home-directory) cwd)
       (home)
       (regexp-replace (string->regexp home) cwd "~"))
      (else cwd))))

(define (git)
  (if (file-exists? ".git")
    (let ((git-branch (lambda () 
                        (string-copy 
                          (process-output->string 
                            "git branch")
                          2)))
          (git-darty (lambda ()
                       (let* ((p (run-process '(git diff --quiet HEAD) :wait #t))
                              (status (process-exit-status p)))
                         (if (not (zero? status))
                           " ÷"
                           "")))))
      (tree->string
        `( ,(make-colour 33 "  ♠ ")  
           ,(make-colour 82 (git-branch))  
           ,(make-colour 1  (git-darty)))))
    ""))

(define (prompt)
  (display (make-colour 172 "X / _ / X"))
  (display (make-colour 0 "."))
  (display (make-colour 118 (car (string-split (sys-gethostname) "." ))))
  (display " :: ")
  (display (make-colour 4 (directory)))
  (display (git))

  (newline)

  (display (tree->string
             `( ,(make-colour 235 ">")  
                ,(make-colour 238  ">")  
                ,(make-colour 60 ">"))))
  (display " ")
  (newline))

(define (main args)
  (prompt))
