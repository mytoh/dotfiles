
(use text.tr)

(define string->lowercase
  (let1 ptr (build-transliterator "A-Z" "a-z")
        (lambda (str)
          (with-string-io str ptr))))

(define (make-colour colour str)
    #`"[38;5;,(x->string colour)m,|str|[0m")


(define-syntax forever 
   #;"macro for endless loop"
  (syntax-rules ()
    ((_ e1 e2 ...)
     (let loop () e1 e2 ... 
          (sys-nanosleep (* (expt 10 8) 3000)) ; sleep 5 minutes
          (loop)))))


(define get-os-type
  #;"returns symbol"
  (lambda ()
   (string->symbol (string->lowercase
    (process-output->string '(uname -s))))))

(define (tap f x)
  (f x) x)

(define (p x)
  (display x) 
  (newline)
  x)
