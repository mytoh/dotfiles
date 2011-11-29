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

(define (parse-img line)
 (rxmatch->string #/http\:\/\/images\.4chan\.org\/[^"]+/ line) 
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
     (let ((match (parse-img line)))
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
  (let ((res (values-ref (http-get  "boards.4chan.org"  (string-append "/" bd "/res/" td)) 2)))
       (if (string? res)
           (ces-convert res "*jp" "utf-8")
           #f)
       ) ;let
  )

(define (yotsuba-get args )
 (let* ((board (car args))
        (thread (cadr args))
        (html (get-html board thread))
        )
       (if (string? html)
           (begin
             (print thread)
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

(define (yotsuba-get-all args )
  (let ((board (car args))
        (dirs (values-ref (directory-list2 (current-directory) :children? #t) 0))
        )
       (if (not (null? dirs))
           (for-each 
             (lambda (d)
               (yotsuba-get (list board d))
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
            (yotsuba-get-all restargs))
            (else
              (yotsuba-get restargs))
            )
 ) ;let-args
)

