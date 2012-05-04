#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use util.match)
(use srfi-13)
(use file.util)


(define (bin->hex number-list)
  (string-join
  (map (lambda (s)
         (format #f "0x~x" (string->number (string-reverse (number->string s)) 2)))
      number-list )
  ", "))


(define (file->xbm ifile ofile)
  (let* ((flist (port->sexp-list (open-input-file ifile)))
         (width (number->string  (car flist)))
         (height (number->string  (cadr flist)))
         (num-lst (cddr flist))
         (base-fname (path-sans-extension ofile)))
(display
  (string-append "#define " base-fname "_width "  width "\n"
                 "#define " base-fname  "_height " height "\n"
                 "static unsigned char " base-fname "_bits[] = { " "\n" (bin->hex num-lst) " };"
                 "\n")
  (open-output-file ofile))))

(define (main args)
  (file->xbm (cadr args) (caddr args)))







;   sample
;
;    8           width
;    8           height
;    11110000
;    11110000
;    11110000
;    11110000
;    11110000
;    11110000
;    11110000
;    11110000
;
