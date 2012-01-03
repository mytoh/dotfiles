
(use gauche.process)
(use gauche.threads)

(define (main args)
      (clear)
      (display " ")
      (cursor 50)
    (for-each
    (lambda (l)
          (begin
            (newline)
           (prompt l)
           (newline)
           ))
    *script*)
    (fin))

(define-constant *script*
  '("YUKI.N>みえてる?"
    " ああ"
    " YUKI.N>そっちの時空間とは
\tまだ完全には連結を絶たれていない。
\tでも時間の問題。
\tそうなれば最後。"
    clear
    " どうすりゃいい?"
    " YUKI.N>どうにもならない。
\t情報統合思念体は失望している。
\tこれで進化の可能性は失なわれた。"
    clear
    " YUKI.N>涼宮ハルヒは
\t何もない所から
\t情報を生み出す力を
\t持っていた。
\tそれは情報統合思念体にも
\tない力。"
       ))

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
  
(define (prompt s)
  (force (nap 5))
  (flush)
  (if (not (string? s))
      (tput s)
      (begin
  (for-each 
   (lambda (c)
     (display  c)
       (flush (standard-output-port))
       (force (nap 1)) ; 0.x seconds
     )
   (string->list s))
  (cursor 20)))
  )

