#!/usr/bin/env gosh

;; lesser copy of ls++ by trapd00r
;; colour codes are hardcoded so edit this file

(use gauche.collection)
(use gauche.parseopt)
(use file.util)
(use srfi-1) ;last
(use gauche.process)
(use util.list) ;take*
(use gauche.sequence)

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
    (mp3  . 6)
    (wav  . 6)
    (mid  . 6)
    (midi . 6)
    (au   . 6)
    (ogg  . 6)
    (flac . 6)
    (aac  . 6)
    (scm  . 72)
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


(define (make-colour colour str)
  (if (<= colour (count car *colours*))
      (let1 c (cdr (assoc colour *colours*))
            (string-append "[38;5;" (x->string c) "m" str "[0m"))
    (string-append "[38;5;" (x->string colour) "m" str "[0m")))

(define (colour-filename name type . ecolour)
  (if  (not (null? ecolour))
      (let1 e  (cdar ecolour)
            (case type
              ((regular) (if (file-is-executable? name)
                             (string-append (make-colour e name) (make-colour 2 "*"))
                           (make-colour e name)))
              ((directory) (string-append (make-colour e name) (make-colour 2 "/")))
              ((symlink)   (string-append (make-colour e name) (make-colour 2 "@")))
              (else        (make-colour e name))))
    (case type
      ((regular)   (if (file-is-executable? name)
                       (string-append (make-colour 4 name) (make-colour 2 "*"))
                     (make-colour 14 name )))
      ((directory) (string-append (make-colour 1 name) (make-colour 2 "/")))
      ((character) (make-colour 2 name))
      ((block)     (make-colour 3 name))
      ((fifo)      (make-colour 4 name))
      ((symlink)   (string-append (make-colour 5 name) (make-colour 2 "@")))
      ((socket)    (make-colour 6 name))
      (else        (make-colour 2 name)))))


(define (print-filename filename)
  (let*  ((file (sys-basename filename))
          (type (file-type filename :follow-link? #f))
          (realname (sys-realpath filename))
          (extension  (path-extension file)))
    (case type
      ((symlink)  (if extension
                      (if-let1 ext (assoc (string->symbol extension) *extension-colours*)
                               (string-append (colour-filename file type ext) " -> " (make-colour 4 realname))
                               (string-append (colour-filename file type) " -> " (make-colour 4 realname)))
                    (string-append (colour-filename file type) " -> " (make-colour 4 realname))))
      (else (if extension
                (if-let1 ext (assoc (string->symbol extension) *extension-colours*)
                         (colour-filename file type ext)
                         (colour-filename file type))
              (colour-filename file type))))))

(define (print-filename-col filename)
  (let*  ((file (sys-basename filename))
          (type (file-type filename :follow-link? #f))
          (extension  (path-extension file)))
    (if extension
        (if-let1 e (assoc (string->symbol extension) *extension-colours*)
                 (colour-filename file type e)
                 (colour-filename file type))
      (colour-filename file type))))

(define (print-permission f)
  (let* ((perms (format #f "~3O" (file-perm f :follow-link? #f)))
         (type (file-type f :follow-link? #f))
         (lst (map (lambda (e) (if (char-numeric? e) e #\0))(string->list perms)))
         (p (string-join  (quasiquote
                           ,(map (lambda (char)
                                   (let ((c (digit->integer char))
                                         (n (make-colour 0 "-"))
                                         (r (make-colour 6 "r"))
                                         (w (make-colour 7 "w"))
                                         (x (make-colour 5 "x"))
                                         )
                                     (case c
                                       ((0) (string-append  n n n))
                                       ((1) (string-append  n n x))
                                       ((2) (string-append  n w n))
                                       ((3) (string-append  n w x))
                                       ((4) (string-append  r n n))
                                       ((5) (string-append  r n x))
                                       ((6) (string-append  r w n))
                                       ((7) (string-append  r w x))
                                       )))
                                 lst))
                         "")))
    (case type
      ((directory) (string-append (make-colour 1 "d") p))
      ((block) (string-append (make-colour 2 "b") p))
      ((character) (string-append (make-colour 3 "c") p))
      ((symlink) (string-append (make-colour 4 "l") p))
      ((fifo) (string-append (make-colour 6 "p") p))
      ((socket) (string-append (make-colour 7 "s") p))
      (else (string-append (make-colour 0 "-") p)))))

(define (print-size file)
  (let* ((filesize (file-size file))
         (size (cond
                ((> filesize 1073741824) (string-append (make-colour 7 (number->string (truncate (/ (/ (/ filesize 1024) 1024) 1024)))) (make-colour 3 "G")))
                ((> filesize 1048576) (string-append (make-colour 7 (number->string (truncate (/ (/ filesize 1024) 1024)))) (make-colour 7 "M")))
                ((> filesize 1024)    (string-append (make-colour 7 (number->string (truncate (/ filesize 1024)))) (make-colour 2 "K")))
                ((< filesize 1024)    (string-append (make-colour 7 (number->string filesize)) (make-colour 14 "B"))))))
    (format "~35@a"
            size)))


(define (print-delim num)
  (case num
    ((1) (make-colour 0 "├"))
    ((2) (make-colour 0 "┤"))
    ((3) (make-colour 0 "│"))))

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
                        (format "~a~10a~a~a~a~a"
                                (print-delim 1)
                                ;(print (file-perm f :follow-link? #f))
                                (print-permission f)
                                (print-delim 2)
                                (print-size f)
                                (print-delim 3)
                                (print-filename f)))
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
                      (format "~1a~10a~a~a"
                              (print-delim 1)
                              (print-permission f)
                              (print-delim 2)
                              (print-filename f)
                              ))
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
                    (format "~a" (print-filename-col f)))
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
                  (lambda (e)
                    (display (format "~a\t"  (print-filename-col e))))
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
