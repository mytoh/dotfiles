#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use util.match)
(use text.tree)

 ; set blackf  (tput setaf 0); set redf    (tput setaf 1); set greenf  (tput setaf 2)
 ; set yellowf (tput setaf 3); set bluef   (tput setaf 4); set purplef (tput setaf 5)
 ; set cyanf   (tput setaf 6); set whitef  (tput setaf 7)

(define blackf  "[38;5;0m")
(define redf    "[38;5;1m")
(define greenf  "[38;5;2m")
(define yellowf "[38;5;3m")
(define bluef   "[38;5;4m")
(define purplef "[38;5;5m")
(define cyan   "[38;5;6m")
(define white  "[38;5;7m")

(define reset "[0m")
(define boldon "[1m")

(define (pacman)
  (print 
 #`"
 ,|yellowf|  ▄███████▄,reset   ,|redf|  ▄██████▄,reset    ,|greenf|  ▄██████▄,reset    ,|bluef|  ▄██████▄,reset    ,|purplef|  ▄██████▄,reset    ,|cyan|  ▄██████▄,reset
 ,|yellowf|▄█████████▀▀,reset  ,|redf|▄,|white|█▀█,|redf|██,|white|█▀█,|redf|██▄,reset  ,|greenf|▄,|white|█▀█,|greenf|██,|white|█▀█,|greenf|██▄,reset  ,|bluef|▄,|white|█▀█,|bluef|██,|white|█▀█,|bluef|██▄,reset  ,|purplef|▄,|white|█▀█,|purplef|██,|white|█▀█,|purplef|██▄,reset  ,|cyan|▄,|white|█▀█,|cyan|██,|white|█▀█,|cyan|██▄,reset
 ,|yellowf|███████▀,reset      ,|redf|█,|white|▄▄█,|redf|██,|white|▄▄█,|redf|███,reset  ,|greenf|█,|white|▄▄█,|greenf|██,|white|▄▄█,|greenf|███,reset  ,|bluef|█,|white|▄▄█,|bluef|██,|white|▄▄█,|bluef|███,reset  ,|purplef|█,|white|▄▄█,|purplef|██,|white|▄▄█,|purplef|███,reset  ,|cyan|█,|white|▄▄█,|cyan|██,|white|▄▄█,|cyan|███,reset
 ,|yellowf|███████▄,reset      ,|redf|████████████,reset  ,|greenf|████████████,reset  ,|bluef|████████████,reset  ,|purplef|████████████,reset  ,|cyan|████████████,reset
 ,|yellowf|▀█████████▄▄,reset  ,|redf|██▀██▀▀██▀██,reset  ,|greenf|██▀██▀▀██▀██,reset  ,|bluef|██▀██▀▀██▀██,reset  ,|purplef|██▀██▀▀██▀██,reset  ,|cyan|██▀██▀▀██▀██,reset
 ,|yellowf|  ▀███████▀,reset   ,|redf|▀   ▀  ▀   ▀,reset  ,|greenf|▀   ▀  ▀   ▀,reset  ,|bluef|▀   ▀  ▀   ▀,reset  ,|purplef|▀   ▀  ▀   ▀,reset  ,|cyan|▀   ▀  ▀   ▀,reset
  ,boldon
 ,|yellowf|  ▄███████▄   ,|redf|  ▄██████▄    ,|greenf|  ▄██████▄    ,|bluef|  ▄██████▄    ,|purplef|  ▄██████▄    ,|cyan|  ▄██████▄,reset
 ,boldon,|yellowf|▄█████████▀▀  ,|redf|▄,|white|█▀█,|redf|██,|white|█▀█,|redf|██▄  ,|greenf|▄,|white|█▀█,|greenf|██,|white|█▀█,|greenf|██▄  ,|bluef|▄,|white|█▀█,|bluef|██,|white|█▀█,|bluef|██▄  ,|purplef|▄,|white|█▀█,|purplef|██,|white|█▀█,|purplef|██▄  ,|cyan|▄,|white|█▀█,|cyan|██,|white|█▀█,|cyan|██▄,reset
 ,boldon,|yellowf|███████▀      ,|redf|█,|white|▄▄█,|redf|██,|white|▄▄█,|redf|███  ,|greenf|█,|white|▄▄█,|greenf|██,|white|▄▄█,|greenf|███  ,|bluef|█,|white|▄▄█,|bluef|██,|white|▄▄█,|bluef|███  ,|purplef|█,|white|▄▄█,|purplef|██,|white|▄▄█,|purplef|███  ,|cyan|█,|white|▄▄█,|cyan|██,|white|▄▄█,|cyan|███,reset
 ,boldon,|yellowf|███████▄      ,|redf|████████████  ,|greenf|████████████  ,|bluef|████████████  ,|purplef|████████████  ,|cyan|████████████,reset
 ,boldon,|yellowf|▀█████████▄▄  ,|redf|██▀██▀▀██▀██  ,|greenf|██▀██▀▀██▀██  ,|bluef|██▀██▀▀██▀██  ,|purplef|██▀██▀▀██▀██  ,|cyan|██▀██▀▀██▀██,reset
 ,boldon,|yellowf|  ▀███████▀   ,|redf|▀   ▀  ▀   ▀  ,|greenf|▀   ▀  ▀   ▀  ,|bluef|▀   ▀  ▀   ▀  ,|purplef|▀   ▀  ▀   ▀  ,|cyan|▀   ▀  ▀   ▀,reset
 "
  )
  )




(define (main args)
  (pacman)
  )


