#!/usr/bin/env gosh

;; lesser copy of ls++ by trapd00r

(use gauche.process)
(use gauche.parseopt)
(use file.util)

(define (make-colour colour str)
  (string-append "[38;5;" (x->string colour) "m" str "[0m")
  )

(define (print-filename filename)
  (letrec  ((file (sys-basename filename))
            (type (file-type file :follow-link? #f))
            (ext  (path-extension file)))
           (if ext
               (let ((ext (string->symbol ext)))
                    (case ext
                          ((scm)  (make-colour  72 file ))
                          ((zip)  (make-colour  83 file ))
                          ((cbz)  (make-colour  111 file ))
                          ((cbr)  (make-colour  192 file ))
                          ((html) (make-colour  38 file ))
                          ((vim)  (make-colour  162 file ))
                          ((conf) (make-colour  12 file ))
                          ((d)    (make-colour  1 file ))
                          (else (case type
                                      ((regular)   (make-colour 7 file ))
                                      ((directory) (string-append (make-colour 1 file ) (make-colour 0 "/")))
                                      ((character) (make-colour 2 file ))
                                      ((block)     (make-colour 3 file ))
                                      ((fifo)      (make-colour 4 file ))
                                      ((symlink)   (make-colour 5 file ))
                                      ((socket)    (make-colour 6 file ))
                                      (else        (make-colour 0 file))
                                      ))))
               (case type
                     ((regular)   (make-colour 0 file ))
                     ((directory) (string-append (make-colour 1 file ) (make-colour 0 "/")))
                     ((character) (make-colour 2 file ))
                     ((block)     (make-colour 3 file ))
                     ((fifo)      (make-colour 4 file ))
                     ((symlink)   (make-colour 5 file ))
                     ((socket)    (make-colour 6 file ))
                     (else        (make-colour 0 file)))
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

(define (print-delim num)
  (case num
        ((1) (make-colour 0 "├"))
        ((2) (make-colour 0 "┤"))
        ((3) (make-colour 0 "▕▏"))
        )
  )

(define (ls-perm-file directories)
  (let ((ls (lambda (dir)
              (for-each
                (lambda (e) (display e) (newline))
                (map (lambda (f)
                       (format "~1A~10A~a~a"
                            (print-delim 1)
                            (print-permermission f)
                            (print-delim 2)
                            (print-filename f)))
                  (directory-list dir :children? #t :add-path? #t))))
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

(define (ls-file dirs)
  (for-each
    display
    (map
      (lambda (f)
        (format "~a " (print-filename f))
        )
      (directory-list dirs :children? #t))
    )
  )

(define (usage)
  (print "help")
  )

(define (main args)
  (let-args (cdr args)
      ((pf "pf|l")
      . directories)
      ;(cond ((pf (ls-perm-file filenames))
      (cond ((and (null? directories) (not pf))(ls-file (current-directory)))
             (pf (ls-perm-file directories)
                 )
             (else (ls-file directories))
             )
      ) ;let-args
  )
