 ;;; -*- coding: utf-8; lexical-binding: t -*-

;; package.el
(my-req 'package
    ;; load MELPA
    (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                             ("melpa" . "http://melpa.milkbox.net/packages/")
                             ("marmalade" . "http://marmalade-repo.org/packages/")))
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

;;;
;;; builtins
;;;

;; save curosr position
(my-req 'saveplace
    (setq-default save-place t))

;; eldoc
(my-req 'eldoc
    (setq eldoc-idle-dely 0.20)
  (setq eldoc-echo-area-use-multiline-p t)
  (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode))

;; checkdoc
(my-req 'checkdoc)

;; uniquify
(my-req 'uniquify
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
(add-hook 'eshell-mode-hook
          '(lambda ()
             (progn
               (define-key eshell-mode-map (kbd "C-a") 'eshell-bol)
               (define-key eshell-mode-map (kbd "C-p") 'eshell-previous-matching-input-from-input)
               (define-key eshell-mode-map (kbd "C-n") 'eshell-next-matching-input-from-input))))

;;;
;;; melpa or marmalade
;;;

;; rainbow-delimiters
(my-req 'rainbow-delimiters
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


;; auto-complete
(my-req 'auto-complete
    (my-req 'auto-complete-config )
                                        ;  (ac-config-default)
  (global-auto-complete-mode t)
  (define-key ac-completing-map (kbd "C-n") 'ac-next)
  (define-key ac-completing-map (kbd "C-p") 'ac-previous)
  (setq ac-dwim t)

  (my-req 'ac-ja))


;; dired+
(my-req 'dired+)
;; image-dired+
(my-req 'image-dired+)

;; helm
(my-req 'helm-config
    (global-set-key (kbd "C-c h") 'helm-mini)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (helm-mode t))
;; helm-themes
(my-req 'helm-themes)
;; helm-c-moccur
(my-req 'color-moccur
    (my-req 'helm-c-moccur))
;; helm-c-yasnippet
(my-req 'helm-c-yasnippet)
;; helm-git depends on magit
(my-req 'magit
    (my-req 'helm-git))


;; ;; icicles
;;(my-req 'icicles
;;   (icy-mode t))

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

;; ;; isearch+
(eval-after-load 'isearch '(my-req 'isearch+))

;; ;; info+
(eval-after-load 'info '(my-req 'info+))

;; haskell-mode
(my-req 'haskell-mode
    (my-req 'haskell-cabal)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation))

;; ;; egg
;; (my-req 'egg
;;     (setq egg-auto-update nil))

;; ;; redo+
;; (my-req 'redo+
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
;; (my-req 'yasnippet
;;         (yas/global-mode t)
;;         (yas/load-directory "~/.emacs.d/snippets")
;;         (fset 'yes-or-no-p 'y-or-n-p))

;; flex-autopair
(my-req 'flex-autopair
    (flex-autopair-mode 1))

;; multi-term
(my-req 'multi-term)

;; w3m
(setq w3m-command "/usr/local/bin/w3m")
(my-req 'w3m-load)

;; ack-and-a-half
(my-req 'ack-and-a-half
    (defalias 'ack 'ack-and-a-half)
  (defalias 'ack-same 'ack-and-a-half-same)
  (defalias 'ack-find-file 'ack-and-a-half-find-file)
  (defalias 'ack-find-file-same 'ack-and-a-half-find-file-same))

;; powerline 2
(my-req 'powerline
    (powerline-default))

;; popwin
(my-req 'popwin
    (setq display-buffer-function 'popwin:display-buffer)
  (setq popwin:special-display-config
        ( append  '(("*Warnings*") ("*Compile-log") ("*Help*"))
                  popwin:special-display-config)))

;; paredit
(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code."
  t)
;; http://whattheemacsd.com/setup-paredit.el-02.html
(defun paredit--is-at-start-of-sexp ()
  (and (looking-at "(\\|\\[")
       (not (nth 3 (syntax-ppss)))      ; inside string
       (not (nth 4 (syntax-ppss)))))    ; inside comment

(defun paredit-duplicate-closest-sexp ()
  (interactive)
  ;; skips to start of current sexp
  (while (not (paredit--is-at-start-of-sexp))
    (paredit-backward))
  (set-mark-command nil)
  ;; while we find sexps we move forward on the line
  (while (and (bounds-of-thing-at-point 'sexp)
              (<= (point) (car (bounds-of-thing-at-point 'sexp)))
              (not (= (point) (line-end-position))))
    (forward-sexp)
    (while (looking-at " ")
      (forward-char)))
  (kill-ring-save (mark) (point))
  ;; go to the next line and copy the sexprs we encounterd
  (paredit-newline)
  (yank)
  (exchange-point-and-mark))

(defun paredit-wrap-round-from-behind ()
  (interactive)
  (forward-sexp -1)
  (paredit-wrap-round)
  (insert " ")
  (forward-char -1))

(eval-after-load "paredit"
  '(progn (define-key paredit-mode-map (kbd "C-S-d")
            'paredit-duplicate-closest-sexp)
          (define-key paredit-mode-map (kbd "M-)")
            'paredit-wrap-round-from-behind)))

(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode t)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode t)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode t)))
(add-hook 'scheme-mode-hook           (lambda () (paredit-mode t)))

;; ghc
(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

;; emms
(my-req 'emms-setup
    (emms-devel)
  (emms-default-players)
  (add-hook 'emms-player-standard-hook 'emms-show)
  (setq emms-show-format "NP: %s")
  (my-req 'emms-info-libtag))





(provide 'my-init-package)
