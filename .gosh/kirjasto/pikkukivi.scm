
(define-module pikkukivi
  (use gauche.process)
  (use file.util)
  (use util.match)
  (export pikkukivi)
  (extend
    pikkukivi.napa
    pikkukivi.talikko
    pikkukivi.pahvi
    pikkukivi.unpack
    pikkukivi.futaba
    pikkukivi.yotsuba
    pikkukivi.repl
    pikkukivi.ls
    pikkukivi.rm
    )
)
(select-module pikkukivi)

(define (pikkukivi args)
  (match (car args)
    ("rm"
     (rm (cdr args)))
    ("napa"
     (napa (cdr args)))
    ("talikko"
     (talikko (cdr args)))
    ("pahvi"
     (pahvi (cdr args)))
    ("unpack"
     (unpack (cdr args)))
    ("repl"
     (repl (cdr args)))
    ("ls"
     (ls (cdr args)))
    ("yotsuba"
     (yotsuba (cdr args)))
    ("futaba"
     (futaba (cdr args))))
  )
