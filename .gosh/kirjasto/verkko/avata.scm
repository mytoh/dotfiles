(define-module kirjasto.verkko.avata
  (export
    open
    swget)

  (use gauche.net)
  (use rfc.http)
  (use rfc.uri)
  (use file.util)
  (use kirjasto.merkkijono) ; whitespace->dash
  (require-extension
    (srfi 11)))
(select-module kirjasto.verkko.avata)


(define (open uri . options)
  (let-keywords options ((proxy  :proxy  #f)
                         (secure :secure #f)
                         (file   :file   #f)
                         . rest)
    (let-values (((scheme user-info hostname port-number path query fragment)
                  (uri-parse uri)))
      ;; returns html body
      (cond (file (call-with-output-file
                    file
                    (lambda (out)
                      (http-get hostname (or  path "/")
                                :proxy proxy
                                :secure secure
                                :sink out 
                                :flusher (lambda _ #t)))))
        (else
          (values-ref (http-get hostname (or  path "/")
                                :proxy proxy
                                :secure secure)
            2))))))

(define (swget uri)
  (let-values (((scheme user-info hostname port-number path query fragment)
                (uri-parse uri)))
    (let* ((file (receive (a fname ext)
                   (decompose-path (whitespace->dash path))
                   #`",|fname|.,|ext|"))
           (flusher (lambda (s h) (print file) #t)))
      (if (not (file-is-readable? file))
        (call-with-output-file
          file
          (cut http-get hostname path
            :sink <> :flusher flusher))))))

