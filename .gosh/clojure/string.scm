
(define-module clojure.string
  (export
    str join
    ))
(select-module clojure.string)

; (define (str . strings)
;   (let ((s (map (lambda (x) (if (null? x) "" (x->string x)))
;                 strings)))
;     (let loop ((st (car s))
;                (ss (cdr s)))
;       (if (null? ss)
;         st
;         (loop (string-append st (car ss)) (cdr ss))))))

(define (str st . xst)
  (fold (^ (x xs)
          (string-append (x->string xs) (x->string x)))
        st xst))

(define (join sep slist)
  (string-join slist sep))
