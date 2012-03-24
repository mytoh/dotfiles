#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use gauche.collection)
(use file.util)
(use util.match)
(use util.list) ; slices
(use text.csv)
(require-extension (srfi 1 11 13))
(use kirjasto) ; run-command, run-command-sudo, make-colour

(define-constant package-directory "/var/db/pkg")
(define-constant ports-directory   "/usr/ports")

;; colour values, 256 terminal colour
(define-constant colour-category 172)
(define-constant colour-package  148)
(define-constant colour-version  172)

; info {{{

(define (package-list)
  (map simplify-path
    (directory-list package-directory :children? #t)))

(define (info-find-packages name)
  #| display installed package information|#
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
           (make-colour colour-package (car x))
           " "
           "["(make-colour 172 (cadr x)) "]"))
         (display "    ")
         (display (caddr x))
         (newline))
  (info-find-packages name)))
; }}}

; update {{{
(define (update-ports-tree)
  (run-command-sudo '(portsnap fetch update))
  )
; }}}

; install {{{
(define (install-package package)
  (current-directory (build-path ports-directory package))
  (print (string-append ">>> Installing " (make-colour 44 package)))
  (run-command '(sudo make clean))
  (colour-process "sudo make install clean"
                  (^x
                    (regexp-replace* x
                                     #/^(===>  )Patching (.*$)/   "[38;5;99m *[0m Applying patch \\2"
                                     #/^===>/   "[38;5;39m>>>[0m"
                                     #/\*\*\*.*$/    "[38;5;3m\\0[0m"
                                     )))
  )
; }}}

; search {{{

(define (search-find-package package)
  (let ((index-list
          (call-with-input-file
            (build-path ports-directory
                        (string-append
                          "INDEX-"
                          (car (string-split
                                 (caddr (sys-uname))
                                 "."))))
            (cut port->list
              (make-csv-reader #\|) <>))))
    (filter (^x (let ((x (map (^s (string-downcase s))
                              x)))
                  (or (string-scan (car x) package)
                  (string-scan (cadr x) package)
                  (string-scan (cadddr x) package))))
            index-list)))

(define (search-package-by-name package)
     (let1 found-list (search-find-package package)
       (for-each
         (lambda (x)
           (let ((package-name 
                   ; remove "/usr/ports/" from string
                   (string-split (string-drop (cadr x) 11)
                                 #\/))
                 (version 
                   (last (string-split 
                            (car x)
                            #\-))))
             (let-values (((category name) (values
                                             (car package-name)
                                             (cadr package-name))))
           (display
             (string-append " " 
                            (make-colour colour-category
                                         category)
                            "/"
                            (make-colour colour-package
                                                  name)))
           (display (string-append " ["
                                 (make-colour colour-version version)
                                 "]"))
           (newline)
           (print
             (string-append "    " (make-colour 244  (cadddr x))))
           )))
         found-list)))

; }}}

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
