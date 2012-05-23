
(define-module kirjasto.merkkijono
  (use text.tr)
  (export
    whitespace->dash
    whitespace->underbar
    ))

(select-module kirjasto.merkkijono)


(define (whitespace->underbar str)
  (regexp-replace-all #/\s+/ str "_"))

(define (whitespace->dash str)
  (regexp-replace-all #/\s+/ str "-"))

