#!/usr/bin/env gosh

;; lesser copy of ls++ by trapd00r
;; colour codes are hardcoded so edit this file

(use gauche.parseopt)
(use file.util)
(use gauche.process) ;process-output->string
(use util.list) ;take*
(use gauche.sequence) ;remove
(require-extension (srfi 1)) ;count

(define-constant *extension-colours*
  '((cmd  . 2)
    (exe  . 2)
    (com  . 2)
    (btm  . 2)
    (bat  . 2)
    (sh   . 2)
    (csh  . 2)

    (tar  . 1)
    (tgz  . 1)
    (arj  . 1)
    (taz  . 1)
    (lzh  . 1)
    (zip  . 43)
    (rar  . 83)
    (txz  . 68)
    (xz   . 68)
    (cbz  . 111)
    (cbr  . 192)
    (z    . 1)
    (Z    . 1)
    (gz   . 1)
    (bz2  . 1)
    (bz   . 1)
    (tbz2 . 1)
    (tz   . 1)
    (deb  . 1)
    (rpm  . 1)
    (ace  . 1)
    (zoo  . 1)
    (cpio . 1)
    (7z   . 1)
    (rz   . 1)

    (jpg  . 5)
    (jpeg . 5)
    (gif  . 5)
    (bmp  . 5)
    (ppm  . 5)
    (tga  . 5)
    (xbm  . 5)
    (xpm  . 5)
    (tif  . 5)
    (tiff . 5)
    (png  . 5)
    (mng  . 5)
    (xcf  . 5)
    (pcx  . 5)

    (mpg  . 5)
    (mpeg . 5)
    (m2v  . 5)
    (avi  . 5)
    (mkv  . 5)
    (flv  . 5)
    (ts  . 5)
    (ogm  . 5)
    (mp4  . 5)
    (m4v  . 5)
    (mp4v . 5)
    (mov  . 5)
    (qt   . 5)
    (wmv  . 5)
    (asf  . 5)
    (rm   . 5)
    (rmvb . 5)

    (mp3  . 6)
    (wav  . 6)
    (mid  . 6)
    (midi . 6)
    (au   . 6)
    (ogg  . 6)
    (flac . 6)
    (aac  . 6)

    (flc  . 5)
    (fli  . 5)
    (gl   . 5)
    (dl   . 5)
    (pdf  . 2)
    (ps   . 2)
    (txt  . 2)
    (patch . 2)
    (diff . 2)
    (log  . 2)
    (tex  . 2)
    (doc  . 2)

    ; scheme
    (scm  . 72)
    (sch  . 72)
    (ss   . 72)
    (sls  . 72)
    (sps  . 72)
    (rkt  . 72)

    
    (pl  . 72)
    (html . 38)
    (xml . 38)
    (vim  . 162)
    (conf . 12)
    (d    . 1)
    (md   . 40)
    (db   . 30)
    (swap   . 39)
    ))

(define-constant *colours*
  '((0  . 237)
    (1  . 131)
    (2  . 107)
    (3  . 75 )
    (4  . 240)
    (5  . 209)
    (6  . 185)
    (7  . 216)
    (8  . 220)
    (9  . 208)
    (10 . 243)
    (11 . 161)
    (12 . 240)
    (13 . 025)
    (14 . 248)
    (15 . 196)
    ))



(define (ls-make-colour colour str)
  (if (<= colour (count car *colours*))
    (let1 c  (assoc-ref *colours* colour)
          ((lambda (colour s)
             (string-append "[38;5;" (x->string colour) "m"  (x->string s) "[0m"))
                   c str))
          ((lambda (colour s)
             (string-append "[38;5;" (x->string colour) "m"  (x->string s) "[0m"))
                   colour str)))

