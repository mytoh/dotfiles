#!/usr/bin/env gosh

(use rfc.http)
(use rfc.uri)
(use gauche.process)
(use gauche.charconv)
(use file.util)
(use gauche.collection) ;find
(use gauche.parseopt)
(use srfi-11)
(use kirjasto) ; forever cd  mkdir


(define (usage )
  (print "Usage: yotsuba board thread")
  (print "  option)")
  (print "\t-a|all      get thread number from directories under cwd")
  (print "\t-r|repeat   repeat script with interval 5 minutes")
  (print "\tboard       b g a v hc ...")
  (print "\tthread      3839 2230 93988 482208 ...")
  (print "  expamle) ")
  (print "\t$ yotsuba b 999999        # get images from /b/999999 with repeat option" )
  (print "\t$ yotsuba -r g 9999       # get images from /g/9999 with repeat option" )
  (print "\t$ yotsuba -a b            # get images from b with directory name as thread number" )
  (exit 2))


(define (parse-img line)
 (rxmatch->string #/http\:\/\/images\.4chan\.org\/[^"]+/ line )
 ) 
;; "


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
         (print (make-colour 4 thread))
         (mkdir thread)
         (cd thread)
         (get-img html board)
         (cd ".."))
      (begin
       (print (make-colour 0 (string-append thread "'s gone")))
       ))))


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
         (print (make-colour 4 thread))
         (mkdir thread)
         (cd thread)
         (get-img html board)
         (print (make-colour 237 "----------"))
         (cd "..")
         )
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
