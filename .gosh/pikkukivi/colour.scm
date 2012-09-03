
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


(define (colour-numbers)
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
(define f1    "[38;5;1m")
(define f2  "[38;5;2m")
(define f3 "[38;5;3m")
(define f4   "[38;5;4m")
(define f5 "[38;5;5m")
(define f6   "[38;5;6m")
(define f7  "[38;5;7m")

(define rst "[0m")
(define bld "[1m")

(define (colour-pacman)
  (print
    #`"
    ,|f3|  ▄███████▄,rst   ,|f1|  ▄██████▄,rst    ,|f2|  ▄██████▄,rst    ,|f4|  ▄██████▄,rst    ,|f5|  ▄██████▄,rst    ,|f6|  ▄██████▄,rst
    ,|f3|▄█████████▀▀,rst  ,|f1|▄,|f7|█▀█,|f1|██,|f7|█▀█,|f1|██▄,rst  ,|f2|▄,|f7|█▀█,|f2|██,|f7|█▀█,|f2|██▄,rst  ,|f4|▄,|f7|█▀█,|f4|██,|f7|█▀█,|f4|██▄,rst  ,|f5|▄,|f7|█▀█,|f5|██,|f7|█▀█,|f5|██▄,rst  ,|f6|▄,|f7|█▀█,|f6|██,|f7|█▀█,|f6|██▄,rst
    ,|f3|███████▀,rst      ,|f1|█,|f7|▄▄█,|f1|██,|f7|▄▄█,|f1|███,rst  ,|f2|█,|f7|▄▄█,|f2|██,|f7|▄▄█,|f2|███,rst  ,|f4|█,|f7|▄▄█,|f4|██,|f7|▄▄█,|f4|███,rst  ,|f5|█,|f7|▄▄█,|f5|██,|f7|▄▄█,|f5|███,rst  ,|f6|█,|f7|▄▄█,|f6|██,|f7|▄▄█,|f6|███,rst
    ,|f3|███████▄,rst      ,|f1|████████████,rst  ,|f2|████████████,rst  ,|f4|████████████,rst  ,|f5|████████████,rst  ,|f6|████████████,rst
    ,|f3|▀█████████▄▄,rst  ,|f1|██▀██▀▀██▀██,rst  ,|f2|██▀██▀▀██▀██,rst  ,|f4|██▀██▀▀██▀██,rst  ,|f5|██▀██▀▀██▀██,rst  ,|f6|██▀██▀▀██▀██,rst
    ,|f3|  ▀███████▀,rst   ,|f1|▀   ▀  ▀   ▀,rst  ,|f2|▀   ▀  ▀   ▀,rst  ,|f4|▀   ▀  ▀   ▀,rst  ,|f5|▀   ▀  ▀   ▀,rst  ,|f6|▀   ▀  ▀   ▀,rst
    ,bld
    ,|f3|  ▄███████▄   ,|f1|  ▄██████▄    ,|f2|  ▄██████▄    ,|f4|  ▄██████▄    ,|f5|  ▄██████▄    ,|f6|  ▄██████▄,rst
    ,bld,|f3|▄█████████▀▀  ,|f1|▄,|f7|█▀█,|f1|██,|f7|█▀█,|f1|██▄  ,|f2|▄,|f7|█▀█,|f2|██,|f7|█▀█,|f2|██▄  ,|f4|▄,|f7|█▀█,|f4|██,|f7|█▀█,|f4|██▄  ,|f5|▄,|f7|█▀█,|f5|██,|f7|█▀█,|f5|██▄  ,|f6|▄,|f7|█▀█,|f6|██,|f7|█▀█,|f6|██▄,rst
    ,bld,|f3|███████▀      ,|f1|█,|f7|▄▄█,|f1|██,|f7|▄▄█,|f1|███  ,|f2|█,|f7|▄▄█,|f2|██,|f7|▄▄█,|f2|███  ,|f4|█,|f7|▄▄█,|f4|██,|f7|▄▄█,|f4|███  ,|f5|█,|f7|▄▄█,|f5|██,|f7|▄▄█,|f5|███  ,|f6|█,|f7|▄▄█,|f6|██,|f7|▄▄█,|f6|███,rst
    ,bld,|f3|███████▄      ,|f1|████████████  ,|f2|████████████  ,|f4|████████████  ,|f5|████████████  ,|f6|████████████,rst
    ,bld,|f3|▀█████████▄▄  ,|f1|██▀██▀▀██▀██  ,|f2|██▀██▀▀██▀██  ,|f4|██▀██▀▀██▀██  ,|f5|██▀██▀▀██▀██  ,|f6|██▀██▀▀██▀██,rst
    ,bld,|f3|  ▀███████▀   ,|f1|▀   ▀  ▀   ▀  ,|f2|▀   ▀  ▀   ▀  ,|f4|▀   ▀  ▀   ▀  ,|f5|▀   ▀  ▀   ▀  ,|f6|▀   ▀  ▀   ▀,rst
    "
    ))

(define (colour-invaders)
  (print
#`"
   ,|bld|,|f1|▀▄   ▄▀  ,|rst|    ,|bld|,|f2|▄▄▄████▄▄▄ ,|rst|   ,|bld|,|f3|  ▄██▄  ,|rst|     ,|bld|,|f4|▀▄   ▄▀  ,|rst|    ,|bld|,|f5|▄▄▄████▄▄▄ ,|rst|   ,|bld|,|f6|  ▄██▄  ,|rst|
  ,|bld|,|f1|▄█▀███▀█▄ ,|rst|   ,|bld|,|f2|███▀▀██▀▀███,|rst|   ,|bld|,|f3|▄█▀██▀█▄,|rst|    ,|bld|,|f4|▄█▀███▀█▄ ,|rst|   ,|bld|,|f5|███▀▀██▀▀███,|rst|   ,|bld|,|f6|▄█▀██▀█▄,|rst|
 ,|bld|,|f1|█▀███████▀█,|rst|   ,|bld|,|f2|▀▀▀██▀▀██▀▀▀,|rst|   ,|bld|,|f3|▀▀█▀▀█▀▀,|rst|   ,|bld|,|f4|█▀███████▀█,|rst|   ,|bld|,|f5|▀▀▀██▀▀██▀▀▀,|rst|   ,|bld|,|f6|▀▀█▀▀█▀▀,|rst|
 ,|bld|,|f1|▀ ▀▄▄ ▄▄▀ ▀,|rst|   ,|bld|,|f2|▄▄▀▀ ▀▀ ▀▀▄▄,|rst|   ,|bld|,|f3|▄▀▄▀▀▄▀▄,|rst|   ,|bld|,|f4|▀ ▀▄▄ ▄▄▀ ▀,|rst|   ,|bld|,|f5|▄▄▀▀ ▀▀ ▀▀▄▄,|rst|   ,|bld|,|f6|▄▀▄▀▀▄▀▄,|rst|

   ,|f1|▀▄   ▄▀  ,|rst|    ,|f2|▄▄▄████▄▄▄ ,|rst|   ,|f3|  ▄██▄  ,|rst|     ,|f4|▀▄   ▄▀  ,|rst|    ,|f5|▄▄▄████▄▄▄ ,|rst|   ,|f6|  ▄██▄  ,|rst|
  ,|f1|▄█▀███▀█▄ ,|rst|   ,|f2|███▀▀██▀▀███,|rst|   ,|f3|▄█▀██▀█▄,|rst|    ,|f4|▄█▀███▀█▄ ,|rst|   ,|f5|███▀▀██▀▀███,|rst|   ,|f6|▄█▀██▀█▄,|rst|
 ,|f1|█▀███████▀█,|rst|   ,|f2|▀▀▀██▀▀██▀▀▀,|rst|   ,|f3|▀▀█▀▀█▀▀,|rst|   ,|f4|█▀███████▀█,|rst|   ,|f5|▀▀▀██▀▀██▀▀▀,|rst|   ,|f6|▀▀█▀▀█▀▀,|rst|
 ,|f1|▀ ▀▄▄ ▄▄▀ ▀,|rst|   ,|f2|▄▄▀▀ ▀▀ ▀▀▄▄,|rst|   ,|f3|▄▀▄▀▀▄▀▄,|rst|   ,|f4|▀ ▀▄▄ ▄▄▀ ▀,|rst|   ,|f5|▄▄▀▀ ▀▀ ▀▀▄▄,|rst|   ,|f6|▄▀▄▀▀▄▀▄,|rst|


                                     ,|f7|▌,|rst|

                                   ,|f7|▌,|rst|
                                   ,|f7|,|rst|
                                  ,|f7|▄█▄,|rst|
                              ,|f7|▄█████████▄,|rst|
                              ,|f7|▀▀▀▀▀▀▀▀▀▀▀,|rst|

"
    ))

(define (colour-guns)
  (print
#`"
,|f1| ▀▄▄█████████     ,|f2| ▀▄▄███████████  ,|f3| ▀▄▄███████████  ,|f4| ▀▄▄███████████  ,|f5| ▀▄▄███████████  ,|f6| ▀▄▄███████████
,|f1| ▄███▀█▀▀▀        ,|f2| ▄███▀█▀▀▀       ,|f3| ▄███▀█▀▀▀       ,|f4| ▄███▀█▀▀▀       ,|f5| ▄███▀█▀▀▀       ,|f6| ▄███▀█▀▀▀
,|f1|▐███▄▀            ,|f2|▐███▄▀           ,|f3|▐███▄▀           ,|f4|▐███▄▀           ,|f5|▐███▄▀           ,|f6|▐███▄▀
,|f1|▐███              ,|f2|▐███             ,|f3|▐███             ,|f4|▐███             ,|f5|▐███             ,|f6|▐███
,|f1| ▀▀▀              ,|f2| ▀▀▀             ,|f3| ▀▀▀             ,|f4| ▀▀▀             ,|f5| ▀▀▀             ,|f6| ▀▀▀
,|bld|
,|f1|  ▀▄▄███████████  ,|f2| ▀▄▄███████████  ,|f3| ▀▄▄███████████  ,|f4| ▀▄▄███████████  ,|f5| ▀▄▄███████████  ,|f6| ▀▄▄███████████
,|f1| ▄███▀█▀▀▀        ,|f2| ▄███▀█▀▀▀       ,|f3| ▄███▀█▀▀▀       ,|f4| ▄███▀█▀▀▀       ,|f5| ▄███▀█▀▀▀       ,|f6| ▄███▀█▀▀▀
,|f1|▐███▄▀            ,|f2|▐███▄▀           ,|f3|▐███▄▀           ,|f4|▐███▄▀           ,|f5|▐███▄▀           ,|f6|▐███▄▀
,|f1|▐███              ,|f2|▐███             ,|f3|▐███             ,|f4|▐███             ,|f5|▐███             ,|f6|▐███
,|f1| ▀▀▀              ,|f2| ▀▀▀             ,|f3| ▀▀▀             ,|f4| ▀▀▀             ,|f5| ▀▀▀             ,|f6| ▀▀▀
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
     (colour-numbers))
    ("spect"
     (colour-spect))
    ("pacman"
     (colour-pacman))
    ("invaders"
     (colour-invaders))
    ("guns"
     (colour-guns))
    ("square"
     (colour-square))))