(define (colour-filename name type . ecolour)
  (if  (not (null? ecolour))
      (let1 e  (cdar ecolour)
            (case type
              ((regular) (if (file-is-executable? name)
                             #`",(ls-make-colour e name),(ls-make-colour 2 \"*\")"
                           (ls-make-colour e name)))
              ((directory) #`",(ls-make-colour e name),(ls-make-colour 2 \"/\")")
              ((symlink)   #`",(ls-make-colour e name),(ls-make-colour 2 \"@\")")
              (else        (ls-make-colour e name))))
    (case type
      ((regular)   (if (file-is-executable? name)
                       #`",(ls-make-colour 4 name),(ls-make-colour 2 \"*\")"
                     (ls-make-colour 14 name )))
      ((directory) #`",(ls-make-colour 1 name),(ls-make-colour 2 \"/\")")
      ((character) (ls-make-colour 2 name))
      ((block)     (ls-make-colour 3 name))
      ((fifo)      (ls-make-colour 4 name))
      ((symlink)   #`",(ls-make-colour 5 name),(ls-make-colour 2 \"@\")")
      ((socket)    (ls-make-colour 6 name))
      (else        (ls-make-colour 2 name)))))


(define (print-filename filename stat)
  (let*  ((file (sys-basename filename))
          (type (~ stat 'type))
          (realname (sys-realpath filename))
          (extension  (path-extension file)))
    (case type
      ((symlink)  (if extension
                      (if-let1 ext (assoc (string->symbol extension) *extension-colours*)
                               #`",(colour-filename file type ext) -> ,(ls-make-colour 10 realname)"
                               #`",(colour-filename file type) -> ,(ls-make-colour 10 realname)")
                               #`",(colour-filename file type) -> ,(ls-make-colour 10 realname)"))
      (else (if extension
                (if-let1 ext (assoc (string->symbol extension) *extension-colours*)
                         (colour-filename file type ext)
                         (colour-filename file type))
              (colour-filename file type))))))

(define (print-filename-col filename stat)
  (let*  ((file (sys-basename filename))
          (type (ref stat 'type))
          (extension  (path-extension file)))
    (if extension
        (if-let1 e (assoc (string->symbol extension) *extension-colours*)
                 (colour-filename file type e)
                 (colour-filename file type))
      (colour-filename file type))))

(define (print-permission f stat)
  (let* ((perm (format #f "~3O" (ref stat 'perm)))
         (type (ref stat 'type))
         (lst (map (lambda (e) (if (char-numeric? e) e #\0)) (string->list perm)))
         (p (string-join  (quasiquote
                           ,(map (lambda (char)
                                   (let ((c (digit->integer char))
                                         (n (ls-make-colour 0 "-"))
                                         (r (ls-make-colour 6 "r"))
                                         (w (ls-make-colour 7 "w"))
                                         (x (ls-make-colour 5 "x"))
                                         )
                                     (case c
                                       ((0) #`",n,n,n")
                                       ((1) #`",n,n,x")
                                       ((2) #`",n,w,n")
                                       ((3) #`",n,w,x")
                                       ((4) #`",r,n,n")
                                       ((5) #`",r,n,x")
                                       ((6) #`",r,w,n")
                                       ((7) #`",r,w,x")
                                       )))
                                 lst))
                         "")))
    (case type
      ((directory) #`",(ls-make-colour 1 \"d\"),p")
      ((block)     #`",(ls-make-colour 2 \"b\"),p")
      ((character) #`",(ls-make-colour 3 \"c\"),p")
      ((symlink)   #`",(ls-make-colour 4 \"l\"),p")
      ((fifo)      #`",(ls-make-colour 6 \"p\"),p")
      ((socket)    #`",(ls-make-colour 7 \"s\"),p")
      (else        #`",(ls-make-colour 0 \"-\"),p"))))

(define (print-size file stat)
  (let* ((filesize (ref stat 'size))
         (size (cond
                ((> filesize 1073741824) #`",(ls-make-colour 7 (truncate (/ (/ (/ filesize 1024) 1024) 1024))),(ls-make-colour 3 \"G\")")
                ((> filesize 1048576) #`",(ls-make-colour 7  (truncate (/ (/ filesize 1024) 1024))),(ls-make-colour 7 \"M\")")
                ((> filesize 1024)    #`",(ls-make-colour 7  (truncate (/ filesize 1024))),(ls-make-colour 2 \"K\")")
                ((< filesize 1024)    #`",(ls-make-colour 7  filesize),(ls-make-colour 14 \"B\")"))))
    (format "~35@a"
            size)))


(define (print-delim num)
  (case num
    ((1) (ls-make-colour 0 "├"))
    ((2) (ls-make-colour 0 "┤"))
    ((3) (ls-make-colour 0 "│"))))

(define (normal-files directory)
  (let ((dotfile (lambda (f) (rxmatch->string #/.*\/(\.)[^\/]*$/ f)))
        (files (directory-list directory :children? #t :add-path? #t)))
    (remove dotfile files)))

(define (ls-perm-size-file directories allfiles dfirst)
  (let ((ls (lambda (dir)
              (let ((fullpath-list (cond ((and allfiles dfirst)
                                          (directory-first  (directory-list dir :children? #t :add-path? #t)))
                                         (allfiles (directory-list dir :children? #t :add-path? #t))
                                         (dfirst   (directory-first (normal-files dir)))
                                         (else (normal-files dir)))))
                (for-each
                 (lambda (e) (display e) (newline))
                 (map (lambda (f)
                        (let1 stat (sys-lstat f)
                        (format "~a~10a~a~a~a~a"
                                (print-delim 1)
                                (print-permission f stat)
                                (print-delim 2)
                                (print-size f stat)
                                (print-delim 3)
                                (print-filename f stat))))
                      fullpath-list))))))
    (if (null? directories)
        (ls (current-directory))
      (let loop ((dirs  directories))
        (if (null? dirs)
            (read-from-string "") ;return EOF
          (begin
           (ls  (car dirs))
           (loop (cdr dirs))))))))

(define (ls-perm-file directories allfiles)
  (let ((ls (lambda (dir)
              (for-each
               (lambda (e) (display e) (newline))
               (map (lambda (f)
                      (let1 stat (sys-lstat f)
                      (format "~1a~10a~a~a"
                              (print-delim 1)
                              (print-permission f stat)
                              (print-delim 2)
                              (print-filename f stat))))
                    (if allfiles
                        (directory-list dir :children? #t :add-path? #t)
                      (normal-files dir)))))))
    (if (null? directories)
        (ls (current-directory))
      (let loop ((dirs  directories))
        (if (null? dirs)
            (read-from-string "") ;return EOF
          (begin
           (ls (car dirs))
           (loop (cdr dirs))))))))

(define (ls-file directories allfiles dfirst)
  (if (null? directories)
      (printcol (current-directory) allfiles dfirst)
    (let loop ((dirs  directories))
      (if (null? dirs)
          (read-from-string "") ;return EOF
        (begin
         (printcol (car dirs) allfiles dfirst)
         (loop (cdr dirs)))))))

(define (directory-first dirlist)
  (receive (dirs files)
           (partition
            file-is-directory?
            dirlist)
           (append dirs files)))

(define (printcol directory allfiles dfirst)
  (let ((currentlist (directory-list directory :children? #t :add-path? #t)))
    (if (null? currentlist)
        #t
      (let* ((tabwidth 2)
             (termwidth (string->number (process-output->string '(tput cols))))
             (maxwidth (if allfiles
                           (logand (+ (apply max (map string-length (map sys-basename currentlist)))
                                      tabwidth) (lognot (- tabwidth 1)))
                         (logand (+ (apply max (map string-length (map sys-basename (normal-files directory))))
                                    tabwidth) (lognot (- tabwidth 1)))))
             (num (if allfiles
                      (length currentlist)
                    (length (normal-files directory))))
             (fullpath-list (cond ((and allfiles dfirst)
                                   (directory-first  currentlist))
                                  (allfiles currentlist)
                                  (dfirst   (directory-first (normal-files directory)))
                                  (else (normal-files directory)))))
        (if (< termwidth (* 2 maxwidth))
            (for-each
             (lambda (e) (display e) (newline))
             (map (lambda (f)
                    (let1 stat (sys-stat f)
                    (format "~a" (print-filename-col f stat))))
                  fullpath-list))
          (let*  ((numcols  (round->exact (/. termwidth maxwidth)))
                  (numrows  (round->exact (/. num numcols)))
                  (numrows-new (if  (< 0 (modulo num numcols))
                                   (+  numrows 1)
                                 numrows))
                  (lst fullpath-list)
                  (col (round->exact (/. termwidth numcols))))
            (let loop ((l (filter string? (take* lst numcols #t)))
                       (lst (filter string? (drop* lst numcols))))
              (if (null? l)
                  #t
                (begin
                 (for-each
                  (lambda (f)
                    (let1 stat (sys-stat f)
                    (display (format "~a\t"  (print-filename-col f stat)))))
                  l)
                 (newline)
                 (loop (take* lst numcols ) (drop* lst numcols)))))))))))

(define (usage)
  (print "help"))


(define (main args)
  (let-args (cdr args)
            ((pf "pf")
             (psf "psf")
             (all "a|all")
             (dfirst "d|directory-first")
             . directories)
            (cond (pf (ls-perm-file directories all))
                  (psf (ls-perm-size-file directories all dfirst))
                  (dfirst (ls-file directories all dfirst))
                  (else (ls-file directories all dfirst)))))
