;; -*- coding: utf-8 -*-

(define-module pikkukivi.launch-app
  (export launch-app)
  (use gauche.process)
  (use gauche.parseopt)
  (use util.match)
  (use file.util)
  )
(select-module pikkukivi.launch-app)


(define (launch app)
  (if (find-file-in-paths (car app))
    (begin
      (display "launching ")
      (display (car  app))
      (newline)
      (run-process app
                   :detached #t
                   :output :null
                   :error :null))
    (print (string-append "no such command "
                          (car app)))))


(define (launch-app args)
  (launch args))
