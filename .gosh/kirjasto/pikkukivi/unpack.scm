
;;; methods from
;;; cv2tar.scm by
;;;  Walter C. Pelissero

(define-module pikkukivi.unpack
  (export unpack)
  (use gauche.process)
  (use file.util) ; path-extension
  )
(select-module pikkukivi.unpack)


(define (zip-unpacker file . directory)
  (if (null? (car directory))
    (run-process `(unzip -q ,file) :wait #t)
    (run-process `(unzip -q ,file -d ,(caar directory)) :wait #t)))


(define (rar-unpacker file . directory)
  (cond ((null? (car directory))
         (run-process `(unrar x -ad ,file) :wait #t))
    (else
      (run-process `(unrar x -ad ,file ,(caar directory)) :wait #t))))

(define (lha-unpacker file . diretory)
  (run-process `(lha xq ,file) :wait #t))

(define (tar-unpacker file . directory)
  (cond ((null? (car directory))
         (run-process `(tar xf ,file) :wait #t))
    (else
      (make-directory* (caar directory))
      (run-process `(tar xf ,file -C ,(caar directory)) :wait #t))))

(define (sevenzip-unpacker file . directory)
  (if (null? (car directory) )
    (run-process `(7z x ,file) :wait #t)
    (run-process `(7z x ,file -o ,(caar directory)) :wait #t)))

(define-constant *unpacker-alist*
  `(
    ("zip" ,zip-unpacker)
    ("cbz" ,zip-unpacker)

    ("7z" ,sevenzip-unpacker)

    ("rar" ,rar-unpacker)
    ("cbr" ,rar-unpacker)

    ("lha" ,lha-unpacker)

    ("gz"  ,tar-unpacker)
    ("tgz" ,tar-unpacker)
    ("bz2" ,tar-unpacker)
    ("xz"  ,tar-unpacker)
    ("txz" ,tar-unpacker)
    ("cbx" ,tar-unpacker)
    ("tar" ,tar-unpacker)))

(define (unpacker file . directory)
  (let ((unpacker (cadr (assoc (path-extension file)
                         *unpacker-alist*))))
    (print file)
    (if unpacker
      (if directory
        (unpacker file directory)
        (unpacker file))
      (error "unknown file type" file))))

(define (unpack args)
  (if (<= 2 (length args))
    (unpacker (car args) (cadr args))
    (unpacker (car args))))
