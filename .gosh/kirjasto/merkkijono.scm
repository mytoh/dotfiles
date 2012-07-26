
(define-module kirjasto.merkkijono
  (use text.tr)
  (use gauche.uvector)
  (require-extension
    (srfi 13))
  (export
    whitespace->dash
    whitespace->underbar
    print-strings
    concat
    port->incomplete-string
    ))

(select-module kirjasto.merkkijono)


(define (whitespace->underbar str)
  (regexp-replace-all #/\s+/ str "_"))

(define (whitespace->dash str)
  (regexp-replace-all #/\s+/ str "-"))

(define print-strings
  (lambda (string-lst)
    (cond
      ((null? string-lst)
       (values))
      (else
        (print (car  string-lst))
        (print-strings (cdr string-lst))))))

(define-syntax concat
  (syntax-rules ()
    ((_ lst)
     (string-concatenate lst))
    ((_ str ...)
     (string-append str ...))))

(define (port->incomplete-string port)
  (let ((strport (open-output-string))
        (u8buf (make-u8vector 4096)))
    (let loop ((len (read-block! u8buf port)))
      (cond ((eof-object? len)
             (get-output-string strport)
             (else
               (write-block u8buf strport 0 len)
               (loop (read-block! u8buf port))))))))

