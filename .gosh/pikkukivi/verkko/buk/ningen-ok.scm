

(define-module pikkukivi.verkko.buk.ningen-ok
  (export ningen-ok)
  (use rfc.http)
  (use gauche.charconv)
  (use gauche.collection)
  (use gauche.parseopt)
  (use file.util))
(select-module pikkukivi.verkko.buk.ningen-ok)



(define (cd dir)
  (if (file-is-directory? dir)
    (current-directory dir)))

(define (mkdir dir)
  (if (not (file-exists? dir))
    (make-directory* dir)))

(define (get-thread thread)
  (receive (status head body)
    (http-get "xn--u8jm6cyd8028a.net" (string-append "/12" (http-compose-query "/imgboard.php" `((res ,thread)))))
    (ces-convert body "*jp" "utf-8")))

(define (parse-image line)
  (let ((match
          (rxmatch->string #/src\/(\d+)[^\"]+/ line)))
    (if match
      (string-append "http://xn--u8jm6cyd8028a.net/12/" match)
      #f)))

(define (parse-url url)
  (rxmatch-let (rxmatch #/^http:\/\/([-A-Za-z\d.]+)(:(\d+))?(\/.*)?/ url)
    (#f host #f port path)
    (values host port path)))

(define (swget url)
  (receive (host port path) (parse-url url)
    (let ((file (receive (a fname ext) (decompose-path path) (string-append fname "." ext))))
      (if (not (file-is-readable? file))
        (http-get host path
                  :sink (open-output-file file) :flusher (lambda (s h) (print file) #t))))))

(define (get-image thread)
  (let ((html (get-thread thread)))
    (call-with-input-string html
      (lambda (in)
        (port-for-each
          (lambda  (line)
            (let ((match (parse-image line)))
              (if match
                (swget match))))
          (cut read-line in #t))))))

(define (get-ningen-ok thread)
  (display "[0;34m")
  (print thread)
  (display "[0m")
  (mkdir thread)
  (cd thread)
  (get-image thread)
  (cd ".."))

(define (get-ningen-ok-all)
  (let ((dirs (values-ref (directory-list2 (current-directory) :children? #t) 0)))
    (if (not (null? dirs))
      (for-each
        (lambda (d)
          (get-ningen-ok d))
        dirs)
      (print "no directries"))))


(define (usage )
  (format (current-error-port)
          "Usage: ~a thread \n ex) ~a 8820\n -a|all : get images under current directries" *program-name* "script" )
  (exit 2))

(define (ningen-ok args)
  (let-args args
    ((all "a|all")
     (else (opt . _) (print "Unknown optin: " opt) (usage))
     . restargs)
    (cond
      (all
        (get-ningen-ok-all))
      (else
        (if (null? restargs)
          (usage)
          (get-ningen-ok (car restargs)))))))
