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
  '(
    (number . 13)
    (list   . 11)
    (string . 63)
    (true   . 4)
    (false  . 1)
    ))

;; reader
(define reader
  #f)

;; evaluator
(define evaluator
  #t)

;; printer
(define printer-colourize
  (lambda (result)
    (let ((make-colour (lambda (assoc-key str)
                    (colour-string
                      (assoc-ref *colours* assoc-key)
                      (x->string  str)))))
    (cond
      ;; list
      ((list? result)
       (make-colour 'list  result))
      ;; string
      ((string? result)
       (make-colour 'string result))
      ;; number
      ((number? result)
       (make-colour  'number  result))
      ;; boolean
      ((is-a? result <boolean>)
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
           (display "=> " )

           (display
             (printer-colourize r))

           (newline))
         results)))

;; prompter
(define prompter
  (lambda ()
    (display (colour-string 33 "> "))
    (flush)))
