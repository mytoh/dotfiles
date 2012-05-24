#!/usr/bin/env gosh

(use file.util)
(use gauche.parameter)
(use panna.ympäristö)
(use panna.työkalu)

(define (list-packages)
  (let* ((panna   (make-parameter (resolve-path (sys-getenv "OLUTPANIMO"))))
         (kellari (make-parameter (build-path (panna) "kellari"))))
    (display (colour-string 99 ">>> "))
    (display "installed packages")
    (newline)
    (map print
         (directory-list (kellari) :children? #t))))

(define (list-package-contents kaava)
  (let* ((panna   (make-parameter (resolve-path (sys-getenv "OLUTPANIMO"))))
         (kellari (make-parameter (build-path (panna) "kellari")))
         (tynnyri (make-parameter (build-path (kellari) kaava))))
    (print (string-append (colour-string 99 ">>> ")
                          "files installed as "
                          (colour-string 229 kaava)))
    (for-each print
    (directory-fold (tynnyri) cons '()
                    :lister (lambda (path seed)
                              (values (directory-list path :add-path? #t :children? #t)
                                      (cons path seed))))) 
    ))

(define (main args)
  (if (<= 2 (length args))
    (list-package-contents (cadr args))
    (list-packages )))
