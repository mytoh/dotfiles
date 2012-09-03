
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
  (use kirjasto.pääte)
  (use clojure)
  (require-extension (srfi 1))
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
      (str
        "http\:\/\/(\\w+)\\.2chan\\.net\/(\\w+)\/"
        board
        "\/src\/[^\"]+"))
    line))


(define (get-img html board)
  (let ((image-url-list (remove not
                                (call-with-input-string html
                                  (lambda (in)
                                    (port-map
                                      (lambda (line)
                                        (let ((m (parse-img-url line board)))
                                          m))
                                      (cut read-line in #t)))))))
    (flush)
    (let ((got-images (remove not
                              (map (lambda (url) (fetch url))
                                   image-url-list))))
      (match (length got-images)
        (0 (newline))
        (1 (print (str " " (colour-string 49 (number->string (length got-images)))
                       " new file")))
        (_ (print (str " " (colour-string 49 (number->string (length got-images)))
                       " new files")))))))

(define (url->filename url)
  (receive (a fname ext)
    (decompose-path (values-ref (uri-parse url) 4))
    (path-swap-extension fname ext)))

(define (fetch uri)
  (when (string? uri)
    (let-values (((scheme user-info hostname port-number path query fragment)
                  (uri-parse uri)))
      (let* ((file (url->filename uri))
             (flusher (lambda (sink headers)  #t)))
        (if (not (file-is-readable? file))
          (receive (temp-out temp-file)
            (sys-mkstemp "yotsuba-temp")
            (http-get hostname path
                      :sink temp-out :flusher flusher)
            (close-output-port temp-out)
            (move-file temp-file file))
          #f)))))



(define (get-html board td)
  (let-values (((status headers body)
                (let* ((bd board)
                       (fget (lambda (server)
                               (http-get (str server ".2chan.net")
                                         (str "/" board "/res/" td ".htm")))))
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

(define (futaba-get args)
  (let* ((board (car args))
         (thread (cadr args))
         (html (get-html board thread)))
    (cond
      ((string? html)
       (display (colour-string 4 thread))
       (mkdir thread)
       (cd thread)
       (get-img html board)
       (cd ".."))
      (else
        (print (colour-string 237 (str thread "'s gone")))))))

(define (futaba-get-all args)
  (let ((board (car args))
        (dirs (values-ref (directory-list2 (current-directory) :children? #t) 0)))
    (cond
      ((not (null? dirs))
       (for-each
         (lambda (d)
           (futaba-get (list board d)))
         dirs)
       (run-process `(notify-send ,(str "futaba " board  " fetch finished"))))
      (else  (print "no directories")))))

(define (futaba-get-repeat args)
  (let* ((board (car args))
         (thread (cadr args))
         (html (get-html board thread)))
    (cond
      ((string? html)
       (tput-clr-bol)
       (display (colour-string 4 thread))
       (mkdir thread)
       (cd thread)
       (get-img html board)
       (cd ".."))
      (else
        (display (colour-string 237 (str thread "'s gone")))
        (flush)
        (sys-select #f #f #f 100000)
        (display "\r")
        (tput-clr-eol)))))

(define (futaba-get-repeat-all args)
  (loop-forever
    (let ((board (car args))
          (dirs (values-ref (directory-list2 (current-directory) :children? #t) 0)))
      (print (str "Board " (colour-string 229 board)))
      (cond
        ((not (null? dirs))
         (for-each
           (lambda (d)
             (futaba-get-repeat (list board d)))
           dirs))
        (else (print "no directories")))
      (print (colour-string 237 "----------")))))

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
       (futaba-get-repeat-all restargs))
      (repeat
        (loop-forever
          (futaba-get-repeat restargs)))
      (all
        (futaba-get-all restargs))
      (else
        (futaba-get restargs)))))
