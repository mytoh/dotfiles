#!/usr/bin/env gosh

(use rfc.http)
(use rfc.uri)
(use gauche.process)
(use gauche.charconv)
(use file.util)
(use gauche.collection) ;find
(use gauche.parseopt)
(use srfi-11)


(define (usage )
  (format (current-error-port)
          "Usage: ~a board thread \n" "get")
  (exit 2))

(define (parse-img line board)
  (rxmatch->string (string->regexp (string-append "http\:\/\/(\\w+)\\.2chan\\.net\/(\\w+)\/" board "\/src\/[^\"]+")) line) 
 ) ;; "

(define (parse-url url)
  (rxmatch-let (rxmatch #/^http:\/\/([-A-Za-z\d.]+)(:(\d+))?(\/.*)?/ url)
      (#f host #f port path)
      (values host port path)))

(define (swget url)
  (receive (host port path) (parse-url url)
      (let ((file (receive (dir fname ext) (decompose-path path) (string-append fname "." ext))))
           (if (not (file-is-readable? file))
               (http-get host path
                         :sink (open-output-file file) :flusher (lambda (s h) (print file) #t))
               )
           ) ;let
  )) ;define

(define (fetch match)
  (if (string? match)
      (swget match)
  ))

(define (get-img str board)
 (call-with-input-string str
  (lambda (in) 
   (port-for-each
    (lambda (line)
     (let ((match (parse-img line board)))
            (fetch match)
          )
     )
    (cut read-line in #t)
   )))
 )

(define (mkdir dir)
 (if (not (file-exists? dir))
  (make-directory* dir)
 )
)

(define (cd dir)
 (if (file-is-directory? dir)
  (current-directory dir)
 )
)

(define (get-html bd td)
  (let-values (((status headers body) 
  (cond ((string=? bd "l") ;二次元壁紙
           (http-get  "dat.2chan.net"  (string-append "/" bd "/res/" td ".htm" ))
           )
         ((string=? bd "k") ;壁紙
          (http-get  "cgi.2chan.net"  (string-append "/" bd "/res/" td ".htm" ))
          )
        ((string=? bd "b") ;虹裏
         (let ( (servs '("jun" "dec" "may"))
                (get-res (lambda (srv)
                           (receive (a b c) (http-get (string-append  srv ".2chan.net") (string-append "/" bd "/res/" td ".htm")) (if (not (string=? a "404")) srv #f))))
                (get-values (lambda (srv)
                              (receive (a b c) (http-get (string-append  srv ".2chan.net") (string-append "/" bd "/res/" td ".htm")) (if (not (string=? a "404")) (values a b c)))))
                )
               (or (and-let* ((s (get-res "jun")))
                         (get-values "jun"))
                   (and-let* ((s (get-res "dec")))
                             (get-values "dec"))
                   (and-let* ((s (get-res "may")))
                             (get-values "may"))
                   (values "404" #f #f)
                   )))
        ((string=? bd "7") ;ゆり
          (http-get "zip.2chan.net" (string-append "/" bd "/res/" td ".htm")))
        ((string=? bd "40") ;東方 
         (http-get "may.2chan.net" (string-append "/" bd "/res/" td ".htm")))
        ) ;cond 
  ))
  (if (not (string=? status "404"))
   (let ((html (ces-convert body "*jp" "utf-8")))
    (if (string-incomplete? html)
    (string-incomplete->complete html :omit)
    html))
#f)
   ) ;let-values
  )

(define (futaba-get args )
 (let* ((board (car args))
        (thread (cadr args))
        (html (get-html board thread))
        )
       (if (string? html)
           (begin
             (display "[0;34m")
             (print thread)
             (display "[0m")
             (mkdir thread)
             (cd thread)
             (get-img html board)
             (cd ".."))
           (begin
             (display "[0;30m") ;dark grey
             (print (string-append thread "'s gone"))
             (display "[0m"))
           )
       ) ;let*
 )
 

(define (futaba-get-all args )
  (let ((board (car args))
        (dirs (values-ref (directory-list2 (current-directory) :children? #t) 0))
        )
       (if (not (null? dirs))
           (for-each 
             (lambda (d)
               (futaba-get (list board d))
               )
             dirs)
           (print "no directories")
           )
       ) ;let
  )


(define (main args)
  (let-args (cdr args)
     ((all "a|all")
      (else (opt . _) (print "Unknown option: " opt) (usage))
      . restargs)
     (cond ((null? restargs)
           (usage))
           (all
            (futaba-get-all restargs))
            (else
              (futaba-get restargs))
            )
 ) ;let-args
)
