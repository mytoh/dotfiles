#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use gauche.collection)
(use file.util)
(use util.match)
(require-extension (srfi 1))
(use kirjasto) ; run-command, run-command-sudo, make-colour

(define-constant package-directory "/var/db/pkg")
(define-constant ports-directory   "/usr/ports")

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

(define (info-print-packages name)
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

(define (update-ports-tree)
  (run-command-sudo '(portsnap fetch update))
  )

(define (install-package package)
  (current-directory (build-path ports-directory package))
  (print (string-append ">>> Installing " (make-colour 44 package)))
  (run-command-sudo '(make install))
  )

(define (search-package-by-name package)
  (current-directory ports-directory)
  ; (run-command `(make search ,(string-append "name=" package)) )
  (colour-process (string-append "make search name=" package)
                  (^x (regexp-replace* x
                             #/^Port:\s?(.*$)/   "Port:\t[38;5;99m\\1[0m"
                             #/^Info:\s?(.*$)/   "Info:\t[38;5;39m\\1[0m"
                             #/^-*/    "[38;5;233m\\0[0m"
                             #/c\+\+\s/ "[38;5;44m\\0[0m"
                             #/(cc)\s/  "[38;5;128m\\0[0m"
                             #/\/(\w*\.cpp)/  "/[38;5;178m\\1[0m"
                             #/\/(\w*\.c)/  "/[38;5;68m\\1[0m"
                             #/(\w*\.o)/  "[38;5;148m\\1[0m"
                             #/(\w*\.So)/  "[38;5;248m\\1[0m"
                             #/(\w*\.so)/  "[38;5;248m\\1[0m"
                             )))
  )

(define (usage status)
  (exit status "usage: ~a <command> <package-name>\n" *program-name*))

(define (main args)
  (let-args (cdr args)
    ((#f "h|help" (usage 0))
     . rest)
    (match (car rest)
      ; commands
      ("info"
       (info-print-packages (cadr rest)))
      ((or "update" "up")
       (update-ports-tree ))
      ("install"
       (install-package (cadr rest)))
      ("search"
       (search-package-by-name (cadr rest)))
      (_ (usage 1))))
  0)
