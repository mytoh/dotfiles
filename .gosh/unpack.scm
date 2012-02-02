#!/usr/bin/env gosh

;;; methods from
;;; cv2tar.scm by
;;;  Walter C. Pelissero

(use gauche.process)
(use file.util) ; path-extension

(define (zip-unpacker file)
  (run-process `(unzip ,file) :wait #t))

(define (rar-unpacker file)
  (run-process `(unrar x -ad ,file) :wait #t))

(define (lha-unpacker file)
  (run-process `(lha xq ,file) :wait #t))

(define (tar-unpacker file)
  (run-process `(tar xvf ,file) :wait #t))

(define (sevenzip-unpacker file)
  (run-process `(7z x ,file) :wait #t))

(define-constant *unpacker-alist*
  `(("zip" ,zip-unpacker)
    ("7z" ,sevenzip-unpacker)
    ("rar" ,rar-unpacker)
    ("lha" ,lha-unpacker)
    ("txz" ,tar-unpacker)
    ("gz" ,tar-unpacker)
    ("tgz" ,tar-unpacker)
    ("bz2" ,tar-unpacker)
    ("xz" ,tar-unpacker)
    ("tar" ,tar-unpacker)))

(define (unpack file)
  (let ((unpacker (assoc (path-extension file)
                         *unpacker-alist*)))
    (if unpacker
        ((cadr unpacker) file)
      (error "unknown file type" file))))

(define (main args)
  (unpack (cadr args))
  )
