#!/usr/bin/env gosh

(use rfc.http)
(use rfc.uri)
(use gauche.process)
(use gauche.charconv)
(use file.util)
(use gauche.collection) ;find
(use gauche.parseopt)
(use srfi-11)
(load "kirjasto") ; forever


(define (usage)
  (format (current-error-port)
          "Usage: ~a board thread \n" "get")
  (exit 2))


(define (parse-img-url line board)
  (rxmatch->string (string->regexp (string-append "http\:\/\/(\\w+)\\.2chan\\.net\/(\\w+)\/" board "\/src\/[^\"]+")) line) 
 ) ;; "

(define (parse-url url)
  (rxmatch-let (rxmatch #/^http:\/\/([-A-Za-z\d.]+)(:(\d+))?(\/.*)?/ url)
      (#f host #f port path)
      (values host port path)))

(define (swget url)
  (receive (host port path) (parse-url url)
      (let1 file (receive (dir fname ext) (decompose-path path) (string-append fname "." ext))
            (if (not (file-is-readable? file))
               (http-get host path
                         :sink (open-output-file file) :flusher (lambda (s h) (print file) #t))
           )
            ) ;let1
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
     (let ((match (parse-img-url line board)))
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

(define (get-html board td)
  (let-values (((status headers body) 
       (let* ((bd (string->symbol board))
              (fget (lambda (server)
                      (http-get (string-append server ".2chan.net") 
                                (string-append "/" board "/res/" td ".htm"))))
              )
             (case bd
               ((l) ;二次元壁紙
                (fget  "dat" ))
               ((k) ;壁紙
                (fget "cgi"))
               ((b) ;虹裏
                (let ((servs '("jun" "dec" "may"))
                      (get-res (lambda (srv)
                                 (receive (a b c)
                                          (fget srv)
                                          (if (not (string=? a "404")) srv #f))))
                      (get-values (lambda (srv)
                                    (receive (a b c)
                                             (fget srv)
                                             (if (not (string=? a "404")) (values a b c)))))
                      )
                  (or (and-let* ((s (get-res "jun")))
                                (get-values "jun"))
                    (and-let* ((s (get-res "dec")))
                              (get-values "dec"))
                    (and-let* ((s (get-res "may")))
                              (get-values "may"))
                    (values "404" #f #f)
                    )))
               ((7) ;ゆり
                (fget "zip"))
               ((40) ;東方 
                 (fget "may"))
               ) ;case
             ) ;let*
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

(define (futaba-get-repeat args)
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
             #t
           )
       ) ;let*
  )

(define (futaba-get-repeat-all args)
  (let ((board (car args))
        (dirs (values-ref (directory-list2 (current-directory) :children? #t) 0))
        )
       (if (not (null? dirs))
           (for-each 
             (lambda (d)
               (futaba-get-repeat (list board d))
               )
             dirs)
           (print "no directories")
           )
       (print (make-colour 237 "----------"))
       ) ;let
  )


(define (main args)
  (let-args (cdr args)
     ((all "a|all")
      (repeat "r|repeat")
      (else (opt . _) (print "Unknown option: " opt) (usage))
      . restargs)
     (cond ((null? restargs)
           (usage))
           ((and all repeat)
            (forever (futaba-get-repeat-all restargs)))
           (repeat (forever (futaba-get-repeat restargs)))
           (all
            (futaba-get-all restargs))
            (else
              (futaba-get restargs))
            )
 ) ;let-args
)
