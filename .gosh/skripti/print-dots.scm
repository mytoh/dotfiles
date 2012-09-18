
(use kirjasto)
(use kirjasto.pääte)
(use text.tree)
(use srfi-1)
(use gauche.sequence) ; map-with-index


(define dot "·")
(define colour-dot (colour-string 196 dot))
(define dot-list  (make-list 100 dot))
(define interval 1)
(define (replace-list-elements lst num rep)
  `(,@(make-list num rep)
     ,@(drop lst num))
  )


(define (main args)
  (tput-cursor-invisible)
 (print-repeat
   (map
              (lambda (i) (tree->string (replace-list-elements dot-list i colour-dot)))
              (iota (+ (length dot-list) 1)))
   (list interval 0))
  (tput-cursor-normal)

  )
