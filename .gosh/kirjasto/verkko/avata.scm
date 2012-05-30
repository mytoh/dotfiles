(define-module kirjasto.verkko.avata
  (export
    open
    swget
    )

  (use gauche.net)
  (use rfc.http)
  (use rfc.uri)
  (use file.util)
  (use kirjasto.merkkijono) ; whitespace->dash
  (require-extension
    (srfi 11)))
(select-module kirjasto.verkko.avata)


(define (open uri)
  (let-values (((scheme user-info hostname port-number path query fragment)
                        (uri-parse uri)))
    ;; returns html body
    (cond
      (path
        (values-ref (http-get hostname path)
          2))
      (else
        (values-ref (http-get hostname "/")
          2)))))

(define (swget uri)
  (let-values (((scheme user-info hostname port-number path query fragment)
                        (uri-parse uri)))
      (let* ((file (receive (a fname ext)
                    (decompose-path (whitespace->dash path))
                    #`",|fname|.,|ext|"))
            (flusher (lambda (s h) (print file) #t)))
        (if (not (file-is-readable? file))
          (http-get hostname path
                    :sink (open-output-file file) :flusher flusher)))))

