
(use text.tr)
(use gauche.net)
(use file.util)
(use rfc.http)
(use rfc.uri)

(define string->lowercase
  (let1 ptr (build-transliterator "A-Z" "a-z")
        (lambda (str)
          (with-string-io str ptr))))

(define (make-colour colour str)
    #`"[38;5;,(x->string colour)m,|str|[0m")


(define-syntax forever
   ;;macro for endless loop
  (syntax-rules ()
    ((_ e1 e2 ...)
     (let loop () e1 e2 ... 
          (sys-nanosleep (* (expt 10 8) 3000)) ; sleep 5 minutes
          (loop)))))


(define get-os-type
  ;;returns symbol
  (lambda ()
   (string->symbol (string->lowercase
    (process-output->string '(uname -s))))))

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
      (port-fd-dup! (standard-error-port) out)))
  )


(define (mkdir dir)
  (if (not (file-exists? dir))
      (make-directory* dir)))

(define (cd dir)
  (if (file-is-directory? dir)
      (current-directory dir)))

(define (whitespace->underbar str)
  (regexp-replace-all #/\s+/ str "_")
  )

(define (whitespace->dash str)
  (regexp-replace-all #/\s+/ str "-")
  )


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
