
(define-module pikkukivi.repl
  (extend gauche.interactive)
  (export
    repl
    )
  (use file.util)
  (use util.list)
  (use util.match)
  (use srfi-1)
  (use gauche.reload)
  (use kirjasto.väri) ; colour-string
  )
(select-module pikkukivi.repl)

;; colours
(define *colours*
  '((number . 13)
    (list   . 11)
    (string . 63)
    (symbol . 163)
    (true   . 4)
    (false  . 1)
    ))

;; reader
(define reader
  #f)

;; evaluator
(define evaluator
  #t)

(define printer-colourize
  (lambda (result)
    (let ((make-colour (lambda (assoc-key s)
                    (colour-string
                      (assoc-ref *colours* assoc-key)
                      (x->string  s)))))
    (match (class-name (class-of result))
      ;; list
      ('<pair>
       (make-colour 'list  result))
      ('<list>
       (make-colour 'list  result))

      ;; symbol
      ('<symbol>
       (make-colour 'symbol  result))

      ;; string
      ('<string>
       (make-colour 'string result))
      ('<char>
       (make-colour 'string result))

      ;; number
      ('<number>
       (make-colour  'number  result))
      ('<integer>
       (make-colour  'number  result))

      ;; boolean
      ('<boolean>
       (cond
         (result
           (make-colour 'true "#t"))
         (else
           (make-colour 'false "#f"))))
      (_ result)))))

(define printer
  (lambda results
    (map (lambda (r)
           (display (colour-string 39 "=> "))

           (display
             (printer-colourize r))

           (newline))
         results)))

;; prompter
(define prompter
  (lambda ()
    (display (colour-string 33 "> "))
    (flush)))


(define (repl args)
  (read-eval-print-loop
    reader
    evaluator
    printer
    prompter
    ))
