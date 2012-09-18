
(use gauche.process)
(use gauche.sequence)
(use file.util)

(define system-module-directories (gauche-library-directory))
(define work-directory (current-directory))
(define *output-file* (build-path work-directory "gauche_modules"))

(define *exclude-modules*
  '(gauche-init
     gauche.common-macros
     gauche.let-opt
     gauche.logical
     gauche.matrix
     gauche.numerical
     gauche.redefutil
     gauche.signal
     gauche.singleton
     gauche.serializer.aserializer
     gauche.validator
     os.windows
     srfi-14.query
     srfi-14.set
     slib))

(define *additional-modules*
  '())

(define (sort-modules lst)
  (sort lst
        (lambda (x y)
          (string<? (symbol->string x)
                    (symbol->string y)))))

(define (make-module-list)
  (sort-modules
    (append
      *additional-modules*
      (remove
        (lambda (e) (member e *exclude-modules*))
        (map
          (lambda (path)
            (path->module-name
              (subseq (string-scan path (gauche-library-directory) 'after) 1)))
          (reverse (directory-fold (current-directory)
                                   (lambda (entry result)
                                     (if (equal? (path-extension entry) "scm")
                                       (cons (path-sans-extension entry) result)
                                       result))
                                   '()
                                   :lister (lambda (path seed)
                                             (values (directory-list path :add-path? #t :children? #t)))))))))
  )

(define (main args)
  (current-directory (gauche-library-directory))
  (call-with-output-file
    *output-file*
    (lambda (out)
      (for-each
        (lambda (e)
          (format out "~a\n"  e))
        (make-module-list)))
    :if-does-not-exist :create)
  0)
