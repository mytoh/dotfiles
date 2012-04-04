#!/usr/bin/env gosh

;;; methods from
;;; cv2tar.scm by
;;;  Walter C. Pelissero

(use gauche.process)
(use file.util) ; path-extension

(define (zip-unpacker file . directory)
  (if directory
  (run-process `(unzip -q ,file -d ,(caar directory)) :wait #t)
  (run-process `(unzip -q ,file) :wait #t))
  )

(define (rar-unpacker file . diretory)
  (run-process `(unrar x -ad ,file) :wait #t))

(define (lha-unpacker file . diretory)
  (run-process `(lha xq ,file) :wait #t))

(define (tar-unpacker file . directory)
  (if directory
  (run-process `(tar xf ,file ,(caar directory)) :wait #t)
  (run-process `(tar xf ,file) :wait #t)
  ))

(define (sevenzip-unpacker file . directory)
  (if directory
  (run-process `(7z x ,file -o ,(caar directory)) :wait #t)
  (run-process `(7z x ,file) :wait #t)
  ))

(define-constant *unpacker-alist*
  `(
    ("zip" ,zip-unpacker)
    ("cbz" ,zip-unpacker)

    ("7z" ,sevenzip-unpacker)

    ("rar" ,rar-unpacker)
    ("cbr" ,rar-unpacker)

    ("lha" ,lha-unpacker)

    ("txz" ,tar-unpacker)
    ("gz" ,tar-unpacker)
    ("tgz" ,tar-unpacker)
    ("bz2" ,tar-unpacker)
    ("xz" ,tar-unpacker)
    ("tar" ,tar-unpacker)))

(define (unpack file . directory)
  (let ((unpacker (assoc (path-extension file)
                         *unpacker-alist*)))
    (if unpacker
      (if directory
        ((cadr unpacker) file directory)
        ((cadr unpacker) file)
        )
      (error "unknown file type" file))))

(define (main args)
  (if (null-list? (cddr args))
  (unpack (cadr args))
  (unpack (cadr args) (caddr args)))
)
