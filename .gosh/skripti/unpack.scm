#!/usr/bin/env gosh

;;; methods from
;;; cv2tar.scm by
;;;  Walter C. Pelissero

(use gauche.process)
(use file.util) ; path-extension

(define (zip-unpacker file . directory)
  (if (null-list? directory)
    (run-process `(unzip -q ,file) :wait #t)
    (run-process `(unzip -q ,file -d ,(caar directory)) :wait #t)))


(define (rar-unpacker file . diretory)
  (run-process `(unrar x -ad ,file) :wait #t))

(define (lha-unpacker file . diretory)
  (run-process `(lha xq ,file) :wait #t))

(define (tar-unpacker file . directory)
  (cond ((null-list? directory)
    (run-process `(tar xf ,file) :wait #t))
    (else
      (make-directory* (caar directory))
    (run-process `(tar xf ,file -C ,(caar directory)) :wait #t))
    ))

(define (sevenzip-unpacker file . directory)
  (if (null-list? directory )
    (run-process `(7z x ,file) :wait #t)
    (run-process `(7z x ,file -o ,(car directory)) :wait #t)
    ))

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
    ("tar" ,tar-unpacker)
    ))

(define (unpack file . directory)
  (let ((unpacker (assoc (path-extension file)
                         *unpacker-alist*)))
    (print file)

    (if unpacker
      (if directory
        ((cadr unpacker) file directory)
        ((cadr unpacker) file))
      (error "unknown file type" file))))

(define (main args)
  (if (< 2 (length args))
    (unpack (cadr args) (caddr args))
    (unpack (cadr args))
    )
  )
