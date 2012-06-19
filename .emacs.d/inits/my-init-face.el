;;; faces
(progn

;; font
(set-face-attribute 'default nil :family "Ricty" :height 100)
(set-fontset-font "fontset-default" 'japanese-jisx0208 '("Ricty" . "iso-10646-*" ) )

(my-set-face-colours 'default "#d0d0d0" "gray7")
(my-set-face-colours 'highlight "white" "gray11")
(my-set-face-colours 'modeline "white"  "gray30")
(my-set-face-colours 'mode-line-buffer-id "linen" "gray15")
(my-set-face-colours 'font-lock-comment-face "gray35" nil)
(my-set-face-colours 'region nil "dark slate blue")
(my-set-face-colours 'cursor "white" nil)

(set-face-attribute 'mode-line t 
:foreground "#030303"
:background "#bdbdbd"
:height 80
:box nil)
(set-face-attribute 'mode-line-inactive t :foreground "#f9f9f9" :background "#666666" :box nil)
;(set-face-attribute 'font-lock-comment-face  t :foreground "#gray12")
(set-face-attribute 'font-lock-constant-face t :foreground "#E9874A")
(set-face-attribute 'font-lock-builtin-face  t :foreground "#a0a486")
(set-face-attribute 'font-lock-function-name-face t :foreground "#FFAD63")
(set-face-attribute 'font-lock-variable-name-face t :foreground "#6E7A4B")
(set-face-attribute 'font-lock-keyword-face t :foreground "#C4503B")
(set-face-attribute 'font-lock-string-face t :foreground "#931F8A" )
;(set-face-attribute 'font-lock-doc-string-face t :foreground "#931F8A")
(set-face-attribute 'font-lock-type-face t :foreground "#6E6664")


;; transparent
;; http://www.emacswiki.org/emacs/TransparentEmacs
(set-frame-parameter (selected-frame) 'alpha '(85 50))
(add-to-list 'default-frame-alist '(alpha 85 50))

)

(provide 'my-init-face)
