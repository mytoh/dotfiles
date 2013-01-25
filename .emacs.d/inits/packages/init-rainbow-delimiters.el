;; rainbow-delimiters
(req 'rainbow-delimiters
    (add-hook 'scheme-mode-hook       'rainbow-delimiters-mode)
  (add-hook 'lisp-mode-hook         'rainbow-delimiters-mode)
  (add-hook 'emacs-lisp-mode-hook   'rainbow-delimiters-mode)
  (set-face-attribute 'rainbow-delimiters-depth-1-face nil :foreground "green")
  (set-face-attribute 'rainbow-delimiters-depth-2-face nil :foreground "dodger blue")
  (set-face-attribute 'rainbow-delimiters-depth-3-face nil :foreground "orange")
  (set-face-attribute 'rainbow-delimiters-depth-4-face nil :foreground "RoyalBlue3")
  (set-face-attribute 'rainbow-delimiters-depth-5-face nil :foreground "darkgreen")
  (set-face-attribute 'rainbow-delimiters-depth-6-face nil :foreground "brown")
  (set-face-attribute 'rainbow-delimiters-depth-7-face nil :foreground "purple")
  (set-face-attribute 'rainbow-delimiters-depth-8-face nil :foreground "khaki")
  (set-face-attribute 'rainbow-delimiters-depth-9-face nil :foreground "salmon"))

(provide 'init-rainbow-delimiters)
