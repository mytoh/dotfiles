;; -*- coding: utf-8 -*-

(define-module kirjasto.työkalu
  (use text.tr)
  (use gauche.net)
  (use gauche.process)
  (use gauche.sequence)
  (use file.util)
  (use rfc.http)
  (use rfc.uri)
  (require-extension
    (srfi 11 13))
  (use kirjasto.merkkijono)
  (export
    loop-forever
    get-os-type
    tap
    p
    daemonize
    nothing
    from
    ))

(select-module kirjasto.työkalu)



(define-syntax loop-forever
  ;;macro for endless loop
  (syntax-rules ()
    ((_ body ...)
     (let loop () 
       body
       ...
       (sys-sleep #e3e1) ; sleep 
       (loop)))))

(define get-os-type
  ; returns symbol
  (lambda ()
    (string->symbol (string-downcase
                      (car (sys-uname))))))


(define (tap f x)
  (f x) x)

(define (p x)
  (display x)
  (newline)
  x)

(define (daemonize)
  ;;make daemon process, function from gauche cookbook
  (proc)
  (when (positive? (sys-fork))
    (sys-exit 0))
  (sys-setsid)
  (sys-chdir "/")
  (sys-umask 0)
  (call-with-input-file "/dev/null"
                        (cut port-fd-dup! (standard-input-port) <>))
  (call-with-output-file "/dev/null"
                         (lambda (out)
                           (port-fd-dup! (standard-output-port) out)
                           (port-fd-dup! (standard-error-port) out))))


(define nothing
  (lambda ()
    (values)))






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; http://rosettacode.org/wiki/Y_combinator#Scheme
(define Y
  (lambda (f)
    ((lambda (x) (x x))
     (lambda (g)
       (f (lambda args (apply (g g) args)))))))

(define fac
  (Y
    (lambda (f)
      (lambda (x)
        (if (< x 2)
          1
          (* x (f (- x 1))))))))

(define fib
  (Y
    (lambda (f)
      (lambda (x)
        (if (< x 2)
          x
          (+ (f (- x 1)) (f (- x 2))))))))


