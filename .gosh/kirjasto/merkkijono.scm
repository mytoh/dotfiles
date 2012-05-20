
(define-module kirjasto.merkkijono
  (use text.tr)
  (export
    string->lowercase
    whitespace->dash
    whitespace->underbar
    ))

(select-module kirjasto.merkkijono)


(define (whitespace->underbar str)
  (regexp-replace-all #/\s+/ str "_"))

(define (whitespace->dash str)
  (regexp-replace-all #/\s+/ str "-"))

(define string->lowercase
  (let1 ptr (build-transliterator "A-Z" "a-z")
    (lambda (str)
      (with-string-io str ptr))))
