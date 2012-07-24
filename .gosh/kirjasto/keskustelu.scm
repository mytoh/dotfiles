(define-module kirjasto.keskustelu
  (extend gauche.interactive)
  (export
    reader
    evaluator
    printer
    prompter
    )
  (use file.util)
  (use util.list)
  (use srfi-1)
  (use gauche.reload)
  (use kirjasto.väri) ; colour-string
  )
(select-module kirjasto.keskustelu)

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
    (let ((make-colour (lambda (assoc-key str)
                    (colour-string
                      (assoc-ref *colours* assoc-key)
                      (x->string  str)))))
    (case (class-name (class-of result))
      ;; list
      ((<pair>)
       (make-colour 'list  result))
      ((<list>)
       (make-colour 'list  result))

      ;; symbol
      ((<symbol>)
       (make-colour 'symbol  result))

      ;; string
      ((<string>)
       (make-colour 'string result))
      ((<char>)
       (make-colour 'string result))

      ;; number
      ((<number>)
       (make-colour  'number  result))
      ((<integer>)
       (make-colour  'number  result))

      ;; boolean
      ((<boolean>)
       (cond
         (result
           (make-colour 'true "#t"))
         (else
           (make-colour 'false "#f"))))
      (else
        result)))))

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
