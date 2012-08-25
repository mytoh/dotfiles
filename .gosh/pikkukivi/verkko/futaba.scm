
(define-module pikkukivi.verkko.futaba
  (export futaba)
  (use rfc.http)
  (use rfc.uri)
  (use gauche.process)
  (use gauche.charconv)
  (use file.util)
  (use util.match)
  (use gauche.collection) ;find
  (use gauche.parseopt)
  (use srfi-11)
  (use kirjasto.komento.työkalu)
  (use kirjasto.työkalu)
  (use kirjasto.väri) ; colour-string
  (use kirjasto.merkkijono)
  (use kirjasto.verkko)
  (use clojure)
  )
(select-module pikkukivi.verkko.futaba)



(define (usage)
  (print-strings
    '("Usage: futaba board thread"
      "  option:"
      "\t-a|all      get thread number from directories under cwd"
      "\t-r|repeat   repeat script with interval 5 minutes"
      "\tboard      only supports b,k,l,7,40"
      "\tthread      3839 2230 93988 482208 ..."
      "  expamle: "
      "\t$ futaba b 222222         # get images once from /b/222222 "
      "\t$ futaba -r id 9999       # get images from /id/9999 with repeat option"
      "\t$ futaba -a b             # get images from b with directory name as thread number"))
  (exit 2))


(define (parse-img-url line board)
  (rxmatch->string
    (string->regexp
      (string-append
        "http\:\/\/(\\w+)\\.2chan\\.net\/(\\w+)\/"
        board
        "\/src\/[^\"]+"))
    line))

(define (fetch match)
  (when (string? match)
    (swget match)))

(define (get-img str board)
  (call-with-input-string str
                          (lambda (in)
                            (port-for-each
                              (lambda (line)
                                (let ((match (parse-img-url line board)))
                                  (fetch match)))
                              (cut read-line in #t)))))



(define (get-html board td)
  (let-values (((status headers body)
                (let* ((bd board)
                       (fget (lambda (server)
                               (http-get (string-append server ".2chan.net")
                                         (string-append "/" board "/res/" td ".htm")))))
                  (match bd
                    ("l" ;二次元壁紙
                     (fget  "dat" ))
                    ("k" ;壁紙
                     (fget "cgi"))
                    ("b" ;虹裏
                     (let ((servs '("jun" "dec" "may"))
                           (get-res (lambda (srv)
                                      (receive (a b c)
                                        (fget srv)
                                        (if-not (string=? a "404") srv #f))))
                           (get-values (lambda (srv)
                                         (receive (a b c)
                                           (fget srv)
                                           (when (not (string=? a "404")) (values a b c))))))
                       (or (and-let* ((s (get-res "jun")))
                             (get-values "jun"))
                         (and-let* ((s (get-res "dec")))
                           (get-values "dec"))
                         (and-let* ((s (get-res "may")))
                           (get-values "may"))
                         (values "404" #f #f))))
                    ("7" ;ゆり
                     (fget "zip"))
                    ("40" ;東方
                     (fget "may"))))))
    (cond ((not (string=? status "404"))
           (let ((html (ces-convert body "*jp" "utf-8")))
             (if (string-incomplete? html)
               (string-incomplete->complete html :omit)
               html)))
      (else  #f))))

(define (futaba-get args )
  (let* ((board (car args))
         (thread (cadr args))
         (html (get-html board thread)))
    (cond
      ((string? html)
       (print (colour-string 4 thread))
       (mkdir thread)
       (cd thread)
       (get-img html board)
       (cd ".."))
      (else
        (print (colour-string 237 (string-append thread "'s gone")))))))

(define (futaba-get-all args )
  (let ((board (car args))
        (dirs (values-ref (directory-list2 (current-directory) :children? #t) 0)))
    (cond
      ((not (null? dirs))
       (for-each
         (lambda (d)
           (futaba-get (list board d)))
         dirs)
       (run-process `(notify-send ,(string-append "futaba " board  " fetch finished"))))
      (else  (print "no directories")))))

(define (futaba-get-repeat args)
  (let* ((board (car args))
         (thread (cadr args))
         (html (get-html board thread)))
    (cond
      ((string? html)
       (print (colour-string 4 thread))
       (mkdir thread)
       (cd thread)
       (get-img html board)
       (cd ".."))
      (else  #t))))

(define (futaba-get-repeat-all args)
    (let ((board (car args))
          (dirs (values-ref (directory-list2 (current-directory) :children? #t) 0)))
      (cond
        ((not (null? dirs))
         (for-each
           (lambda (d)
             (futaba-get-repeat (list board d)))
           dirs))
        (else (print "no directories")))
      (print (colour-string 237 "----------"))))

(define (futaba args)
  (let-args args
    ((all "a|all")
     (repeat "r|repeat")
     (else (opt . _) (print "Unknown option: " opt) (usage))
     . restargs)
    (cond
      ((null? restargs)
       (usage))
      ((and all repeat)
       (loop-forever
       (futaba-get-repeat-all restargs)))
      (repeat
        (loop-forever
        (futaba-get-repeat restargs)))
      (all
        (futaba-get-all restargs))
      (else
        (futaba-get restargs)))))
