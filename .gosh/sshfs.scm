#!/usr/local/bin/gosh

(use gauche.process)
(use file.util)

(define (main args)
  (let ((user (cdr args)))
       (mount-dirctories user)
       )
  0)

(define (mount-dirctories user)
  (begin
  (run-process `(sshfs ,(string-append (car user) "@quatrevingtdix:") ,(string-append (home-directory) "/local/mount/quatre") -o idmap=user ))
  (run-process `(sshfs ,(string-append (car user) "@quatrevingtdix:/Volumes/MyPassport") ,(string-append (home-directory) "/local/mount/mypassport") -o idmap=user ))
  (run-process `(sshfs ,(string-append (car user) "@quatrevingtdix:/Volumes/Deskstar") ,(string-append (home-directory) "/local/mount/deskstar") -o idmap=user ))
  ))

