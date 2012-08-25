#!/usr/bin/env gosh
;; -*- coding: utf-8 -*-

(use gauche.process)
(use gauche.parseopt)
(use util.match)
(use file.util)
(use clojure)
(require-extension (srfi 13 98))

(define (colour-string colour-number str)
  (let ((shell (sys-basename (get-environment-variable "SHELL"))))
    (cond
      ((string=? shell "tcsh")
        (string-concatenate
          `("%{[38;5;" ,(number->string colour-number) "m%}"
            ,str
            "%{[0m%}")))
      (else
        (string-concatenate
          `("[38;5;" ,(number->string colour-number) "m"
            ,str
            "[0m"))))))

(define (directory)
  (let* ((cwd (current-directory))
         (colour-fs (lambda (fs d)
                      (string-append
                        "~"
                        d))))
    (rxmatch-cond
      ;; /usr/home => ~
      (((string->regexp (string-concatenate `("/usr" ,(home-directory))))
        cwd)
       (home)
       (prettify-directory
         (string-split
           (regexp-replace (string->regexp home) cwd "~") "/")))
      ;; $HOME => ~`
      (((string->regexp (home-directory)) cwd)
       (home)
       (prettify-directory
         (string-split
           (regexp-replace (string->regexp home) cwd "~") "/")))
      ;; /nfs/mypassport => ~mypass
      (((string->regexp "/nfs/mypassport")
        cwd)
       (m)
       (colour-fs
         "mypass"
         (prettify-directory (cddr (string-split cwd "/")))))
      ;; /nfs/deskstar => ~deskstar
      (((string->regexp "/nfs/deskstar")
        cwd)
       (m)
       (colour-fs "deskstar"
                  (prettify-directory (cddr (string-split cwd "/")))))
      ;; /nfs/quatre => ~quatre
      (((string->regexp "/nfs/quatre")
        cwd)
       (m)
       (colour-fs "quatre"
                  (prettify-directory (cddr (string-split cwd "/")))))
      (else
        (prettify-directory
          (string-split cwd "/"))))))

(define (prettify-directory lst)
  (string-join (map
                 (lambda (d) (colour-string 110 d))
                 lst)
               (colour-string 240 "/"))) ;U2A20


(define (git)
  (let ((git-branch (lambda ()
                      (sys-basename (string-copy
                                      (process-output->string
                                        "git symbolic-ref HEAD")
                                      2))))
        (git-darty (lambda ()
                     (let* ((p (run-process '(git diff --quiet HEAD) :wait #t))
                            (status (process-exit-status p)))
                       (if-not (zero? status)
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
        ,(colour-string 123 "(")
        ,(colour-string 74 "・x・")
        ,(colour-string 123 ")")
        ,(colour-string 0 ".")
        ,(colour-string 118 (car (string-split (sys-gethostname) "." )))
        " :: "
        ,(directory)
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
        ,(colour-string 236 "-")
        ,(colour-string 238 ">")
        ,(colour-string 60  ">")
        " "))))




(define (main args)
  (prompt))
