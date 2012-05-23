
(use kirjasto.keskustelu)

(define (main args)
  (read-eval-print-loop
    reader
    evaluator
    printer
    prompter
    ))
