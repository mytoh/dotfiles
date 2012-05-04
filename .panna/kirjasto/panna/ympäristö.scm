(define-module panna.ympäristö
(use gauche.parameter)
(use file.util)
(export
  kaava-kansio

  ))
(select-module panna.ympäristö)


(define-constant kaava-kansio
  (build-path (sys-getenv "OLUTPANIMO")
              "kirjasto"
              "kaava"))


(provide "panna/ympäristö")
