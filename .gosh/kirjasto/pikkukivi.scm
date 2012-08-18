
(define-module pikkukivi
  (use gauche.process)
  (use file.util)
  (use util.match)
  (use util.list)
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
    pikkukivi.emma
    pikkukivi.colour
    pikkukivi.topless
    pikkukivi.ääliö
    pikkukivi.radio
    ))
(select-module pikkukivi)

(define alias-list
  `(("talikko" ,talikko)
    ("rm"      ,rm)
    ("napa"    ,napa)
    ("pahvi"   ,pahvi)
    ("unpack"  ,unpack)
    ("repl"    ,repl)
    ("ls"     ,ls)
    ("yotsuba" ,yotsuba)
    ("futaba"  ,futaba)
    ("emma"    ,emma)
    ("ääliö"   ,ääliö)
    ("colour"  ,colour)
    ("topless" ,topless)
    ("radio"   ,radio)
    ("mkd"     "mkdir -p")
    ("gsp"     "gosh -ptime")
    ("tm"      "gosh tmux-start.scm")
    ))

(define (run command args)
  (let* ((c (assoc-ref alias-list command))
         (cmd (if c (car c) #f)))
    (cond
      ((string? cmd)
       (run-process `(,@(string-split cmd " ") ,@args) :wait #t))
      ((procedure? cmd)
       (cmd args))
      (else
        (print "alias not found"))
      )))

(define (pikkukivi args)
  (run (car args) (cdr args)))

; (define (pikkukivi args)
;   (match (car args)
;     ("rm"
;      (rm (cdr args)))
;     ("napa"
;      (napa (cdr args)))
;     ("talikko"
;      (talikko (cdr args)))
;     ("pahvi"
;      (pahvi (cdr args)))
;     ("unpack"
;      (unpack (cdr args)))
;     ("repl"
;      (repl (cdr args)))
;     ("ls"
;      (ls (cdr args)))
;     ("yotsuba"
;      (yotsuba (cdr args)))
;     ("futaba"
;      (futaba (cdr args)))
;     ("emma"
;      (emma (cdr args)))
;     ("ääliö"
;      (ääliö (cdr args)))
;     ("colour"
;      (colour (cdr args)))
;     ("topless"
;      (topless (cdr args)))
;     ("radio"
;      (radio (cdr args)))
;     (_
;       (print "no matching command"))) )
