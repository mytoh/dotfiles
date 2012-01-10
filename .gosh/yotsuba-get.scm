#!/usr/bin/env gosh

(use rfc.http)
(use rfc.uri)
(use gauche.process)
(use gauche.charconv)
(use file.util)
(use gauche.collection) ;find
(use gauche.parseopt)
(use srfi-11)
(load "kirjasto")


(define (usage )
  (format (current-error-port)
          "Usage: ~a board thread \n" "get")
  (exit 2))

(define-syntax forever 
  (syntax-rules ()
    ((_ e1 e2 ...)
     (let loop () e1 e2 ... 
          (sys-nanosleep (* (expt 10 8) 3000)) ; sleep 5 minutes
          (loop)))))

(define (parse-img line)
 (rxmatch->string #/http\:\/\/images\.4chan\.org\/[^"]+/ line )
 ) 
;; "


(define (parse-url url)
  (rxmatch-let (rxmatch #/^http:\/\/([-A-Za-z\d.]+)(:(\d+))?(\/.*)?/ url)
               (#f host #f port path)
               (values host port path)))

(define (swget url)
  (receive (host port path) (parse-url url)
           (let ((file (receive (a fname ext) (decompose-path path) (string-append fname "." ext))))
             (if (not (file-is-readable? file))
                 (http-get host path
                           :sink (open-output-file file) :flusher (lambda (s h) (print file) #t))))))

(define (fetch match)
  (if (string? match)
      (swget match)))

(define (get-img str board)
  (call-with-input-string str
                          (lambda (in)
                            (port-for-each
                             (lambda (line)
                               (let ((match (parse-img line)))
                                 (fetch match)))
                             (cut read-line in #t)))))

(define (mkdir dir)
  (if (not (file-exists? dir))
      (make-directory* dir)))

(define (cd dir)
  (if (file-is-directory? dir)
      (current-directory dir)))

(define (get-html bd td)
  (let-values (((status headers body ) (http-get  "boards.4chan.org"  (string-append "/" bd "/res/"  td)) ))
    (if  (string=? status "404")
        #f
      (if (string-incomplete? body)
          (if-let1 html (string-incomplete->complete body :omit)
                   html
                   (ces-convert body "*jp" "utf-8"))
        (ces-convert body "*jp" "utf-8")))))

(define (yotsuba-get restargs )
  (let* ((board (car restargs))
         (thread (cadr restargs))
         (html (get-html board thread)))
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
       (display "[0m")))))


(define (yotsuba-get-all restargs )
  (let ((bd (car restargs))
        (dirs (values-ref (directory-list2 (current-directory) :children? #t) 0)))
    (if (not (null? dirs))
        (for-each
         (lambda (d)
           (yotsuba-get (list bd d)))
         dirs)
      (print "no directories")
      )))

(define (yotsuba-get-repeat restargs )
  (let* ((board (car restargs))
         (thread (cadr restargs))
         (html (get-html board thread)))
    (if (string? html)
        (begin
         (display "[0;34m")
         (print thread)
         (display "[0m")
         (mkdir thread)
         (cd thread)
         (get-img html board)
         (cd ".."))
        #t)))

(define (yotsuba-get-repeat-all restargs )
  (let ((bd (car restargs))
        (dirs (values-ref (directory-list2 (current-directory) :children? #t) 0)))
    (if (not (null? dirs))
        (for-each
         (lambda (d)
           (yotsuba-get-repeat (list bd d)))
         dirs)
      (print "no directories"))
      (print (make-colour 237 "----------"))
    ))



(define (main args)
  (let-args (cdr args)
            ((all "a|all")
             (repeat "r|repeat")
             (else (opt . _) (print "Unknown option: " opt) (usage))
             . restargs)
            (cond ((null? restargs) (usage))
                  ((and all repeat) (forever (yotsuba-get-repeat-all restargs)))
                  (repeat (forever (yotsuba-get-repeat restargs)))
                  (all (yotsuba-get-all restargs))
                  (else (yotsuba-get restargs)))))
