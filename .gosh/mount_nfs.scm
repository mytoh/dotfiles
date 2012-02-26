#!/usr/bin/env gosh

(use gauche.process)
(use file.util)

(define (main args)
  (let ((user (cadr args)))
  (mount-directories user)))

(define (mount-directories user)
  (run-process `(sudo mount -v 192.168.1.3:/Volumes/Deskstar
                       ,(string-append (home-directory) "/local/mnt/deskstar")) :wait #t)
  (run-process `(sudo mount -v 192.168.1.3:/Volumes/MyPassport
                       ,(string-append (home-directory) "/local/mnt/mypassport")) :wait #t)
  (run-process `(sudo mount -v ,(string-append "192.168.1.3:/Users/" user)
                       ,(string-append (home-directory) "/local/mnt/quatre")) :wait #t))
