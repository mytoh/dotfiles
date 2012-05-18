(define-module kirjasto.keitto
  (use rfc.http)
  (use rfc.uri)
  (require-extension
    (srfi 13))

  (export
    find-all-tag
    get-html
    ))

(select-module kirjasto.keitto)

(define find-all-tag
  (lambda (tag html)
    (map
      (lambda (e)
        (if (not (string-null? e))
          (string-append
            "<" tag ">"
            e
            "</" tag ">")))
    (string-split  html
                   (string->regexp
                     (string-append
                       "<\/?(?:"
                       tag
                       ")[^>]*>"))))))

(define (get-html url)
  (let ((parse-url
          (lambda (u)
            (rxmatch-let (rxmatch #/^http:\/\/([-A-Za-z\d.]+)(:(\d+))?(\/.*)?/ u)
                                   (#f h #f #f ph)
                                   (values h (uri-decode-string ph))))))
    (receive (host path) (parse-url url)
      ;; returns html body
             (values-ref (http-get host path)
               2))))
