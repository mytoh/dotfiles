#!/usr/bin/env gosh

(use gauche.process)
(use file.util)

(define (mkicons img)
  (run-process `(convert -background transparent -resize 16x16 ,img ,(string-append (sys-basename (path-sans-extension img)) "_16.png")))
  (run-process `(convert -background transparent -resize 32x32 ,img ,(string-append (sys-basename (path-sans-extension img)) "_32.png")))
  (run-process `(convert -background transparent -resize 64x64 ,img ,(string-append (sys-basename (path-sans-extension img)) "_64.png")))
  )

(define (main args)
  (mkicons (cadr args))
  )

