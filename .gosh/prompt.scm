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
      `(,(make-colour 33 "  ♠ ")
         ,(make-colour 82 (git-branch))
         ,(make-colour 1  (git-darty)))))
  )

(define (hg)
  (make-colour 33 " ⮘ ")
  )

(define (svn)
  (make-colour 33 " ǂ "))

(define (prompt)
    (write-tree
      `(
        ,(make-colour 172 "X / _ / X")
        ,(make-colour 0 ".")
        ,(make-colour 118 (car (string-split (sys-gethostname) "." )))
        " :: "
        ,(make-colour 4 (directory))

        ,(cond
           ((file-exists? "./.hg")
            (hg))
           ((file-exists? "./.git")
            (git))
           ((file-exists? "./.svn")
            (svn))
           (else ""))
        ))
  (newline)
  (write-tree
    `(
      ,(make-colour 235 ">")
      ,(make-colour 238 ">")
      ,(make-colour 60  ">")
      " "
      ))
  (newline)
  )

(define (main args)
  (prompt))
