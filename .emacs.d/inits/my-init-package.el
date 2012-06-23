;;; -*- coding: utf-8; lexical-binding: t -*-

;; package.el
(my-req 'package
    ;; load MELPA
    (add-to-list 'package-archives
                 '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives
               '("marmalade" . "http://marmalade-repo.org/packages/"))
  (package-initialize))

;; install packages
(setq *my-package-list*
      '(rainbow-delimiters
        auto-complete
        dired+
        image-dired+
        helm
        helm-git
        magit
        rainbow-mode
        expand-region
        tabbar
        cursor-chg
        suomalainen-kalenteri
        isearch+
        info+
        haskell-mode
        flex-autopair
                ))

(dolist (p *my-package-list*)
  (unless (package-installed-p p)
    (package-install p)
    (message "install %s"  p)))

;; rainbow-delimiters
(my-req 'rainbow-delimiters
    (add-hook 'scheme-mode-hook       'rainbow-delimiters-mode)
  (add-hook 'lisp-mode-hook         'rainbow-delimiters-mode)
  (add-hook 'emacs-lisp-mode-hook   'rainbow-delimiters-mode))

;; auto-complete
(my-req 'auto-complete
    (my-req 'auto-complete-config )
  (ac-config-default)
  (global-auto-complete-mode t)
  (define-key ac-completing-map (kbd "C-n") 'ac-next)
  (define-key ac-completing-map (kbd "C-p") 'ac-previous)
  (setq ac-dwim t)
  )

;; dired+
(my-req 'dired+)
;; image-dired+
(my-req 'image-dired+)

;; helm
(my-req 'helm-config
    (global-set-key (kbd "C-c h") 'helm-mini)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (helm-mode t))
;; helm-git depends on magit
(my-req 'magit
    (my-req 'helm-git))

;; icicles
(my-req 'icicles
    (icy-mode t))

;; rainbow-mode
(my-req 'rainbow-mode
    (add-hook 'emacs-lisp-mode-hook 'rainbow-mode)
  (add-hook 'lisp-mode-hook 'rainbow-mode)
  (add-hook 'scheme-mode-hook 'rainbow-mode))

;; expand-region
(my-req 'expand-region
    (global-set-key (kbd "C-M-SPC") 'er/expand-region)
  (global-set-key (kbd "C-M-s-SPC") 'er/contract-region))

;; tabbar
(my-req 'tabbar
    ;; http://d.hatena.ne.jp/alfad/20100425/1272208744
    ;; http://idita.blog11.fc2.com/blog-entry-810.html
    (tabbar-mode t)
  ;; disbale buttons no left side
  (dolist (btn '(tabbar-home-button
                 tabbar-scroll-right-button
                 tabbar-scroll-left-button))
    (set btn (cons (cons "" nil)
                   (cons "" nil))))
  ;; face
  (set-face-attribute
   'tabbar-default nil 
   :background "black")
  (set-face-attribute
   'tabbar-selected nil
   :foreground "white"
   :background "gray38"
   :box nil)
  (set-face-attribute
   'tabbar-unselected nil
   :foreground "white"
   :background "gray14"
   :box '(:line-width 1 :color "gray22" :style nil))
                                        ;  :box '(:line-width 1 :color "white" :style nil))
  (set-face-attribute
   'tabbar-button nil
   :box '(:line-width 1 :color "gray72" :style nil))
  (set-face-attribute
   'tabbar-separator nil
   :height 60)

  ;; firefox keybind
  (global-set-key [(control tab)] 'tabbar-forward-tab)
  (global-set-key [(control shift tab)] 'tabbar-backward-tab))

;; cursor-chg
(my-req 'cursor-chg
    (toggle-cursor-type-when-idle t)
  (change-cursor-mode t))

;; suomalainen-kalenteri
(eval-after-load 'calendar
  '(my-req 'suomalainen-kalenteri))

;; isearch+
(eval-after-load 'isearch '(my-req 'isearch+))

;; info+
(eval-after-load 'info '(my-req 'info+))

;; haskell-mode
(my-req 'haskell-mode
    (my-req 'haskell-cabal)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation))

;; flex-autopair
(my-req 'flex-autopair
    (flex-autopair-mode 1))


;;; builtin
;; show trailing whitespace
(my-req 'whitespace
    (setq whitespace-line-column 80)
  (setq whitespace-style '(face
                           trailing
                                        ;                                 lines-tail
                           space-before-tab
                           space-after-tab))
  (global-whitespace-mode t)
  (add-hook 'scheme-mode-hook
            (lambda ()
                                       (add-hook 'write-contents-functions 'whitespace-cleanup)
                         (add-hook 'write-contents-functions 'delete-trailing-whitespace))))

;; save curosr position
(my-req 'saveplace
    (setq-default save-place t))

;; eldoc
(my-req 'eldoc
    (setq eldoc-idle-dely 0)
  (setq eldoc-echo-area-use-multiline-p t)
  (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode))

(provide 'my-init-package)
