
(use gauche.process)
(use gauche.threads)

(define (main args)
     (clear)
      (cursor 50)
    (for-each
    (lambda (l)
      (prompt l)
      (cursor 20)
      (newline))
    *script*)
    (fin))

(define-constant *script*
  '("YUKI.N>みえてる?"
    "ああ"
    "YUKI.N>そちらの時空間とは\n\tまだ"))

(define (tput c)
  (run-process `(tput ,(symbol->string c)) :wait #t))

(define (nap n)
  (lazy (sys-nanosleep (* (expt 10 8) n))))

(define (clear)
  (tput 'clear) ; clear display
  (tput 'civis) ; hide cursor
  )

(define (fin)
  (tput 'sgr0)
  (tput 'cnorm) ; appear cursor
  )

(define (cursor n)
  (tput 'sc) ; save cursor position
  (tput 'blink); set blink attr
  (display "_")
  (flush)
  (force (nap n))
  (flush)
  (tput 'cub1) ;move left cursor
  (tput 'dch1) ;delete one character
  (tput 'sgr0)
)
  
(define (prompt str)
  (force (nap 5))
  (flush)
  (for-each 
   (lambda (c)
     (display  c)
       (flush (standard-output-port))
       (force (nap 2)) ; 0.x seconds
     )
   (string->list str)))

