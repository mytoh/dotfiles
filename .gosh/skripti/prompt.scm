#!/usr/bin/env gosh
;; -*- coding: utf-8 -*-

(use gauche.process)
(use gauche.parseopt)
(use util.match)
(use file.util)
(require-extension (srfi 13))
(use kirjasto.väri)

(define (directory)
  (let* ((cwd (current-directory))
        (colour-fs (lambda (fs m)
                     (regexp-replace (string->regexp m)
                                     cwd
                                     (string-append
                                       "~"
                                       (colour-string 83 fs))))))
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
      `(,(colour-string 33 "  ♠ ")
         ,(colour-string 82 (git-branch))
         ,(colour-string 1  (git-darty))))))

(define (hg)
  (colour-string 33 " ⮘ ")
  )

(define (svn)
  (colour-string 33 " ǂ "))

(define darcs
  (lambda ()
    (colour-string 33 " darcs ")))

(define (prompt)
  (display
    (string-concatenate
      `(
        ; ,(colour-string 172 "X / _ / X")
        ,(colour-string 223 "(")
        ,(colour-string 74 "・x・")
        ,(colour-string 223 ")")
        ,(colour-string 0 ".")
        ,(colour-string 118 (car (string-split (sys-gethostname) "." )))
        " :: "
        ,(colour-string 4 (directory))
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
        " "
         ,(colour-string 95 "✖")
         ,(colour-string 172 "╹◡╹")
         ,(colour-string 95 "✖")
        "\n"
        ,(colour-string 235 ">")
        ,(colour-string 238 ">")
        ,(colour-string 60  ">")
        " "))))

(define (main args)
  (prompt))
