(define-module chicken.unit.data-structures
  (export
    conc))
(select-module chicken.unit.data-structures)

(define (conc . args)
  (apply string-append (map x->string args)))
