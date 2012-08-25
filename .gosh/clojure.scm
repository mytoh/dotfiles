(define-module clojure
  (use kirjasto.verkko.avata)
  (use srfi-11)
  (use util.list)
  (use file.util)
  (extend clojure.fs)
  (export
    if-not
    str
    condp
    comment
    slurp
    spit))
(select-module clojure)


(define (slurp file)
  (cond
    ((file-exists? file)
     (file->string file))
    ((string-is-url? file)
     (open file))
    (else
      (print "file not exists"))))

(define (spit file string :key (append? #f))
  (cond
    (append?
      (call-with-output-file file
        (^ (in)
          (display string in))
        :if-exists :append))
    (else
      (call-with-output-file file
        (^ (in)
          (display string in))))))

(define-syntax comment
  (syntax-rules ()
    ( (_ x ...)
     (values))))


;; not full implementation
(define-syntax condp
  (syntax-rules ()
    ((_ pred expr 
         (test-expr result-expr)
         ...)
     (or
       (if (pred test-expr expr)
         result-expr
         #f)
       ...))))

(define-syntax if-not
  (syntax-rules ()
    ((_ test then)
     (if-not test then #f))
    ((_ test then else)
     (if (not test) then else))))
