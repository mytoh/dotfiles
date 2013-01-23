 ;;; -*- coding: utf-8; lexical-binding: t -*-
;;; faces
(progn

  ;; colour theme
  (load-theme 'molokai t)

  ;; font
  (cond (window-system
         (set-default-font "Neep-9")
         (set-fontset-font (frame-parameter nil 'font)
                           'japanese-jisx0208
                           '("IPAGothic" . "unicode-bmp"))))

  ;; (create-fontset-from-ascii-font "Neep Alt-9:weight=normal:slant=normal" nil "myfont")
  ;; (set-fontset-font "fontset-myfont"
  ;;                   'unicode
  ;;                   (font-spec :family "mplus_j10r" :size 10)
  ;;                   nil
  ;;                   'append)
  ;; (set-fontset-font "fontset-myfont"
  ;;                   'japanese-jisx0208
  ;;                   "-alias-fixed-medium-r-normal--10-*-75-75-c-100-jisx0208.1983-0"
  ;; ;                   "-mplus-gothic-medium-r-normal--10-*-jisx0208.1990-0"
  ;; ;                  (font-spec :family "mplus_j10r" :size 10)
  ;;                   nil
  ;;                   'append)
  ;; (set-fontset-font "fontset-myfont"
  ;;                   'katakana-jisx0201
  ;;                   "-alias-fixed-medium-r-normal--10-*-75-75-c-100-jisx0201.1976-0"
  ;; ;                 "-mplus-gothic-medium-r-normal--10-*-jisx0201.1976-0"
  ;; ;                  (font-spec :family "mplus_j10r" :size 10)
  ;;                   nil
  ;;                   'append)


  ;; (add-to-list 'default-frame-alist '(font . "fontset-myfont"))

  ;;   (setq-default frame-background-mode 'dark)
  ;;   (my-set-face-colours 'default "#d0d0d0" "#141414")
  ;;   (my-set-face-colours 'highlight nil "gray11")
  ;;   (my-set-face-colours 'mode-line-buffer-id "linen" "gray15")
  ;;   (my-set-face-colours 'font-lock-comment-face "gray35" nil)
  ;;   (my-set-face-colours 'region nil "dark slate blue")
  ;;   (set-cursor-color  "white")
  ;;   (set-mouse-color "blue" )

  ;;   (set-face-attribute 'font-lock-comment-face  t :foreground "gray40")
  ;;   (set-face-attribute 'font-lock-constant-face t :foreground "#E9874A")
  ;;   (set-face-attribute 'font-lock-builtin-face  t :foreground "#a0a486")
  ;;   (set-face-attribute 'font-lock-function-name-face t :foreground "#FFAD63")
  ;;   (set-face-attribute 'font-lock-variable-name-face t :foreground "#6E7A4B")
  ;;   (set-face-attribute 'font-lock-keyword-face t :foreground "#C4503B")
  ;;   (set-face-attribute 'font-lock-string-face t :foreground "RosyBrown" )
  ;;   (set-face-attribute 'font-lock-doc-face t :foreground "#6E6664")
  ;;   (set-face-attribute 'font-lock-negation-char-face t :foreground "#6E6664")
  ;;   (set-face-attribute 'font-lock-preprocessor-face t :foreground "#6E6664")


  ;;   ;; transparent
  ;;   ;; http://www.emacswiki.org/emacs/TransparentEmacs
  ;;   (set-frame-parameter (selected-frame) 'alpha '(85 50))
  ;;   (add-to-list 'default-frame-alist '(alpha 85 50))

  )

;;(load-theme 'sanityinc-solarized-dark t)


(provide 'my-init-face)
