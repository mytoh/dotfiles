#!/usr/bin/env gosh

;; lesser copy of ls++ by trapd00r
;; colour codes are hardcoded so edit this file

(use gauche.collection)
(use gauche.parseopt)
(use file.util)

(define colour-list
      '((scm  . 72  )
        (zip  . 83  )
        (rar  . 83  )
        (txz  . 68  )
        (xz  .  68  )
        (cbz  . 111 )
        (cbr  . 192 )
        (html . 38  )
        (vim  . 162 )
        (conf . 12  )
        (d    . 1   )
        (md    . 40   )
        ))




(define (make-colour colour str)
  (string-append "[38;5;" (x->string colour) "m" str "[0m")
  )

(define (colour-filename name type . ecolour)
  (if  (not (null? ecolour))
  (let ((e  (cdar ecolour)))
  (case type
        ((regular) (if (file-is-executable? name)
                       (string-append (make-colour e name) (make-colour 7 "*"))
                       (make-colour e name)))
        ((directory) (string-append (make-colour e name) (make-colour 7 "/")))
        ((symlink) (string-append (make-colour e name) (make-colour 7 "@")))
        (else        (make-colour e name)))
  )
  (case type
        ((regular)   (if (file-is-executable? name)
                         (string-append (make-colour 7 name) (make-colour 7 "*"))
                          (make-colour 7 name )))
        ((directory) (string-append (make-colour 1 name ) (make-colour 0 "/")))
        ((character) (make-colour 2 name ))
        ((block)     (make-colour 3 name ))
        ((fifo)      (make-colour 4 name ))
        ((symlink) (string-append (make-colour 5 name) (make-colour 7 "@")))
        ((socket)    (make-colour 6 name ))
        (else        (make-colour 7 name)))
        )
  )


(define (print-filename filename)
  (let*  ((file (sys-basename filename))
            (type (file-type file :follow-link? #f))
            (extension  (path-extension file)))
           (if extension
               (let ((e (assoc (string->symbol extension) colour-list)))
                    (if  e
                        (colour-filename file type e)
                        (colour-filename file type)
                        ))
               (colour-filename file type)
               )))

(define (print-permermission f)
  (let* ((perms (format #f "~3O" (file-perm f :follow-link? #f)))
         (type (file-type f :follow-link? #f))
         (lst (string->list perms))
         (p (string-join  (quasiquote 
                            ,(map (lambda (char) 
                                    (let ((c (digit->integer char))
                                          (nchar (make-colour 0 "-"))
                                          (rchar (make-colour 5 "r"))
                                          (wchar (make-colour 2 "w"))
                                          (xchar (make-colour 7 "x"))
                                          )
                                         (case c
                                               ((0) (string-append  nchar nchar nchar))
                                               ((1) (string-append  nchar nchar xchar))
                                               ((2) (string-append  nchar wchar nchar))
                                               ((4) (string-append  rchar nchar nchar))
                                               ((5) (string-append  rchar nchar xchar))
                                               ((6) (string-append  rchar wchar nchar))
                                               ((7) (string-append  rchar wchar xchar))
                                               ))) lst))
                          "")))
        (case type 
              ((directory) (string-append (make-colour 1 "d") p))
              ((symlink) (string-append (make-colour 5 "l") p))
              (else (string-append (make-colour 0 "-") p))
              )
        )
  )

(define (print-size file)
  (let* ((filesize (file-size file))
        (size (cond
                ((> filesize 1073741824) (string-append (number->string (truncate (/ (/ (/ filesize 1024) 1024) 1024))) (make-colour 5 "G")))
                ((> filesize 1048576) (string-append (number->string (truncate (/ (/ filesize 1024) 1024))) (make-colour 4 "M")))
                ((> filesize 1024)    (string-append (number->string (truncate (/ filesize 1024))) (make-colour 2 "K")))
                ((< filesize 1024)    (string-append (number->string filesize) (make-colour 3 "B")))
                ))
        )
        (format "~19@a"
                size
                )
        )
  )

;(define (print-size file)
  ;(let ((filesize (file-size file)))
        ;(if (number? filesize)
            ;"number"
            ;filesize
            ;)
       ;)
  ;)

(define (print-delim num)
  (case num
        ((1) (make-colour 0 "├"))
        ((2) (make-colour 0 "┤"))
        ((3) (make-colour 0 "│"))
        )
  )

(define (normal-files directories)
  (let ((dotfile (lambda (f) (rxmatch->string #/.*\/(\.)[^\/]*$/ f)))
        (files (directory-list directories :children? #t :add-path? #t)))
       (remove dotfile files)
  )
  )

(define (ls-perm-size-file directories allfiles)
  (let ((ls (lambda (dir)
              (for-each
                (lambda (e) (display e) (newline))
                (map (lambda (f)
                       (format "~a~10a~a~a~a~a"
                            (print-delim 1)
                            (print-permermission f)
                            (print-delim 2)
                            (print-size f)
                            (print-delim 3)
                            (print-filename f)
                            ))
                     (if allfiles
                     (directory-list dir :children? #t :add-path? #t)
                     (normal-files dir)
                     )
                  )))
                  ))
       (if (null? directories)
           (ls (current-directory))
           (let loop ((dirs  directories))
                (if (null? dirs)
                    (read-from-string "") ;return EOF
                    (begin 
                    (ls (car dirs))
                    (loop (cdr dirs)))
                    ))
           )
       ))

(define (ls-perm-file directories allfiles)
  (let ((ls (lambda (dir)
              (for-each
                (lambda (e) (display e) (newline))
                (map (lambda (f)
                       (format "~1A~10A~a~a"
                            (print-delim 1)
                            (print-permermission f)
                            (print-delim 2)
                            (print-filename f)
                            ))
                     (if allfiles
                     (directory-list dir :children? #t :add-path? #t)
                     (normal-files dir)
                     )
                  )))
                  ))
       (if (null? directories)
           (ls (current-directory))
           (let loop ((dirs  directories))
                (if (null? dirs)
                    (read-from-string "") ;return EOF
                    (begin 
                    (ls (car dirs))
                    (loop (cdr dirs)))
                    ))
           )
       ))

(define (ls-file directories allfiles)
  (let ((ls (lambda (dir)
              (for-each
                (lambda (e) (display e) (newline))
                (map (lambda (f)
                       (format "~a " (print-filename f)))
                     (if allfiles
                     (directory-list dir :children? #t :add-path? #t)
                     (normal-files dir)
                     )
                     )))))
       (if (null? directories)
           (ls (current-directory))
           (let loop ((dirs  directories))
                (if (null? dirs)
                    (read-from-string "") ;return EOF
                    (begin 
                      (ls (car dirs))
                      (loop (cdr dirs)))
                    )))
       ))

(define (usage)
  (print "help")
  )

(define (main args)
  (let-args (cdr args)
      ((pf "pf")
       (pfs "pfs")
       (all "a|all")
      . directories)
      (cond (pf (ls-perm-file directories all))
             (pfs (ls-perm-size-file directories all))
             ((null? directories) (ls-file (list (current-directory)) all))
             (else (ls-file directories all))
             )
      ) ;let-args
  )
