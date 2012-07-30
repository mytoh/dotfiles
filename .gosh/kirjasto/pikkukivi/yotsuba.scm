#!/usr/bin/env gosh
;; -*- coding: utf-8 -*-


(define-module pikkukivi.yotsuba
  (export yotsuba)
  (use rfc.http)
  (use rfc.uri)
  (use gauche.process)
  (use gauche.charconv)
  (use file.util)
  (use gauche.collection) ;find
  (use gauche.parseopt)
  (require-extension
    (srfi 1 11 13))
  (use kirjasto.komento.työkalu)
  (use kirjasto.työkalu)
  (use kirjasto.väri) ; colour-string
  (use kirjasto.merkkijono)
  (use kirjasto.verkko)
  )
(select-module pikkukivi.yotsuba)


(define (usage )
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
      (string-concatenate `("\\/\\/images\\.4chan\\.org\\/"
                            ,(x->string  board)
                            "\\/src\\/[^\"]+")))
    line))
;; "


(define (fetch url)
  ;; downloda file from url
  (when (string? url)
    (swget url)))


(define (get-img body board)
  (map
    (lambda (url)
      ;; download indivisual image
      (fetch
        (string-append
          "http:"
          url)))
    (delete-duplicates
      (remove not
              (map
                (lambda (x)
                  (parse-img x board))
                (string-split
                  body
                  (string->regexp
                    "<\/?(?:img)[^>]*>"))))))
  )

(define (get-html bd td)
  (let-values (((status headers body )
                (http-get  "boards.4chan.org"
                           (string-concatenate
                             `("/" ,(x->string bd) "/res/"  ,(x->string td))))))
    (cond
      ((string=? status "404")
       #f)
      ((string-incomplete? body)
       (if-let1 html (string-incomplete->complete body :omit)
         html
         (ces-convert body "*jp" "utf-8")))
      (else
        (ces-convert body "*jp" "utf-8")))))

(define (yotsuba-get restargs )
  (let* ((board (car restargs))
         (thread (cadr restargs))
         (html (get-html board thread)))
    (cond
      ((string? html)
       (print (colour-string 4 thread))
       (mkdir thread)
       (cd thread)
       (get-img html board)
       (cd ".."))
      (else
        (print (colour-string
                 237
                 (string-append
                   thread
                   "'s gone")))))))


(define (yotsuba-get-all restargs )
  (let ((bd (car restargs))
        (dirs (values-ref (directory-list2 (current-directory) :children? #t) 0)))
    (cond
      ((not (null? dirs))
       (for-each
         (lambda (d)
           (yotsuba-get (list bd d)))
         dirs)
       (run-process `(notify-send ,(string-append bd " fetch finished"))))
      (else
        (print "no directories"))
      )))

(define (yotsuba-get-repeat restargs )
  (let* ((board (car restargs))
         (thread (cadr restargs))
         (html (get-html board thread)))
    (cond
      ((string? html)
       (print (colour-string 4 thread))
       (mkdir thread)
       (cd thread)
       (get-img html board)
       (cd ".."))
      (else
        #t))))

(define (yotsuba-get-repeat-all restargs )
  (let ((bd (car restargs))
        (dirs (values-ref (directory-list2 (current-directory) :children? #t) 0)))
    (if (not (null? dirs))
      (for-each
        (lambda (d)
          (yotsuba-get-repeat (list bd d)))
        dirs)
      (print "no directories"))
    (print (colour-string 237 "----------"))
    ))



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
       (forever (yotsuba-get-repeat-all restargs)))
      (repeat
        (forever (yotsuba-get-repeat restargs)
                 (print (colour-string 237 "----------"))))
      (all
        (yotsuba-get-all restargs))
      (else
        (yotsuba-get restargs)))))
