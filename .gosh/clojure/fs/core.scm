
(define-module clojure.fs.core

  (use srfi-11)
  (use util.list)
  (use file.util)
  (export
    temp-name
    temp-create
    temp-file
    temp-dir
    with-cwd
    absolute-path
    parent
    file
    copy
    copy+
    ))
(select-module clojure.fs.core)



(define (temp-name prefix . suffix)
  (cond
    ((null? suffix) (temp-name prefix ""))
    (else   (format "~a~a-~a~a" prefix (sys-time)
                    (sys-random) (car suffix)))))

(define (temp-create prefix suffix fproc)
  (let ((tmp (build-path (temporary-directory)
                         (temp-name prefix suffix))))
    (when (fproc tmp)
      tmp)))

(define (temp-file prefix . suffix)
  (cond
    ((null? suffix) (temp-file prefix ""))
    (else (temp-create prefix (car suffix) touch-file))))

(define (temp-dir prefix . suffix)
  (cond
    ((null? suffix) (temp-dir prefix ""))
    (else           (temp-create prefix suffix make-directory*))))
;
(define-macro (with-cwd dir . body)
  `(let ((cur (current-directory))
         (dest ,dir))
     (current-directory dest)
     ,@body
     (current-directory cur)))

(define (absolute-path path)
  (sys-normalize-pathname path :absolute #t :canonicalize #t)
  )

(define (file path)
  (absolute-path path))

(define (parent path)
  "Return the parent path."
  (sys-dirname (absolute-path path)))

(define (copy from to)
  "Copy a file from 'from' to 'to'. Return 'to'."
  (copy-file (file from) (file to) :if-exists :error )
  to)

(define (copy+ src dest)
  "Copy src to dest, create directories if needed."
  (make-directory* (parent dest))
  (copy src dest))

