#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use file.util)
(use util.match)
(use kirjasto)

(define (main args)
  (let-args (cdr args)
    ((#f "h|help" (usage 0))
     . rest)
    (match (car rest)
      ; commands
      ("mypassport"
       (mount-mypassport))
      ("deskstar"
       (mount-deskstar))
      ("quatre"
       (mount-quatre (cadr rest)))
      (_ (usage 1))))
  )

(define (mount-mypassport)
  (run-command
    `(sudo mount -v quatrevingtdix:/Volumes/MyPassport
           /mnt/mypassport)))

(define (mount-deskstar)
  (run-command
    `(sudo mount -v quatrevingtdix:/Volumes/Deskstar
           /mnt/deskstar)
    ))

(define (mount-quatre user)
  (run-command
    `(sudo mount -v ,(string-append "quatrevingtdix:/Users/" user)
           /mnt/quatre)))
