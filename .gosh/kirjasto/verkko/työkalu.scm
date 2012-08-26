
(define-module kirjasto.verkko.työkalu
  (export
    string-is-url?)
  )
(select-module kirjasto.verkko.työkalu)


(define (string-is-url? str)
  (or ( #/^https?:\/\// str)
    ( #/^http:\/\// str)))
