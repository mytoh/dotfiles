 ;;; -*- coding: utf-8; lexical-binding: t -*-


;;;
;;; builtins
;;;

;; save curosr position
(req 'saveplace
     (setq-default save-place t))

;; eldoc
(req 'eldoc
     (setq eldoc-idle-dely 0.20)
     (setq eldoc-echo-area-use-multiline-p t)
     (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
     (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
     (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode))

;; checkdoc
(req 'checkdoc)

;; uniquify
(req 'uniquify
     (setq uniquify-buffer-name-style 'post-forward-angle-brackets))

;; term/bobcat
(load "term/bobcat")
(when (fboundp 'terminal-init-bobcat)
  (terminal-init-bobcat))

;; eshell
(setq eshell-cmpl-ignore-case t)
(setq eshell-ask-to-save-history (quote always))
(setq eshell-cmpl-cycle-completions t)
(setq eshell-cmpl-cycle-cutoff-length 5)
(setq eshell-hist-ignoredups t)
;; prompt
'(setq eshell-prompt-function
       (lambda ()
         (concat
          "[" (format-time-string "%Y/%m/%d(%a) %H:%M") "]"
          "[" (user-login-name) "@" (system-name) " "
          "]\n"
          (if (= (user-uid) 0)
              "#" "$")
          " ")))

(add-hook 'eshell-mode-hook
          '(lambda ()
             (progn
               (define-key eshell-mode-map (kbd "C-a") 'eshell-bol)
               (define-key eshell-mode-map (kbd "C-p") 'eshell-previous-matching-input-from-input)
               (define-key eshell-mode-map (kbd "C-n") 'eshell-next-matching-input-from-input))))


;;;
;;; melpa or marmalade
;;;
;; package.el
(req 'package
     ;; load MELPA
     (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                              ("melpa" . "http://melpa.milkbox.net/packages/")
                              ;;("marmalade" . "http://marmalade-repo.org/packages/")
                              ))
     (package-initialize))

;; install packages
(setq *my-package-list*
      '(rainbow-delimiters
        auto-complete
        ac-ja
        ac-slime
        bookmark+
        cursor-chg
        deferred
        dired+
        dired-single
        highlight-symbol
        image-dired+
        helm
        helm-git
        helm-themes
        helm-c-moccur
        helm-c-yasnippet
        icicles
        magit
        rainbow-mode
        scheme-complete
        expand-region
        tabbar
        suomalainen-kalenteri
        isearch+
        info+
        redo+
        haskell-mode
        flex-autopair
        yasnippet
        w3m
        paredit
        ack-and-a-half
        powerline
        popwin
        ghc
        emms
        color-moccur
        git-gutter
        nyan-mode
        minimap
        ;; themes
        molokai-theme
        monokai-theme
        late-night-theme
        ))

(package-refresh-contents)
(dolist (p *my-package-list*)
  (unless (package-installed-p p)
    (package-install p)
    (message "install %s"  p)))

;; init
(add-to-list 'load-path
             (concat user-emacs-directory
                     (file-name-as-directory "inits/packages")))

(require 'init-rainbow-delimiters)
(require 'init-auto-complete)
(require 'init-dired+)
(require 'init-image-dired+)
(require 'init-helm)
(require 'init-rainbow-mode)
(require 'init-expand-region)
(require 'init-tabbar)
(require 'init-paredit)
(require 'init-emms)

;; ;; icicles
;;(req 'icicles
;;   (icy-mode t))




;; cursor-chg
(req 'cursor-chg
     (toggle-cursor-type-when-idle t)
     (change-cursor-mode t))

;; suomalainen-kalenteri
(eval-after-load 'calendar
  '(req 'suomalainen-kalenteri))

;; ;; isearch+
(eval-after-load 'isearch '(req 'isearch+))

;; ;; info+
(eval-after-load 'info '(req 'info+))

;; haskell-mode
(req 'haskell-mode
     (req 'haskell-cabal)
     (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
     (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation))

;; ;; egg
;; (req 'egg
;;     (setq egg-auto-update nil))

;; ;; redo+
;; (req 'redo+
;;     (global-set-key (kbd "C-_") 'redo))

;; ack-and-a-half
(autoload 'ack-and-a-half-same "ack-and-a-half" nil t)
(autoload 'ack-and-a-half "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file-same "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file "ack-and-a-half" nil t)
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

;; yasnippet
;; (req 'yasnippet
;;         (yas/global-mode t)
;;         (yas/load-directory "~/.emacs.d/snippets")
;;         (fset 'yes-or-no-p 'y-or-n-p))

;; flex-autopair
(req 'flex-autopair
     (flex-autopair-mode 1))

;; multi-term
(req 'multi-term)

;; w3m
(setq w3m-command "/usr/local/bin/w3m")
(req 'w3m-load)

;; ack-and-a-half
(req 'ack-and-a-half
     (defalias 'ack 'ack-and-a-half)
     (defalias 'ack-same 'ack-and-a-half-same)
     (defalias 'ack-find-file 'ack-and-a-half-find-file)
     (defalias 'ack-find-file-same 'ack-and-a-half-find-file-same))

;; powerline 2
(req 'powerline
     (powerline-default))

;; popwin
(req 'popwin
     (setq display-buffer-function 'popwin:display-buffer)
     (setq popwin:special-display-config
           ( append  '(("*Warnings*") ("*Compile-log") ("*Help*"))
                     popwin:special-display-config)))


;; ghc
(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))


;; git-gutter
(req 'git-gutter
     ;; bind git-gutter toggle command
     (define-key global-map (kbd "C-x C-g") 'git-gutter:toggle)
     '(add-hook 'after-save-hook
                (lambda ()
                  (when (zerop (call-process-shell-command "git rev-parse --show-toplevel" ))
                    (git-gutter)))))




(provide 'init-package)
