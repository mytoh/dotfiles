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

(define (txz-unpacker file)
  (run-process `(tar xvf ,file) :wait #t))

(define-constant *unpacker-alist*
  `(("zip" ,zip-unpacker)
    ("rar" ,rar-unpacker)
    ("lha" ,lha-unpacker)
    ("txz" ,txz-unpacker)
    )
  )

(define (unpack file)
  (let ((unpacker (assoc (path-extension file)
                         *unpacker-alist*)))
    (if unpacker
        ((cadr unpacker) file)
      (error "unknown file type" file))))

(define (main args)
  (unpack (cadr args))
  )
