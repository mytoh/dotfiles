
(use text.tr)

(define string->lowercase
  (let1 ptr (build-transliterator "A-Z" "a-z")
        (lambda (str)
          (with-string-io str ptr))))

(define (make-colour colour str)
    (string-append "[38;5;" (x->string colour) "m" str "[0m"))
