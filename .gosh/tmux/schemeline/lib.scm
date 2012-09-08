
(define-module tmux.schemeline.lib
  (export
    <left-segment>
    *left-segments*
    make-segment
    )
  (use gauche.process))
(select-module tmux.schemeline.lib)

(define-class <segment> ()
  ((function :init-value values :init-keyword :function)
   (foreground :init-value "colour29" :init-keyword :foreground)
   (background :init-value "colour222" :init-keyword :background)
   (separator :init-value "" :init-keyword :separator)))

(define-class <left-segment> (<segment>)
  ())

(define *left-segments* '())

(define-method initialize ((self <left-segment>) initargs)
  (next-method)
  (push! *left-segments* self))


(define (make-segment fg bg seg)
  (string-append
    "#[fg=colour" fg ",bg=colour" bg "]"
    " "
    (seg)
    " "
    "#[default]"))
