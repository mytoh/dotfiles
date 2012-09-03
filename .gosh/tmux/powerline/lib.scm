
(define-module tmux.powerline.lib
  (export
    <left-segment>
    *left-segments*
    print-left-status
    )
  (use gauche.process))
(select-module tmux.powerline.lib)

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


(define-method print-segment ((self <left-segment>))
  (format #f "#[fg=~a,bg=~a]~a~a#[default]"
                    (ref self 'foreground)
                    (ref self 'background)
                    ((ref self 'function))
                    (ref self 'separator)))


(define (print-left-status)
  (display
  (print-segment (car *left-segments*)))
  )

