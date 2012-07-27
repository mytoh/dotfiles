#!/usr/bin/env gosh

;; FreeBSD ports tool

(use gauche.process)
(use gauche.parseopt)
(use gauche.collection)
(use file.util)
(use util.match)
(use util.list) ; slices
(use text.csv)
(require-extension (srfi 1 11 13))
(use kirjasto) ; run-command, run-command-sudo, colour-string, colour-command , concat

(define-constant package-directory "/var/db/pkg")
(define-constant ports-directory   "/usr/ports")

;; colour values, 256 terminal colour
(define-constant colour-message  138)
(define-constant colour-symbol   97)
(define-constant colour-package  49)
(define-constant colour-package-category 172)
(define-constant colour-package-version  142)
(define-constant colour-package-description  244)

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
            (file->string (build-path package-directory s "+COMMENT")))))
      (list-packages name))))

(define (info-print-packages name)
  (map (lambda (x)
         (print
           (concat
             `(" "
               ,(colour-string colour-package (car x))
               " "
               "["
               ,(colour-string 172 (cadr x)) "]")))
         (display "    ")
         (display (caddr x))
         (newline))
       (info-find-packages name)))
; }}}

; update {{{
(define (update-ports-tree)
  (cond 
    ((file-exists? "/usr/ports")
     (run-command-sudo '(svn up /usr/ports)))
    (else
      (run-command-sudo '(svn checkout -q http://svn.freebsd.org/ports/head /usr/ports)))))
; }}}

;; srcup {{{
;; update kernel source
(define (update-source-tree)
  (cond
    ((file-exists? "/usr/src")
     (run-command-sudo '(svn up /usr/src)))
    (else
      (run-command-sudo '(svn co -q http://svn.freebsd.org/base/head /usr/src)))))
;; }}}

; install {{{
(define (install-package package)
  (current-directory (build-path ports-directory package))
  (print (concat (colour-string colour-symbol ":: ")
                 (colour-string colour-message "Installing ")
                 (colour-string colour-package package)))
  (run-command-sudo '(make clean))
  (run-command-sudo '(make config-recursive))
  (colour-command "sudo make install clean"
                  #/^(===>  )Patching (.*$)/   "[38;5;99m *[0m Applying patch \\2"
                  #/^===>/   "[38;5;39m>>>[0m"
                  #/^=>/   "[38;5;99m>>>[0m"
                  #/\*\*\*.*$/    "[38;5;3m\\0[0m"))
; }}}

; deinstall {{{
(define (deinstall-package package)
  (current-directory (build-path ports-directory package))
  (print (concat  (colour-string colour-symbol ":: ")
                 (colour-string colour-message "Deinstalling ")
                 (colour-string colour-package package)))
  (colour-command "sudo make deinstall"
                  #/^(===>  )Patching (.*$)/   "[38;5;99m *[0m Applying patch \\2"
                  #/^===>/   "[38;5;39m>>>[0m"
                  #/\*\*\*.*$/    "[38;5;3m\\0[0m"))

; }}}

; reinstall {{{
(define (reinstall-package package)
  (current-directory (build-path ports-directory package))
  (print (string-append (colour-string colour-symbol ":: ")
                        (colour-string colour-message "Reinstalling ")
                        (colour-string colour-package package)))
  (run-command-sudo '(make clean))
  (run-command-sudo '(make config))
  (colour-command "sudo make"
                  #/^(===>  )Patching (.*$)/   "[38;5;99m *[0m Applying patch \\2"
                  #/^===>/   "[38;5;39m>>>[0m"
                  #/^=>/   "[38;5;99m>>>[0m"
                  #/\*\*\*.*$/    "[38;5;3m\\0[0m")
  (deinstall-package package)
  (colour-command "sudo make install clean"
                  #/^(===>  )Patching (.*$)/   "[38;5;99m *[0m Applying patch \\2"
                  #/^===>/   "[38;5;39m>>>[0m"
                  #/^=>/   "[38;5;99m>>>[0m"
                  #/\*\*\*.*$/    "[38;5;3m\\0[0m"))
; }}}

; search {{{

(define (search-find-package package)
  (let ((index-list
          (call-with-input-file
            (build-path ports-directory
                        (string-concatenate
                          `("INDEX-"
                            ,(car (string-split
                                    (caddr (sys-uname))
                                    ".")))))
            (cut port->list
              (make-csv-reader #\|) <>))))
    (filter (^x (let ((x (map (^s (string-downcase s))
                              x)))
                  (or (string-scan (car x) package)
                    (string-scan (cadr x) package)
                    (string-scan (cadddr x) package))))
            index-list)))

(define (search-package-by-name package)
  (print (string-append (colour-string colour-symbol ":: ")
                        (colour-string colour-message "Searching ")
                        (colour-string colour-package package)))
  (let1 found-list (search-find-package package)
    (for-each
      (lambda (x)
        (let ((package-name
                ; remove "/usr/ports/" from string
                (string-split
                  (string-drop (cadr x) 11)
                  #\/))
              (version
                (last (string-split
                        (car x)
                        #\-))))
          (let-values (((category name)
                        (values
                          (car package-name)
                          (cadr package-name))))
            (display
              (string-concatenate
                `(" "
                  ,(colour-string colour-package-category
                                  category)
                  "/"
                  ,(colour-string colour-package
                                  name))))
            (print
              (concat " [" (colour-string colour-package-version version) "]"))
            (print
              (concat `("    " ,(colour-string 244  (cadddr x))))))))
      found-list)))

; }}}

(define (usage status)
  (exit status "usage: ~a <command> <package-name>\n" *program-name*))

(define (main args)
  (let-args (cdr args)
    ((search "S|search=s")
     (#f "h|help" (usage 0))
     . rest)
    (cond
      (search
        (search-package-by-name (caddr args)))
      (else
        (match (car rest)
          ; commands
          ("info"
           (info-print-packages (cadr rest)))
          ((or "update" "up")
           (update-ports-tree ))
          ("install"
           (install-package (cadr rest)))
          ((or "deinstall" "remove")
           (deinstall-package (cadr rest)))
          ("reinstall"
           (reinstall-package (cadr rest)))
          ("search"
           (search-package-by-name (cadr rest)))
          ("srcup"
           (update-source-tree))
          (_ (usage 1))))))
  0)

; vim: foldmethod=marker
