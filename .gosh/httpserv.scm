
(use gauche.net)
(use file.util)

(define sock #f)

(define (server-start)
  (make-server-socket 8888 :reuse-addr? #t))

(define (server-accept sock content)
  (let ((soc (socket-accept sock)))
       (while #t
       (socket-send soc (string-append "HTTP/1.1 200 OK\ncontent-type: text/html;\n\n" content))
       (socket-close soc)
       (set! soc (socket-accept sock))
       )))

(define (main arg)
  (let ((server (server-start))
        (file (port->string (open-input-file (string-append (home-directory) "/.site/index.html")))))
       (server-accept server file)))
