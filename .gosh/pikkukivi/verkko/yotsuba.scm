#!/usr/bin/env gosh
;; -*- coding: utf-8 -*-


(define-module pikkukivi.verkko.yotsuba
  (export yotsuba)
  (use rfc.http)
  (use rfc.uri)
  (use gauche.process)
  (use gauche.charconv)
  (use file.util)
  (use util.match)
  (use gauche.collection) ;find
  (use gauche.parseopt)
  (require-extension
    (srfi 1 11 13))
  (use kirjasto.komento.työkalu)
  (use kirjasto.työkalu)
  (use kirjasto.väri) ; colour-string
  (use kirjasto.merkkijono)
  (use kirjasto.pääte)
  (use clojure)
  )
(select-module pikkukivi.verkko.yotsuba)


(define (usage)
  (print-strings
    '("Usage: yotsuba board thread"
      "  option)"
      "\t-a|all      get thread number from directories under cwd"
      "\t-r|repeat   repeat script with interval 5 minutes"
      "\tboard       b g a v hc ..."
      "\tthread      3839 2230 93988 482208 ..."
      "  expamle) "
      "\t$ yotsuba b 999999        # get images from /b/999999 with repeat option"
      "\t$ yotsuba -r g 9999       # get images from /g/9999 with repeat option"
      "\t$ yotsuba -a b            # get images from b with directory name as thread number"))
  (exit 2))


(define (parse-img line board)
  (rxmatch->string
    (string->regexp
      (str "\\/\\/images\\.4chan\\.org\\/"
           (x->string  board)
           "\\/src\\/[^\"]+"))
    line))
;; "



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
        (cond
          ((not (file-is-readable? file))
           (receive (temp-out temp-file)
             (sys-mkstemp "yotsuba-temp")
             (http-get hostname path
                       :sink temp-out :flusher flusher)
             (close-output-port temp-out)
             (move-file temp-file file))
           file)
          (else #f))))))


(define (get-img body board)
  (let ((img-url-list (delete-duplicates
                        (filter string? (map (lambda (x)
                                               (parse-img x board))
                                             (string-split body
                                                           (string->regexp
                                                             "<\/?(?:img)[^>]*>")))))))
    (flush)
    (let ((got-images (remove not (map (lambda (url)
                                         ;; download indivisual image
                                         (fetch (str "http:" url)))
                                       img-url-list))))
      (match (length got-images)
        (0 (newline))
        (1 (print " " (colour-string 49 (number->string (length got-images)))
                  " new file"))
        (_ (print " " (colour-string 49 (number->string (length got-images)))
                  " new files"))))))

(define (get-html bd td)
  (let-values (((status headers body)
                (http-get  "boards.4chan.org"
                           (str "/" (x->string bd) "/res/"  (x->string td)))))
    (cond
      ((string=? status "404")
       #f)
      ((string-incomplete? body)
       (if-let1 html (string-incomplete->complete body :omit)
         html
         (ces-convert body "*jp" "utf-8")))
      (else
        (ces-convert body "*jp" "utf-8")))))

(define (yotsuba-get args)
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


(define (yotsuba-get-all args)
  (let ((bd (car args))
        (dirs (values-ref (directory-list2 (current-directory) :children? #t) 0)))
    (cond
      ((not (null? dirs))
       (for-each
         (lambda (d)
           (yotsuba-get (list bd d)))
         dirs)
       (print (colour-string 33 bd) " fetch finished"))
      (else
        (print "no directories")))))

(define (yotsuba-get-repeat args)
  (loop-forever (yotsuba-get args)))


(define (yotsuba-get-repeat-all args)
  (loop-forever
    (let ((bd (car args))
          (dirs (values-ref (directory-list2 (current-directory) :children? #t) 0)))
      (print "getting " bd)
      (if-not (null? dirs)
              (for-each
                (lambda (d)
                  (yotsuba-get (list bd d)))
                dirs)
              (print "no directories")))))



(define (yotsuba args)
  (let-args args
    ((all "a|all")
     (repeat "r|repeat")
     (else (opt . _) (print "Unknown option: " opt) (usage))
     . restargs)
    (tput-cursor-invisible)
      (cond
        ((null? restargs)
         (usage))
        ((and all repeat)
         (yotsuba-get-repeat-all restargs))
        (repeat
          (yotsuba-get-repeat restargs))
        (all
          (yotsuba-get-all restargs))
        (else
          (yotsuba-get restargs)))
      (tput-cursor-normal)))
