
(define-module pikkukivi.verkko.buk
  (export buk)
  (use pikkukivi.verkko.buk.ningen-ng)
  (use pikkukivi.verkko.buk.ningen-ok)
  (use util.match)
  )
(select-module pikkukivi.verkko.buk)

(define (buk args)
  (match (car args)
    ("ningen-ng"
     (ningen-ng (cdr args)))
    ("ningen-ok"
     (ningen-ok (cdr args)))
    ))
