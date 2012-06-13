;; -*- coding: utf-8 -*-

(define-module kirjasto.työkalu
  (use text.tr)
  (use gauche.net)
  (use gauche.process)
  (use file.util)
  (use rfc.http)
  (use rfc.uri)
  (require-extension
    (srfi 11 13))
  (use kirjasto.merkkijono)
  (export
    forever
    get-os-type
    tap
    p
    daemonize
    nothing
    ))

(select-module kirjasto.työkalu)



(define-syntax forever
  ;;macro for endless loop
  (syntax-rules ()
    ((_ e1 e2 ...)
     (let loop () e1 e2 ...
       (sys-sleep 200) ; sleep 
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


