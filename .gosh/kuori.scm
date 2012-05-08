#!/usr/bin/env gosh

(use gauche.process)
(use file.util)
(use srfi-1)
(use kirjasto)


(add-load-path "/usr/local/")

(define (mkdir kansio)
  (if (not (file-exists? kansio))
    (make-directory* kansio)))

(define (cd . kansio)
  (if (null?  kansio)
    (current-directory)
    (if (file-is-directory? (car  kansio))
      (begin
        (current-directory (car  kansio))
        (current-directory)
        (sys-setenv "PWD" (current-directory) #t)))))

(define repl.reader
  (lambda ()
    (let ((exp (read))
          (args (read-line)))
      (write args)
      (if  (not (list? args))
        (list exp args)
        exp)
      )))

(define repl.printer
  (lambda results
    (map (cut print (make-colour 133 "=> ") <>) results))
  )

(define repl.prompter
  (lambda ()
    (print (string-append
             (make-colour 44 "(")
             (symbol->string (module-name (current-module)))
             (make-colour 44 ")")))
    (display (make-colour 33 ">> "))
    (flush))
  )

(read-eval-print-loop
  repl.reader
  #f
  repl.printer
  repl.prompter
  )
