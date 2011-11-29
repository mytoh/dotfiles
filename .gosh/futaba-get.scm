#!/usr/bin/env gosh

(use rfc.http)
(use rfc.uri)
(use gauche.process)
(use gauche.charconv)
(use file.util)
(use gauche.collection) ;find
(use gauche.parseopt)


(define (usage )
  (format (current-error-port)
          "Usage: ~a board thread \n" "get")
  (exit 2))

(define (parse-img line board)
  (rxmatch->string (string->regexp (string-append "http\:\/\/(\\w+)\\.2chan\\.net\/(\\w+)\/" board "\/src\/[^\"]+")) line) 
 )

;; "

(define (fetch match)
  (if (string? match)
    (run-process `(wget -nc -nv ,match) :wait #t)) 
  )

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
  (let ((res 
  (cond ((string=? bd "l") ;二次元壁紙
          (values-ref (http-get  "dat.2chan.net"  (string-append "/" bd "/res/" td ".htm" )) 2))
         ((string=? bd "k") ;壁紙                                                          
          (values-ref (http-get  "cgi.2chan.net"  (string-append "/" bd "/res/" td ".htm" )) 2)) 
        ((string=? bd "b") ;虹裏
         (find string?
         (let ((servs '("jun" "dec" "may")))
              (map 
                (lambda (srv)
                  (receive (a b c . rest) (http-get (string-append srv ".2chan.net") (string-append "/" bd "/res/" td ".htm")) (if (not (string=? a "404"))  c #f)))
                servs))))
        ((string=? bd "7") ;ゆり
         (values-ref (http-get "zip.2chan.net" (string-append "/" bd "/res/" td ".htm")) 2))
        ((string=? bd "40") ;東方 
         (values-ref (http-get "may.2chan.net" (string-append "/" bd "/res/" td ".htm")) 2))
        ) ;cond 
  ))
       (if (string? res)
           (ces-convert res "*jp" "utf-8")
           #f)
       ) ;let
  )

(define (futaba-get args )
 (let* ((board (car args))
        (thread (cadr args))
        (html (get-html board thread))
        )
       (if (string? html)
           (begin
             (display "[1;34m")
             (print thread)
             (display "[0m")
             (mkdir thread)
             (cd thread)
             (get-img html board)
             (cd ".."))
           (begin
             (display "[1;30m") ;dark grey
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
