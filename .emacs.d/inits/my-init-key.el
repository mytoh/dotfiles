;;; -*- coding: utf-8; lexical-binding: t -*-

;; no split 
(global-set-key (kbd "C-x C-b") 'buffer-menu)

;; indent
(define-key lisp-interaction-mode-map (kbd "C-m") 'newline-and-indent)
(define-key emacs-lisp-mode-map  (kbd "C-m") 'newline-and-indent)

(provide 'my-init-key)
