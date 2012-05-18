#!/usr/bin/env gosh
;; -*- coding: utf-8 -*-

(use gauche.process)
(use gauche.parseopt)
(use util.match)
(use file.util)
(require-extension (srfi 13))
(use kirjasto)

(define (directory)
  (let* ((cwd (current-directory))
        (colour-fs (lambda (fs m)
                     (regexp-replace (string->regexp m)
                                     cwd
                                     (string-append
                                       "~"
                                       (make-colour 83 fs))))))
    (rxmatch-cond
      ;; /usr/home => ~
      ((rxmatch (string->regexp (string-concatenate `("/usr" ,(home-directory))))
                cwd)
       (home)
       (regexp-replace (string->regexp home) cwd "~"))
      ;; $HOME => ~`
      ((rxmatch (home-directory) cwd)
       (home)
       (regexp-replace (string->regexp home) cwd "~"))
      ;; /mnt/mypassport => ~mypass
      ((rxmatch (string->regexp "/mnt/mypassport")
                cwd)
       (m)
       (colour-fs "mypass" m))
      ;; /mnt/deskstar => ~deskstar
      ((rxmatch (string->regexp "/mnt/deskstar")
                cwd)
       (m)
       (colour-fs "deskstar" m))
      ;; /mnt/quatre => ~quatre
      ((rxmatch (string->regexp "/mnt/quatre")
                cwd)
       (m)
       (colour-fs "quatre" m))
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
    (string-concatenate
      `(,(make-colour 33 "  ♠ ")
         ,(make-colour 82 (git-branch))
         ,(make-colour 1  (git-darty)))))
  )

(define (hg)
  (make-colour 33 " ⮘ ")
  )

(define (svn)
  (make-colour 33 " ǂ "))

(define darcs
  (lambda ()
    (make-colour 33 " darcs ")))

(define (prompt)
  (display
    (string-concatenate
      `(
        ; ,(make-colour 172 "X / _ / X")
        ,(make-colour 172 "(・x・)")
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
           ((file-exists? "./_darcs")
            (darcs))
           (else ""))
        "\n"
        ,(make-colour 235 ">")
        ,(make-colour 238 ">")
        ,(make-colour 60  ">")
        " "))))

(define (main args)
  (prompt))
