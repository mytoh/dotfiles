
(define-module kirjasto.tiedosto
  (use gauche.process)
  (use gauche.sequence)
  (use file.util)
  (use kirjasto.verkko.avata)
  (require-extension
    (srfi 11 13))
  (export
    cat-file
    read-lines-list))
(select-module kirjasto.tiedosto)

(define (cat-file args)
  (cond
    ((list? args)
     (for-each (^ (file)
                 (call-with-input-file file
                   (^ (in)
                     (copy-port in (current-output-port)))))
               args))
    ((string? args)
     (call-with-input-file args
       (^ (in)
         (copy-port in (current-output-port)))))))

(define (read-lines-list filename)
  ;; github.com/chujoii/battery-scheme
  ;; http://newsgroups.derkeiler.com/Archive/Comp/comp.lang.scheme/2008-05/msg00036.html
  (call-with-input-file filename
    (lambda (p)
      (let loop ((line (read-line p))
		 (result '()))
	(if (eof-object? line)
	    (begin (close-input-port p)
		   (reverse result))
	    (loop (read-line p) (cons line result)))))))

