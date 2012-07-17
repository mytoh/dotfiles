#!/usr/bin/env gosh

(use file.util)

;; http://d.hatena.ne.jp/dorayakitaro/20090614/p1

(define (usage)
  (format (current-error-port)
          "Usage:  ~a regexp file ... \n" *program-name*)
  (exit 2))


(define (highlight-matched-text rx matched)
  (regexp-replace 
    rx matched  "[48;5;89m\\0[0m"))

(define (grep-file rx port)
  (with-input-from-port port
                        (lambda ()
                          (port-for-each
                            (lambda (line)
                              (when (rxmatch rx line)
                                (format #t "~a:~a: ~a\n"
                                        (port-name port)
                                        (- (port-current-line port) 1)
                                        (highlight-matched-text rx line))))
                            read-line))))

(define (grep-directory rx path)
  (let ((file-list (directory-fold path cons '()
                                   :lister (lambda (path seed)
                                             (values (directory-list path :add-path? #t :children? #t)
                                                     (cons path seed))))))
    (for-each (lambda (f)
                (call-with-input-file f 
                                      (lambda (p) (grep-file rx p))))
              file-list)))

(define (grep rx file)
  (cond ((file-is-regular?  file)
         (for-each (lambda (f)
                     (call-with-input-file f
                                           (lambda (p) (grep-file rx p))))
                   (list file)))
    ((file-is-directory?  file)
     (grep-directory rx file))))


(define (main args)
  (if (null? (cdr args))
    (usage)
    (let ((rx (string->regexp (cadr args))))
      (if (null? (cddr args))
        (grep-file rx (current-input-port))
        (grep rx (caddr args)))))
  0)
