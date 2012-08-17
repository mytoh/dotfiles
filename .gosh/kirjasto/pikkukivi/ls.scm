#!/usr/bin/env gosh

;; lesser copy of ls++ by trapd00r
;; colour codes are hardcoded so edit this file

(define-module pikkukivi.ls
  (export
    ls
    )
  (use gauche.parseopt)
  (use gauche.process)
  (use gauche.sequence) ;remove
  (use gauche.charconv)
  (use util.match)
  (use util.list) ;take*
  (use file.util)
  (require-extension (srfi 1 13)) ;count
  )
(select-module pikkukivi.ls)

(define *extension-colours*
  (hash-table
    'eq?
    '(cmd  . 2)
    '(exe  . 2)
    '(com  . 2)
    '(btm  . 2)
    '(bat  . 2)

    ; archives
    '(tar  . 1)
    '(tgz  . 1)
    '(arj  . 1)
    '(taz  . 1)
    '(lzh  . 1)
    '(zip  . 43)
    '(rar  . 83)
    '(txz  . 68)
    '(xz   . 68)
    '(cbz  . 111)
    '(cbr  . 192)
    '(z    . 1)
    '(Z    . 1)
    '(gz   . 1)
    '(bz2  . 1)
    '(bz   . 1)
    '(tbz  . 1)
    '(tbz2 . 1)
    '(tz   . 1)
    '(deb  . 1)
    '(rpm  . 1)
    '(ace  . 1)
    '(zoo  . 1)
    '(cpio . 1)
    '(7z   . 1)
    '(rz   . 1)
    '(dmg   . 1)

    ; images
    '(jpg  . 5)
    '(jpeg . 5)
    '(gif  . 5)
    '(bmp  . 5)
    '(ppm  . 5)
    '(tga  . 5)
    '(xbm  . 5)
    '(xpm  . 5)
    '(tif  . 5)
    '(tiff . 5)
    '(png  . 5)
    '(mng  . 5)
    '(xcf  . 5)
    '(pcx  . 5)
    '(ico  . 5)
    '(svg  . 5)

    ; video
    '(mpg  . 5)
    '(mpeg . 5)
    '(m2v  . 5)
    '(avi  . 5)
    '(mkv  . 5)
    '(flv  . 5)
    '(ts  . 5)
    '(ogm  . 5)
    '(mp4  . 5)
    '(m4v  . 5)
    '(mp4v . 5)
    '(mov  . 5)
    '(qt   . 5)
    '(wmv  . 5)
    '(asf  . 5)
    '(rm   . 5)
    '(rmvb . 5)

    ; audio
    '(mp3  . 6)
    '(wav  . 6)
    '(mid  . 6)
    '(midi . 6)
    '(au   . 6)
    '(ogg  . 6)
    '(flac . 6)
    '(aac  . 6)

    '(flc  . 5)
    '(fli  . 5)
    '(gl   . 5)
    '(dl   . 5)
    '(pdf  . 2)
    '(ps   . 2)
    '(ini  . 2)
    '(patch . 2)
    '(diff . 2)
    '(log  . 2)
    '(tex  . 2)
    '(doc  . 2)

    '; scheme
    '(scm  . 72)
    '(sch  . 72)
    '(ss   . 72)
    '(sls  . 72)
    '(sps  . 72)
    '(rkt  . 72)
    ; list
    '(el  . 162)
    '(lisp  . 162)
    '(cl  . 162)

    ; langs
    '(pl  . 72)
    '(py  . 88)
    '(pyc  . 38)
    '(html . 38)
    '(mht . 38)
    '(xml . 38)
    '(vim  . 70)
    '(c  . 123)
    '(stub . 123)
    '(h  . 123)
    '(hs  . 23)
    '(java  . 93)
    '(jnlp  . 93)

    ;; text
    '(md   . 40)
    '(mkd   . 40)
    '(markdown   . 40)
    '(rst   . 49)
    '(rest   . 49)
    '(txt  . 2)
    '(text  . 2)

    ;; font
    '(ttf . 71)
    '(ttc . 71)
    '(otf . 71)
    '(bdf . 71)

    ;; shell
    '(sh   . 2)
    '(csh  . 2)
    '(zsh  . 2)
    '(bash  . 2)
    '(fish  . 2)
    '(ksh  . 2)
    '(mksh  . 2)


    '(conf . 12)
    '(rc   . 109)
    '(man . 32)
    '(core . 22)
    '(d    . 1)
    '(pro  . 3)
    '(db   . 30)
    '(swap   . 39)
    '(in   . 139)
    '(mk   . 103)
    '(mak   . 103)
    '(bin  . 99)
    '(nds   . 103)
    '(gba   . 103)
    '(GBA   . 103)
    '(air  . 49)
    '(m4 . 23)
    '(ac . 24)
    '(spec . 28)
    '(guess . 42)
    '(gpd . 22)
    '(sub . 72)
    ))


