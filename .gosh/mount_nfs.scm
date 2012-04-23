#!/usr/bin/env gosh

(use gauche.process)
(use file.util)
(use kirjasto)

(define (main args)
  (let ((user (cadr args)))
    (mount-directories user)))

(define (mount-directories user)
  (run-commands 
    `(sudo mount -v quatrevingtdix:/Volumes/Deskstar
           /mnt/deskstar)
    `(sudo mount -v quatrevingtdix:/Volumes/MyPassport
           /mnt/mypassport)
    `(sudo mount -v ,(string-append "quatrevingtdix:/Users/" user)
           /mnt/quatre)))
