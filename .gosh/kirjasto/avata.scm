(define-module kirjasto.avata
  (export
    open
    )

  (use gauche.net)
  (use rfc.http)
  (use rfc.uri)
  (require-extension
    (srfi 11)))
(select-module kirjasto.avata)


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
          2)
        ))))
