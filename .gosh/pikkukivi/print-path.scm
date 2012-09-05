
(define-module pikkukivi.print-path
  (export
    print-path)
  (use gauche.process)
  (use util.list) ; slices
  (use util.match)
  (use file.util)
  (use gauche.sequence)
  (use kirjasto.tiedosto)
  (use kirjasto.väri))
(select-module pikkukivi.print-path)


(define (print-path args)
  (match args
    ((env)
     (print env)
     (cond
       ((sys-getenv env)
        (for-each print
                  (string-split (sys-getenv env)
                                ":")))
       (else env)))
    (_
      (for-each print
                (string-split (sys-getenv "PATH") ":")))))
