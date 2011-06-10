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
  (run-process `(sshfs ,(string-append (car user) "@192.168.1.3:") ,(string-append (home-directory) "/local/mnt/quatre") -o idmap=user ))
  (run-process `(sshfs ,(string-append (car user) "@192.168.1.3:/Volumes/MyPassport") ,(string-append (home-directory) "/local/mnt/mypassport") -o idmap=user ))
  (run-process `(sshfs ,(string-append (car user) "@192.168.1.3:/Volumes/Deskstar") ,(string-append (home-directory) "/local/mnt/deskstar") -o idmap=user ))
  ))

