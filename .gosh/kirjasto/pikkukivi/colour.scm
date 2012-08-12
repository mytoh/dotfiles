#!/usr/bin/env gosh

(define-module pikkukivi.colour
  (export
    colour)
  (use gauche.process)
  (use util.list) ; slices
  (use util.match)
  (use file.util)
  (require-extension (srfi 1 13))    ; iota
  (use kirjasto.merkkijono)
  (use kirjasto.väri))
(select-module pikkukivi.colour)


(define (colour-names)
  (let ((ls (slices (iota 256) 16))
        (colour-numbers (lambda (n)
                          (display
                            (format " ~a"
                                    (concat "[38;5;" (number->string n) "m"
                                            (number->string n) "[0m" ))))))
    (newline)

    (print "system colours")
    (for-each colour-numbers
              (car ls))
    (newline)
    (newline)

    (print "other colours")
    (let loop ((l (cdr ls)))
      (cond
        ((null? l)
         '())
        (else
          (for-each colour-numbers
                    (car l))
          (newline)
          (loop (cdr l)))))))

; set blackf  (tput setaf 0); set redf    (tput setaf 1); set greenf  (tput setaf 2)
; set yellowf (tput setaf 3); set bluef   (tput setaf 4); set purplef (tput setaf 5)
; set cyanf   (tput setaf 6); set whitef  (tput setaf 7)

(define blackf  "[38;5;0m")
(define redf    "[38;5;1m")
(define greenf  "[38;5;2m")
(define yellowf "[38;5;3m")
(define bluef   "[38;5;4m")
(define purplef "[38;5;5m")
(define cyan   "[38;5;6m")
(define white  "[38;5;7m")

(define reset "[0m")
(define boldon "[1m")

(define (colour-pacman)
  (print
    #`"
    ,|yellowf|  ▄███████▄,reset   ,|redf|  ▄██████▄,reset    ,|greenf|  ▄██████▄,reset    ,|bluef|  ▄██████▄,reset    ,|purplef|  ▄██████▄,reset    ,|cyan|  ▄██████▄,reset
    ,|yellowf|▄█████████▀▀,reset  ,|redf|▄,|white|█▀█,|redf|██,|white|█▀█,|redf|██▄,reset  ,|greenf|▄,|white|█▀█,|greenf|██,|white|█▀█,|greenf|██▄,reset  ,|bluef|▄,|white|█▀█,|bluef|██,|white|█▀█,|bluef|██▄,reset  ,|purplef|▄,|white|█▀█,|purplef|██,|white|█▀█,|purplef|██▄,reset  ,|cyan|▄,|white|█▀█,|cyan|██,|white|█▀█,|cyan|██▄,reset
    ,|yellowf|███████▀,reset      ,|redf|█,|white|▄▄█,|redf|██,|white|▄▄█,|redf|███,reset  ,|greenf|█,|white|▄▄█,|greenf|██,|white|▄▄█,|greenf|███,reset  ,|bluef|█,|white|▄▄█,|bluef|██,|white|▄▄█,|bluef|███,reset  ,|purplef|█,|white|▄▄█,|purplef|██,|white|▄▄█,|purplef|███,reset  ,|cyan|█,|white|▄▄█,|cyan|██,|white|▄▄█,|cyan|███,reset
    ,|yellowf|███████▄,reset      ,|redf|████████████,reset  ,|greenf|████████████,reset  ,|bluef|████████████,reset  ,|purplef|████████████,reset  ,|cyan|████████████,reset
    ,|yellowf|▀█████████▄▄,reset  ,|redf|██▀██▀▀██▀██,reset  ,|greenf|██▀██▀▀██▀██,reset  ,|bluef|██▀██▀▀██▀██,reset  ,|purplef|██▀██▀▀██▀██,reset  ,|cyan|██▀██▀▀██▀██,reset
    ,|yellowf|  ▀███████▀,reset   ,|redf|▀   ▀  ▀   ▀,reset  ,|greenf|▀   ▀  ▀   ▀,reset  ,|bluef|▀   ▀  ▀   ▀,reset  ,|purplef|▀   ▀  ▀   ▀,reset  ,|cyan|▀   ▀  ▀   ▀,reset
    ,boldon
    ,|yellowf|  ▄███████▄   ,|redf|  ▄██████▄    ,|greenf|  ▄██████▄    ,|bluef|  ▄██████▄    ,|purplef|  ▄██████▄    ,|cyan|  ▄██████▄,reset
    ,boldon,|yellowf|▄█████████▀▀  ,|redf|▄,|white|█▀█,|redf|██,|white|█▀█,|redf|██▄  ,|greenf|▄,|white|█▀█,|greenf|██,|white|█▀█,|greenf|██▄  ,|bluef|▄,|white|█▀█,|bluef|██,|white|█▀█,|bluef|██▄  ,|purplef|▄,|white|█▀█,|purplef|██,|white|█▀█,|purplef|██▄  ,|cyan|▄,|white|█▀█,|cyan|██,|white|█▀█,|cyan|██▄,reset
    ,boldon,|yellowf|███████▀      ,|redf|█,|white|▄▄█,|redf|██,|white|▄▄█,|redf|███  ,|greenf|█,|white|▄▄█,|greenf|██,|white|▄▄█,|greenf|███  ,|bluef|█,|white|▄▄█,|bluef|██,|white|▄▄█,|bluef|███  ,|purplef|█,|white|▄▄█,|purplef|██,|white|▄▄█,|purplef|███  ,|cyan|█,|white|▄▄█,|cyan|██,|white|▄▄█,|cyan|███,reset
    ,boldon,|yellowf|███████▄      ,|redf|████████████  ,|greenf|████████████  ,|bluef|████████████  ,|purplef|████████████  ,|cyan|████████████,reset
    ,boldon,|yellowf|▀█████████▄▄  ,|redf|██▀██▀▀██▀██  ,|greenf|██▀██▀▀██▀██  ,|bluef|██▀██▀▀██▀██  ,|purplef|██▀██▀▀██▀██  ,|cyan|██▀██▀▀██▀██,reset
    ,boldon,|yellowf|  ▀███████▀   ,|redf|▀   ▀  ▀   ▀  ,|greenf|▀   ▀  ▀   ▀  ,|bluef|▀   ▀  ▀   ▀  ,|purplef|▀   ▀  ▀   ▀  ,|cyan|▀   ▀  ▀   ▀,reset
    "
    ))


(define (spect-system-colours)
  (print "System colors")
  (for-each
    (lambda (s)
      (display
        (format "[48;5;~Am  " s)))
    (iota 8))
  (display "[0m")
  (newline)
  (for-each
    (lambda (s)
      (display
        (format "[48;5;~Am  " s)))
    (iota 8 8))
  (display "[0m")
  (newline))

(define (spect-colour-cube)
  (newline)
  (print "Colour cube, 6x6x6:")
  (let ((ls (iota 6)))
    (for-each
      (lambda (g)
        (for-each
          (lambda (r)
            (for-each
              (lambda (b)
                (display (format "[48;5;~Am  " (+ 16 (* r 36) (* g 6) b))))
              ls)
            (display "[0m "))
          ls)
        (newline))
      ls)))

(define (spect-grayscale-colours)
  (print "Grayscale ramp")
  (for-each
    (lambda (s)
      (display
        (format "[48;5;~Am  " s)))
    (let loop ((ls 232))
      (when (< ls 256)
        (cons ls (loop (+ ls 1))))
      ))
  (display "[0m")
  (newline))

(define (colour-spect)
  (spect-system-colours)
  (spect-colour-cube)
  (spect-grayscale-colours))


(define (colour-square)
  (newline)
  (dotimes (i 7)
    (display " ")
    (for-each
      (lambda (s)
        (display
          (format "[48;5;~Am     " s))
        (display "[0m "))
      (iota 8))
    (newline)) 
  (print "[0m")
  (dotimes (i 7)
    (display " ")
    (for-each
      (lambda (s)
        (display
          (format "[48;5;~Am     " s))
        (display "[0m "))
      (iota 8 8))
    (newline)) 
  (print "[0m"))

(define (colour args)
  (match (car args)  
    ("numbers"
     (colour-names))
    ("spect"
     (colour-spect))
    ("pacman"
     (colour-pacman))
    ("square"
     (colour-square))))

