(define-module kirjasto.komento
  (use gauche.process)
  (use file.util)
  (extend
    kirjasto.komento.työkalu
    kirjasto.komento.napa
    kirjasto.komento.talikko
    kirjasto.komento.pahvi
    kirjasto.komento.rm)
)

(select-module kirjasto.komento)

