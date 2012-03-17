#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use gauche.collection)
(use file.util)
(require-extension (srfi 1))
(use kirjasto)

(define-constant package-directory "/var/db/pkg/")
(define (package-list)
  (map simplify-path 
    (directory-list package-directory :children? #t)))


(define (find-packages name)
(let1 list-packages (lambda (n)
                      (filter
                        (lambda (s)
                          (string-scan s n))
                        (package-list)))
  (map
    (lambda (s)
      (let* ((full-name (string-split s "-"))
            (version-number (last full-name)))
         (list
           (string-join
             (remove
               (lambda (x) (eq? x version-number)) full-name)
             "-")
               version-number
               (file->string (build-path package-directory s "+COMMENT"))
               )))
    (list-packages name))))

(define (print-packages name)
  (map (lambda (x)
         (print
           (string-append
             " "
           (make-colour 83 (car x))
           " "
           "["(make-colour 172 (cadr x)) "]"
           ))
         (display "    ")
         (display (caddr x))
         (newline)
           )
  (find-packages name)))

(define (main args)
  (print-packages (cadr args))
  )
