#!/usr/bin/env gosh

(use gauche.process)
(use file.util)

(define (main args)
  (let ((user (cadr args)))
  (mount-directories user)
  )
  )
  

(define (mount-directories user)
  (run-process `(sudo mount_nfs quatrevingtdix:/Volumes/Deskstar
                       ,(string-append (home-directory) "/local/mnt/deskstar")) :wait #t)
  (run-process `(sudo mount_nfs quatrevingtdix:/Volumes/MyPassport
                       ,(string-append (home-directory) "/local/mnt/mypassport")) :wait #t)
  (run-process `(sudo mount_nfs ,(string-append "quatrevingtdix:/Users/" user)
                       ,(string-append (home-directory) "/local/mnt/quatre")) :wait #t)
  )
