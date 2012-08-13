
(define-module pikkukivi.radio
  (export
    radio)
  (use gauche.process)
  (use util.list) ; slices
  (use util.match)
  (use file.util)
  (require-extension (srfi 1 13))    ; iota
  (use kirjasto.merkkijono)
  (use kirjasto.väri))
(select-module pikkukivi.radio)

(define station-list
  '((bbc1 "bbc radio 1" http://www.bbc.co.uk/radio/listen/live/r1.asx)
    (bbc2 "bbc radio 2" http://www.bbc.co.uk/radio/listen/live/r2.asx)
    (bbc3 "bbc radio 3" http://www.bbc.co.uk/radio/listen/live/r3.asx)
    (bbc4 "bbc radio 4" http://www.bbc.co.uk/radio/listen/live/r4.asx)
    (bbc6 "bbc radio 6" http://www.bbc.co.uk/radio/listen/live/r6.asx)
    (nhkr1 "NHK第一" http://mfile.akamai.com/129931/live/reflector:46032.asx)
    (nhkr2   "NHK第二" http://mfile.akamai.com/129932/live/reflector:46056.asx)
    (nhkfm  "NHK-FM" http://mfile.akamai.com/129933/live/reflector:46051.asx)
    ))

(define (listen args)
  (run-process `(mplayer -playlist ,(cadr (assoc-ref station-list (string->symbol (car args)))))) )

(define (list-stations)
  (let loop ((st station-list))  
    (cond
      ((null? st)  
       '())  
      (else
        (print
          (string-append (symbol->string (car (car st)))  
                         ": "
                         (cadr (car st))))
        (loop (cdr st))))))

(define (radio args)
  (match (car args)
    ("listen"
     (listen (cdr args)))
    ("list"
     (list-stations))))
