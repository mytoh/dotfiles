
(define-module pikkukivi
  (use gauche.process)
  (use file.util)
  (use util.match)
  (use util.list)
  (use kirjasto.pääte)
  (use kirjasto.työkalu)
  (export pikkukivi)
  (extend
    pikkukivi.talikko
    pikkukivi.unpack
    pikkukivi.repl
    pikkukivi.ls
    pikkukivi.rm
    pikkukivi.emma
    pikkukivi.colour
    pikkukivi.topless
    pikkukivi.ascii-taide
    pikkukivi.verkko
    pikkukivi.scm
    pikkukivi.launch-app
    pikkukivi.print-path
    pikkukivi.piste
    pikkukivi.tmux-start
    pikkukivi.aliases
    ))
(select-module pikkukivi)



(define (run-alias command args)
  (let* ((c (assoc-ref alias-list (string->symbol command)))
         (cmd (if c (car c) #f)))
    (cond
      ((string? cmd)
       (screen-title command)
       (run-process `(,@(string-split cmd " ") ,@args) :wait #t))
      ((procedure? cmd)
       (screen-title command)
       (cmd args))
      (else
        ((eval-string command) args)))))

(define (pikkukivi args)
  (run-alias (car args) (cdr args)))
