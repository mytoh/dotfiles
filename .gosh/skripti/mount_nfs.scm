#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use file.util)
(use util.match)
(use kirjasto.komento)

(define (usage status))
 

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
      ("all"
       (mount-mypassport)
       (mount-deskstar)
       (mount-quatre (cadr rest)))
      (_ (usage 1)))))

(define mount
  (lambda (src dest)
    (run-command-sudo
      `( mount -v ,src ,dest))))

(define (mount-mypassport)
  (mount "quatrevingtdix:/Volumes/MyPassport"
         "/nfs/mypassport"))

(define (mount-deskstar)
  (mount "quatrevingtdix:/Volumes/Deskstar"
         "/nfs/deskstar"))

(define (mount-quatre user)
  (mount (string-append "quatrevingtdix:/Users/" user)
         "/nfs/quatre"))