(define *normal-file-colours*
  '(
    ("README$" 33)
    ("readme$" 33)
    ("LICENSE$" 33)
    ("NEWS$" 33)
    ("HACKING$" 33)
    ("Changelog$" 33)
    ("AUTHORS$" 33)
    ("COPYING$" 33)
    ("DIST$" 33)
    ("VERSION$" 33)
    ("INSTALL$" 33)

    ("Makefile" 103)

    ("Rakefile" 133)
    ("Gemfile" 133)
    ))


; ;;colorscheme trapd00r
(define *colours*
  (vector
    237
    131
    107
    75
    240
    209
    185
    216
    220
    208
    243
    161
    240
    025
    248
    196
    ))
;;colorscheme early
; (define *colours*
;   (vector
;     233
;     245
;     250
;     201
;     239
;     209
;     185
;     216
;     244
;     254
;     243
;     241
;     240
;     239
;     237
;     220
;     ))

;;colorscheme normal
; (define *colours*
;   (vector
;     208
;     197
;     190
;     196
;     242
;     209
;     185
;     215
;     032
;     061
;     142
;     197
;     106
;     060
;     236
;     215
;     ))
; 
;;colorscheme greyscale
; (define *colours*
;   (vector
;     252
;     251
;     250
;     249
;     239
;     244
;     240
;     242
;     244
;     244
;     243
;     241
;     240
;     239
;     236
;     242
;     ))
; 







(define (convert-jp-filename name)
  (ces-convert name (ces-guess-from-string name "*jp")))

