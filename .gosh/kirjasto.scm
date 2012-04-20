(define-module kirjasto
  (use text.tr)
  (use gauche.net)
  (use gauche.process)
  (use file.util)
  (use rfc.http)
  (use rfc.uri)
  (use text.tree)
  (extend kirjasto.komento)

  (export
    string->lowercase
    make-colour
    forever
    get-os-type
    tap
    p
    daemonize
    run-command
    run-commands
    run-command-sudo
    colour-command
    whitespace->dash
    whitespace->underbar
    swget
    port->incomplete-string
    )

  )

(select-module kirjasto)

(define string->lowercase
  (let1 ptr (build-transliterator "A-Z" "a-z")
    (lambda (str)
      (with-string-io str ptr))))

(define (make-colour colour-number str)
  ;; take any -> return string
  (tree->string `("[38;5;" ,(x->string colour-number) "m" ,(x->string str) "[0m"))
  )


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



(define (whitespace->underbar str)
  (regexp-replace-all #/\s+/ str "_"))

(define (whitespace->dash str)
  (regexp-replace-all #/\s+/ str "-"))

(define (run-command command)
  (run-process command :wait #t)
  )

(define-syntax run-commands
  ; run processes
  (syntax-rules ()
    ((_ c1 )
     (run-process c1 :wait #t)
     )
    ((_ c1 c2 ...)
     (begin
       (run-process c1 :wait #t)
       (run-commands c2 ...)))))


(define (run-command-sudo command)
  (run-process (append '(sudo) command) :wait #t)
  )

(define-syntax colour-command
  (syntax-rules ()
    ((_ command r1 s1 ...)
     (with-input-from-process
       command
       (lambda ()
         (port-for-each
           (lambda (in)
             (print
               (regexp-replace* in
                                r1 s1
                                ...
                                ; example:
                                ; #/^>>>/   "[38;5;99m\\0[0m"
                                ; #/^=*>/   "[38;5;39m\\0[0m"
                                )))
                                read-line))))
    ))


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

(provide "kirjasto")
