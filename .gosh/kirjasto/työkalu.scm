
(define-module kirjasto.työkalu
  (use text.tr)
  (use gauche.net)
  (use gauche.process)
  (use file.util)
  (use rfc.http)
  (use rfc.uri)
  (use kirjasto.merkkijono)
  (require-extension
    (srfi 13))
  (export
    forever
    get-os-type
    tap
    p
    daemonize
    swget
    port->incomplete-string))

(select-module kirjasto.työkalu)



(define-syntax forever
  ;;macro for endless loop
  (syntax-rules ()
    ((_ e1 e2 ...)
     (let loop () e1 e2 ...
       (sys-sleep 300) ; sleep 5 minutes
       (loop)))))

(define get-os-type
  ; returns symbol
  (lambda ()
    (string->symbol (string->lowercase
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






(define (swget url)
  (let ((parse-url
          (lambda (u) (rxmatch-let (rxmatch #/^http:\/\/([-A-Za-z\d.]+)(:(\d+))?(\/.*)?/ u)
                        (#f h #f pt ph)
                        (values h pt (uri-decode-string ph))))))
    (receive (host port path) (parse-url url)
      (let ((file (receive (a fname ext) (decompose-path (whitespace->dash path)) #`",|fname|.,|ext|")))
        (if (not (file-is-readable? file))
          (http-get host path
                    :sink (open-output-file file) :flusher (lambda (s h) (print file) #t)))))))

(define (port->incomplete-string port)
  (let ((strport (open-output-string))
        (u8buf (make-u8vector 4096)))
    (let loop ((len (read-block! u8buf port)))
      (cond ((eof-object? len)
             (get-output-string strport)
             (else
               (write-block u8buf strport 0 len)
               (loop (read-block! u8buf port))))))))
