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



(define (fetch uri)
  (when (string? uri)
  (let-values (((scheme user-info hostname port-number path query fragment)
                (uri-parse uri)))
    (let* ((file (url->filename uri))
           (flusher (lambda (s h)  #t)))
      (if (not (file-is-readable? file))
        (call-with-output-file
          file
          (cut http-get hostname path
            :sink <> :flusher flusher))
        #f)))))

(define (url->filename url)
  (receive (a fname ext)
    (decompose-path (values-ref (uri-parse url) 4))
    (path-swap-extension fname ext)))

;

(define (get-img body board)
  (let ((img-url-list (delete-duplicates
                        (filter string? (map (lambda (x)
                                           (parse-img x board))
                                         (string-split
                                           body
                                           (string->regexp
                                             "<\/?(?:img)[^>]*>")))))))
    (let ((got-images (filter string? (map
                               (lambda (url)
                                 ;; download indivisual image
                                 (fetch
                                   (str "http:" url)))
                               img-url-list))))
      (flush)
 (match (length got-images)
        (0 (newline))
        (1 (print (str " " (colour-string 49 (number->string (length got-images)))
                       " new file")))
        (_ (print (str " " (colour-string 49 (number->string (length got-images)))
                       " new files")))))))

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

(define (yotsuba-get restargs)
  (let* ((board (car restargs))
         (thread (cadr restargs))
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


(define (yotsuba-get-all restargs)
  (let ((bd (car restargs))
        (dirs (values-ref (directory-list2 (current-directory) :children? #t) 0)))
    (cond
      ((not (null? dirs))
       (for-each
         (lambda (d)
           (yotsuba-get (list bd d)))
         dirs)
       (print (str (colour-string 33 bd) " fetch finished")))
      (else
        (print "no directories")))))


(define (yotsuba-get-repeat args)
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
        (else #t))))


(define (yotsuba-get-repeat-all args)
  (loop-forever
    (let ((bd (car args))
          (dirs (values-ref (directory-list2 (current-directory) :children? #t) 0)))
      (print (string-append "getting " bd))
      (if-not (null? dirs)
              (for-each
                (lambda (d)
                  (yotsuba-get-repeat (list bd d)))
                dirs)
              (print "no directories")))))



(define (yotsuba args)
  (let-args args
    ((all "a|all")
     (repeat "r|repeat")
     (else (opt . _) (print "Unknown option: " opt) (usage))
     . restargs)
    (cond
      ((null? restargs)
       (usage))
      ((and all repeat)
       (yotsuba-get-repeat-all restargs))
      (repeat
        (loop-forever
        (yotsuba-get-repeat restargs)))
      (all
        (yotsuba-get-all restargs))
      (else
        (yotsuba-get restargs)))))