(define (list-files directory)
  (map convert-jp-filename
       (directory-list directory :children? #t :add-path? #t)))

(define (ls-make-colour colour str)
  (cond
    ((<= colour (vector-length *colours*))
     (let1 c  (ref *colours* colour #f)
       ((lambda (colour s)
          (string-append "[38;5;" (number->string colour) "m"  (x->string s) "[0m"))
        c str)))
    (else
      ((lambda (colour s)
         (string-append "[38;5;" (number->string colour) "m"  (x->string s) "[0m"))
       colour str))))

(define (colour-filename name type . ecolour)
  (cond
    ((not (null? ecolour))
     (let1 e   (car  ecolour)
       (match type
         ('regular
          (if (file-is-executable? name)
                      (string-concatenate  `(,(ls-make-colour e name) ,(ls-make-colour 2 "*")))
                      (ls-make-colour e name)))
         ('directory
          (string-append (ls-make-colour e name) (ls-make-colour 12 "/")))
         ('symlink
          (string-append (ls-make-colour e name) (ls-make-colour 2 "@")))
         (_        (ls-make-colour e name)))))
    (else
      (match type
        ('regular
         (if (file-is-executable? name)
                       #`",(ls-make-colour 4 name),(ls-make-colour 2 \"*\")"
                       (colour-normal-file name)
                       ; (ls-make-colour 14 name)
                       ))
        ('directory
         #`",(ls-make-colour 1 name),(ls-make-colour 12 \"/\")")
        ('character
         (ls-make-colour 2 name))
        ('block
         (ls-make-colour 3 name))
        ('fifo
         (ls-make-colour 4 name))
        ('symlink
         #`",(ls-make-colour 5 name),(ls-make-colour 2 \"@\")")
        ('socket
         (ls-make-colour 6 name))
        (_        (ls-make-colour 2 name))))))

(define (colour-normal-file name)
  (let ((colour (filter
                  (lambda (r) ((string->regexp (car r)) name))
                  *normal-file-colours*) ))
    (cond
      ((null? colour)  
      (ls-make-colour 14 name ))
      (else
    (ls-make-colour (cadar colour) name))  
      )))


;; componets for display {{{

(define (print-filename filename stat)
  (let*  ((file (sys-basename filename))
          (type (~ stat 'type))
          (realname (sys-realpath filename))
          (extension  (path-extension file)))
    (case type
      ((symlink)  (cond
                    (extension
                      (if-let1 ext (ref *extension-colours* (string->symbol extension) #f)
                        (string-concatenate `(,(colour-filename file type ext) " -> " ,(ls-make-colour 10 realname)))
                        (string-concatenate `(,(colour-filename file type) " -> " ,(ls-make-colour 10 realname)))))
                    (else
                      (string-concatenate `(,(colour-filename file type) " -> " ,(ls-make-colour 10 realname))))))
      (else (cond
              (extension
                (if-let1 ext (ref  *extension-colours* (string->symbol extension) #f)
                  (colour-filename file type ext)
                  (colour-filename file type)))
              (else
                (colour-filename file type)))))))


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
                                          (x (ls-make-colour 5 "x")))
                                      (match c
                                        (0 #`",n,n,n")
                                        (1 #`",n,n,x")
                                        (2 #`",n,w,n")
                                        (3 #`",n,w,x")
                                        (4 #`",r,n,n")
                                        (5 #`",r,n,x")
                                        (6 #`",r,w,n")
                                        (7 #`",r,w,x"))))
                                  lst))
                          "")))
    (match type
      ('directory (string-append (ls-make-colour 1 "d") p))
      ('block     (string-append (ls-make-colour 2 "b") p))
      ('character (string-append (ls-make-colour 3 "c") p))
      ('symlink   (string-append (ls-make-colour 4 "l") p))
      ('fifo      (string-append (ls-make-colour 6 "p") p))
      ('socket    (string-append (ls-make-colour 7 "s") p))
      (_          (string-append (ls-make-colour 0 "-") p)))))

(define (print-size file stat)
  (let* ((filesize (ref stat 'size))
         (size (cond
                 ((> filesize 1073741824)
                  (string-append (ls-make-colour 7 (number->string (truncate (/ (/ (/ filesize 1024) 1024) 1024)))) (ls-make-colour 3 "G")))
                 ((> filesize 1048576)
                  (string-append (ls-make-colour 7  (number->string (truncate (/ (/ filesize 1024) 1024)))) (ls-make-colour 7 "M")))
                 ((> filesize 1024)
                  (string-append (ls-make-colour 7  (number->string  (truncate (/ filesize 1024)))) (ls-make-colour 2 "K")))
                 ((< filesize 1024)
                  (string-append (ls-make-colour 7  (number->string filesize)) (ls-make-colour 14 "B")))
                 (else
                  (string-append (ls-make-colour 7  (number->string filesize)) (ls-make-colour 14 "B")))
                 )))
    (format "~35@a"
            size)))


(define-constant *delimiters*
    (vector
    (ls-make-colour 0 "├")  
    (ls-make-colour 0 "┤")  
    (ls-make-colour 0 "│")) 
  )
(define (print-delimiter num)
  (vector-ref *delimiters* (- num 1)))

(define (print-owner file stat)
  (let* ((user (if-let1 u (sys-uid->user-name (ref stat 'uid)) u (ref stat 'uid)))
        (group (sys-gid->group-name (ref stat 'gid))))
  (format "~a:~a"
          (ls-make-colour 2 user)
          (ls-make-colour 6 group))))

(define (print-time-format unit colour time)
  (match unit
    ('sec (format "~17@a ~a" (ls-make-colour colour time) (ls-make-colour colour "sec ")))
    ('min (format "~17@a ~a" (ls-make-colour colour (round->exact (/. time 60))) (ls-make-colour colour "min ")))
    ('hour (format "~17@a ~a" (ls-make-colour colour (round->exact (/. (round->exact (/. time 60)) 60))) (ls-make-colour colour "hour")))
    ('day (format "~17@a ~a" (ls-make-colour colour (round->exact (/. (/. (/. time 60) 60) 24))) (ls-make-colour colour "day ")))
    ('month (format "~17@a ~a" (ls-make-colour colour (round->exact (/. (/. (/. (/. time 60) 60) 24) 30))) (ls-make-colour colour "mon ")))
    ('year (format "~17@a ~a" (ls-make-colour colour (round->exact (/. (/. (/. (/. (/. time 60) 60) 24) 30) 12))) (ls-make-colour colour "year")))
    ))

(define (print-time file stat)
  (let* ((curtime (sys-time))
        (file-time (file-ctime file))
        (delta (- curtime file-time) ))
    (cond
      ;; sec
      ((< delta 10)
       (print-time-format 'sec 3 delta ))
      ((< delta 60)
       (print-time-format 'sec 3 delta ))
      ;; min
      ((< delta  (* 2 60))
       (print-time-format 'min 15 delta))
      ((< delta (* 45 60))
       (print-time-format 'min 15 delta))
      ;; hour
      ((< delta  (* 90 60))
       (print-time-format 'hour 9 delta))
      ((< delta (* 24 60 60))
       (print-time-format 'hour 9 delta))
      ((< delta (* 30 60 60))
       (print-time-format 'hour 9 delta))
      ((< delta (* 36 60 60))
       (print-time-format 'hour 9 delta))
      ;; day
      ((< delta  (* 48 60 60))
       (print-time-format 'day 4 delta))
      ((< delta (* 7 24 60 60))
       (print-time-format 'day 4 delta))
      ((< delta (* 14 24 60 60))
       (print-time-format 'day 4 delta))
      ((< delta (* 28 24 60 60))
       (print-time-format 'day 4 delta))
      ((< delta (* 30 24 60 60))
       (print-time-format 'day 4 delta))
      ;; month
      ((< delta (* 2 30 24 60 60))
       (print-time-format 'month 14 delta))
      ((< delta (* 12 30 24 60 60))
       (print-time-format 'month 14 delta))
      ;; year
      (else
       (print-time-format 'year 0 delta)))))

; }}}

(define (normal-files directory)
  (let ((dotfile (lambda (f) (rxmatch->string #/.*\/(\.)[^\/]*$/ f)))
        (files (list-files directory)))
    (remove dotfile files)))

(define (directory-first dirlist)
  (receive (dirs files)
    (partition
      file-is-directory?
      dirlist)
    (append dirs files)))



(define-syntax define-ls-proc
  (syntax-rules ()
    ((_ name ls directories allfiles dfirst)
     (define (name directories allfiles dfirst)
       (cond
         ((null? directories)
          (ls (current-directory) allfiles dfirst))
         (else
           (let loop ((dirs directories))
             (cond
               ((null? dirs)
                (values))
               (else
                 (ls (car dirs) allfiles dfirst)
                 (loop (cdr dirs)))))))))))


;; list files with permission, size, filename
(define ls-perm-size-file-proc
  (lambda (dir allfiles dfirst)
    (let ((fullpath-list (cond
                           ((and allfiles dfirst)
                            (directory-first  (list-files dir)))
                           (allfiles (list-files dir))
                           (dfirst   (directory-first (normal-files dir)))
                           (else (normal-files dir)))))
      (for-each
        (lambda (e) (display e) (newline))
        (map (lambda (f)
               (let1 stat (sys-lstat f)
                 (format "~a~10a~a~a~a~a"
                         (print-delimiter 1)
                         (print-permission f stat)
                         (print-delimiter 2)
                         (print-size f stat)
                         (print-delimiter 3)
                         (print-filename f stat))))
             fullpath-list)))))
(define-ls-proc ls-perm-size-file
                  ls-perm-size-file-proc
                  directories allfiles dfirst)

;; list files with permission, filename
(define ls-perm-file-proc
  (lambda (dir allfiles dfirst)
    (for-each
      (lambda (e) (display e) (newline))
      (map (lambda (f)
             (let1 stat (sys-lstat f)
               (format "~1a~10a~a~a"
                       (print-delimiter 1)
                       (print-permission f stat)
                       (print-delimiter 2)
                       (print-filename f stat))))
           (if allfiles
             (list-files dir)
             (normal-files dir))))))
(define-ls-proc ls-perm-file
                  ls-perm-file-proc
                  directories allfiles dfirst)

;; list files with permission, size, filename
(define ls-perm-owner-file-proc
  (lambda (dir allfiles dfirst)
    (for-each
      (lambda (e) (display e) (newline))
      (map (lambda (f)
             (let1 stat (sys-lstat f)
               (format "~1a~10a~a~a~a~a"
                       (print-delimiter 1)
                       (print-permission f stat)
                       (print-delimiter 2)
                       (print-owner f stat)
                       (print-delimiter 3)
                       (print-filename f stat))))
           (if allfiles
             (list-files dir)
             (normal-files dir))))))
(define-ls-proc ls-perm-owner-file
                  ls-perm-owner-file-proc
                  directories allfiles dfirst)

;; list files with permission, owner, size, filename
(define ls-perm-owner-size-file-proc
  (lambda (dir allfiles dfirst)
    (let ((fullpath-list (cond
                           ((and allfiles dfirst)
                            (directory-first  (list-files dir)))
                           (allfiles (list-files dir))
                           (dfirst   (directory-first (normal-files dir)))
                           (else (normal-files dir)))))
      (for-each
        (lambda (e) (display e) (newline))
        (map (lambda (f)
               (let1 stat (sys-lstat f)
                 (format "~a~10a~a~a~a~a~a~a"
                         (print-delimiter 1)
                         (print-permission f stat)
                         (print-delimiter 2)
                         (print-owner f stat)
                         (print-delimiter 3)
                         (print-size f stat)
                         (print-delimiter 3)
                         (print-filename f stat))))
             fullpath-list)))))
(define-ls-proc ls-perm-owner-size-file
                  ls-perm-owner-size-file-proc
                  directories allfiles dfirst)

;; list files with permission, filename
(define ls-perm-time-file-proc
  (lambda (dir allfiles dfirst)
    (for-each
      (lambda (e) (display e) (newline))
      (map (lambda (f)
             (let1 stat (sys-lstat f)
               (format "~1a~10a~a~a~a~a"
                       (print-delimiter 1)
                       (print-permission f stat)
                       (print-delimiter 2)
                       (print-time f stat)
                       (print-delimiter 3)
                       (print-filename f stat))))
           (if allfiles
             (list-files dir)
             (normal-files dir))))))
(define-ls-proc ls-perm-time-file
                  ls-perm-time-file-proc
                  directories allfiles dfirst)

;; list files with permission, time, size, filename
(define ls-perm-time-size-file-proc
  (lambda (dir allfiles dfirst)
    (let ((fullpath-list (cond
                           ((and allfiles dfirst)
                            (directory-first  (list-files dir)))
                           (allfiles (list-files dir))
                           (dfirst   (directory-first (normal-files dir)))
                           (else (normal-files dir)))))
      (for-each
        (lambda (e) (display e) (newline))
        (map (lambda (f)
               (let1 stat (sys-lstat f)
                 (format "~a~10a~a~a~a~a~a~a"
                         (print-delimiter 1)
                         (print-permission f stat)
                         (print-delimiter 2)
                         (print-time f stat)
                         (print-delimiter 3)
                         (print-size f stat)
                         (print-delimiter 3)
                         (print-filename f stat))))
             fullpath-list)))))
(define-ls-proc ls-perm-time-size-file
                  ls-perm-time-size-file-proc
                  directories allfiles dfirst)

(define  ls-perm-owner-time-size-file-proc
  (lambda (dir allfiles dfirst)
    (let ((fullpath-list (cond
                           ((and allfiles dfirst)
                            (directory-first  (list-files dir)))
                           (allfiles (list-files dir))
                           (dfirst   (directory-first (normal-files dir)))
                           (else (normal-files dir)))))
      (for-each
        (lambda (e) (display e) (newline))
        (map (lambda (f)
               (let1 stat (sys-lstat f)
                 (format "~a~10a~a~a~a~a~a~a~a~a"
                         (print-delimiter 1)
                         (print-permission f stat)
                         (print-delimiter 2)
                         (print-owner f stat)
                         (print-delimiter 3)
                         (print-time f stat)
                         (print-delimiter 3)
                         (print-size f stat)
                         (print-delimiter 3)
                         (print-filename f stat))))
             fullpath-list)))))
(define-ls-proc ls-perm-owner-time-size-file
                  ls-perm-owner-time-size-file-proc
                  directories allfiles dfirst)

;
(define (ls-file directories allfiles dfirst)
  (cond
    ((null? directories)
     (printcol (current-directory) allfiles dfirst))
    (else
      (let loop ((dirs  directories))
        (cond
          ((null? dirs)
           (read-from-string "")) ;return EOF
          (else
            (printcol (car dirs) allfiles dfirst)
            (loop (cdr dirs))))))))

(define (print-filename-col filename stat)
  (let*  ((file (sys-basename filename))
          (type (ref stat 'type))
          (extension  (path-extension file)))
    (cond
      (extension
        (if-let1 e (ref  *extension-colours* (string->symbol extension) #f)
          (colour-filename file type e)
          (colour-filename file type)))
      (else
        (colour-filename file type)))))

(define (printcol directory allfiles dfirst)
  (let ((currentlist (list-files directory)))
    (cond
      ((null? currentlist)
       #t)
      (else
        (let* ((tabwidth 2)
               (termwidth (string->number (process-output->string '(tput cols))))
               (maxwidth (cond
                           (allfiles
                             (logand (+ (apply max (map string-length (map sys-basename currentlist)))
                                        tabwidth) (lognot (- tabwidth 1))))
                           (else
                             (logand (+ (apply max (map string-length (map sys-basename (normal-files directory))))
                                        tabwidth) (lognot (- tabwidth 1))))))
               (num (cond
                      (allfiles
                        (length currentlist))
                      (else
                        (length (normal-files directory)))))
               (fullpath-list (cond ((and allfiles dfirst)
                                     (directory-first  currentlist))
                                (allfiles currentlist)
                                (dfirst   (directory-first (normal-files directory)))
                                (else (normal-files directory)))))
          (cond
            ((< termwidth (* 2 maxwidth))
             (for-each
               (lambda (e) (display e) (newline))
               (map (lambda (f)
                      (let1 stat (sys-stat f)
                        (format "~a" (print-filename-col f stat))))
                    fullpath-list)))
            (else
              (let*  ((numcols  (round->exact (/. termwidth maxwidth)))
                      (numrows  (round->exact (/. num numcols)))
                      (numrows-new (if  (< 0 (modulo num numcols))
                                     (+  numrows 1)
                                     numrows))
                      (lst fullpath-list)
                      (col (round->exact (/. termwidth numcols))))
                (let loop ((l (filter string? (take* lst numcols #t)))
                           (lst (filter string? (drop* lst numcols))))
                  (cond
                    ((null? l)
                     #t)
                    (else
                      (for-each
                        (lambda (f)
                          (let1 stat (sys-stat f)
                            (display (format "~a\t"  (print-filename-col f stat)))))
                        l)
                      (newline)
                      (loop (take* lst numcols ) (drop* lst numcols)))))))))))))

(define (usage)
  (print "help"))

(define (ls args)
  (let-args args
    ((pf "pf|perm-file")
     (ptf "ptf|perm-time-file")
     (ptsf "ptsf|perm-time-size-file")
     (pof "pof|perm-owner-file")
     (psf "psf|perm-size-file")
     (posf "posf|perm-owner-size-file")
     (potsf "potsf|perm-owner-time-size-file")
     (all "a|all")
     (dfirst "d|directory-first")
     . directories)
    (cond
      (pf (ls-perm-file directories all dfirst))
      (ptf (ls-perm-time-file directories all dfirst))
      (ptsf (ls-perm-time-size-file directories all dfirst))
      (pof (ls-perm-owner-file directories all dfirst))
      (posf (ls-perm-owner-size-file directories all dfirst))
      (potsf (ls-perm-owner-time-size-file directories all dfirst))
      (psf (ls-perm-size-file directories all dfirst))
      (dfirst (ls-file directories all dfirst))
      (else (ls-file directories all dfirst))))
  0)
