
(require 'cl)

;; http://e-arrows.sakura.ne.jp/2010/03/macros-in-emacs-el.html
(defmacro req (lib &rest body)
  "load library if file is exits"
  `(when (locate-library (symbol-name ,lib))
     (require ,lib nil 'noerror)
     ,@body))

(defmacro add-to-load-path (path)
  `(when (file-exists-p ,path)
     (add-to-list 'load-path ,path)))

;; package.el
(req 'package
     ;; load MELPA
     (add-to-list 'package-archives
                  '("melpa" . "http://melpa.milkbox.net/packages/") t)
     (package-initialize))

;; personal initialize
;; plugin directory
(setq *user-emacs-vendor-directory* (concat user-emacs-directory "vendor/"))
;; user elisps
(add-to-load-path (concat user-emacs-directory "elisp"))
;;disable startup message
(setq inhibit-startup-screen -1)
(show-paren-mode)
(global-font-lock-mode t)
;; read symlinked file
(setq vc-follow-symlinks t)
;; encodings
(set-language-environment 'Japanese)
(set-default-coding-systems 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(setq file-name-coding-system 'utf-8-unix)
(set-clipboard-coding-system 'utf-8-unix)
(setq buffer-file-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
;; use space instead of tab
(setq-default tab-width 4 indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)
;; show info on mode-line
(progn
  (setq display-time-24hr-format t)
  (setq display-time-day-and-date t)
  (display-time)
  (line-number-mode t)
  (column-number-mode t))
;; change yes-no to y-n
(fset 'yes-or-no-p 'y-or-n-p)
;; show images
(auto-image-file-mode t)
;; highlight region
(transient-mark-mode t)
;; highlight current line
(global-hl-line-mode nil)
;; line by line scrolling
(setq scroll-step 1)
;; disable bars
(menu-bar-mode nil)
(tool-bar-mode nil)
;; delete whole line with C-k once
(setq kill-whole-line t)
;; enable rectangular mode
(cua-mode t)
(setq cua-enable-cua-keys nil) ; don't make fancy keymaps

;;; faces

;;(set-face-font 'default "Konatu-12")
(set-face-foreground 'default "#d0d0d0")
(set-face-foreground 'highlight "white")
(set-face-foreground 'modeline "white")
(set-face-foreground 'mode-line-buffer-id "linen")
(set-face-foreground 'font-lock-comment-face "gray35")
(set-face-background 'region "dark slate blue")
(set-face-background 'default "gray7")
(set-face-background 'cursor  "white")
(set-face-background 'highlight "gray11")
(set-face-background 'modeline  "gray30")
(set-face-background 'mode-line-buffer-id "gray15")


(custom-set-faces
 '(default
    ((t (:height 110
         )))))

;; transparent 
;; http://www.emacswiki.org/emacs/TransparentEmacs
(set-frame-parameter (selected-frame) 'alpha '(85 50))
(add-to-list 'default-frame-alist '(alpha 85 50))

;; gauche
(setq process-coding-system-alist
      (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))
(setq scheme-program-name "gosh -i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme  "cmuscheme" "Run an inferior Scheme process." t)


;; rainbow-delimiters
(req 'rainbow-delimiters
     (add-hook 'scheme-mode-hook       'rainbow-delimiters-mode)
     (add-hook 'lisp-mode-hook         'rainbow-delimiters-mode)
     (add-hook 'emacs-lisp-mode-hook   'rainbow-delimiters-mode))

;; auto-complete
(req 'auto-complete
     (req 'auto-complete-config )
     (global-auto-complete-mode t)
     (define-key ac-completing-map (kbd "C-n") 'ac-next)
     (define-key ac-completing-map (kbd "C-p") 'ac-previous)
     (setq ac-dwim t))

;; dired+
(req 'dired+)

;; helm
(req 'helm-config
     (global-set-key (kbd "C-c h") 'helm-mini)
     (helm-mode 1))

;; icicles
(req 'icicles
     (icy-mode 1))

;; powerline
(add-to-load-path (concat *user-emacs-vendor-directory*
                          "emacs-powerline"))
(req 'powerline
     (setq powerline-arrow-shape 'arrow14)   ;; arrow, curve, arrow14
     )

;; nyan-mode
(add-to-load-path (concat *user-emacs-vendor-directory*
                          "nyan-mode"))

