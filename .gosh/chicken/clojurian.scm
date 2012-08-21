;; author "Moritz Heidkamp"

(define-module chicken.clojurian
  (export
  doto
  ->
  ->*
  ->>
  ->>*
    ))

(select-module chicken.clojurian)

(define-syntax doto
  (syntax-rules ()
    ((_ x) x)
    ((_ x (fn args ...) ...)
     (let ((val x))
       (fn val args ...)
       ...
       val))))

; (define-syntax ->
;   (syntax-rules ()
;     ((_ x) x)
;     ((_ x (y z ...) rest ...)
;      (-> (y x z ...) rest ...))))
(define-syntax ->
  (syntax-rules ()
    ((_ x (f v) f2 ...)
     (-> (f x v) f2 ...))
    ((_ x f f2 ...)
     (-> (f x) f2 ...))
    ((_ x (f v))
     (-> (f x v)))
    ((_ x f)
     (f x))
    ((_ x) x)
    ))


(define-syntax ->>
  (syntax-rules ()
    ((_ x) x)
    ((_ x (y ...) rest ...)
    (->> (y ... x) rest ...))))

(define-syntax ->*
  (syntax-rules ()
    ((_ x) x)
    ((_ x (y z ...) rest ...)
     (->* (receive args x
            (apply y (append args (list z ...))))
          rest ...))))

(define-syntax ->>*
  (syntax-rules ()
    ((_ x) x)
    ((_ x (y z ...) rest ...)
     (->>* (receive args x
             (apply y (append (list z ...) args)))
           rest ...))))


; -----------------------------------
