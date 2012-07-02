
;;; plugins under vendor directory
;; github repositories
(my-vendor-install-packages 
 '(("emacs-powerline" "jonathanchu/emacs-powerline")
   ("nyan-mode" "TeMPOraL/nyan-mode")
   ("highlight-sexp" "daimrod/highlight-sexp")
   ("emux-el" "m2ym/emux-el")
   ("auto-highlight-symbol-mode" "mitsuo-saito/auto-highlight-symbol-mode")
   ("highlight-cl" "emacsmirror/highlight-cl")
   ("helm-delicious" "emacs-helm/helm-delicious")
   ("helm-descbinds" "emacs-helm/helm-descbinds")
   ("seijiseikana-el" "moriyamahiroshi/seijiseikana-el")
   ))

;; update plugins
(my-vendor-update-packages *user-emacs-vendor-directory*)
;; powerline, github.com/jonathanchu/emacs-powrline
(my-add-to-load-path (concat-path *user-emacs-vendor-directory*
                             "emacs-powerline"))
(my-req 'powerline
    (setq powerline-arrow-shape 'arrow14)   ;; arrow, curve, arrow14
  (setq powerline-color1 "grey22")
  (setq powerline-color2 "grey40")
  (set-face-attribute 'mode-line nil
                      :background"#8db6cd"
                      :box nil)
  (set-face-attribute 'mode-line-inactive nil
                      :box nil))

;; nyan-mode, github.com/TeMPOraL/nyan-mode
(my-add-to-load-path (concat-path *user-emacs-vendor-directory*
                             "nyan-mode"))
;; emux-el github.com/m2ym/emux-el
(my-add-to-load-path (concat-path *user-emacs-vendor-directory*
                             "emux-el"))
(my-req 'emux
;; prefix C-c
;  "C-n" ' emux:term-next
;  "SPC" 'emux:term-next
;  "C-p"  'emux:term-previous
;  "C-t"   'emux:term-new
;  "A"      'emux:term-rename
;  "k"      'emux:term-kill
;  "d"      'emux:term-cd
;  "~"     'emux:term-sync
)

;; highlight-sexp
(my-add-to-load-path
    (concat-path *user-emacs-vendor-directory*
            "highlight-sexp"))
;; (my-req 'highlight-sexp
;;     (add-hook 'lisp-mode-hook 'highlight-sexp-mode)
;;   (add-hook 'emacs-lisp-mode-hook 'highlight-sexp-mode)
;;   (add-hook 'scheme-mode-hook 'highlight-sexp)
;;   (setq hl-sexp-foreground-color nil)
;;   (setq hl-sexp-background-color "#1a1a1a"))

;; auto-highlight-symbol-mode
(my-add-to-load-path (concat-path *user-emacs-vendor-directory*
                             "auto-highlight-symbol"))
(my-req 'auto-highlight-symbol
    (global-auto-highlight-symbol-mode t))

;; highlight-cl
(my-add-to-load-path (concat-path *user-emacs-vendor-directory*
                             "highlight-cl"))
(my-req 'highlight-cl
    (add-hook 'emacs-lisp-mode-hook 'highlight-cl-add-font-lock-keywords)
  (add-hook 'lisp-interaction-mode-hook 'highlight-cl-add-font-lock-keywords))

;; stumpwm
(my-add-to-load-path (concat-path *user-emacs-vendor-directory*
                             "stumpwm-mode"))
(my-req 'stumpwm-mode)

;; helm-delicious
(my-add-to-load-path (concat-path *user-emacs-vendor-directory*
                                  "helm-delicious"))
(my-req 'helm-delicious
    (my-req 'auth-source
  (if (file-exists-p "~/.authinfo.gpg")
      (setq auth-sources '((:source "~/.authinfo.gpg" :host t :protocol t)))
    (setq auth-sources '((:source "~/.authinfo" :host t :protocol t))))))

;; helm-descbinds
(my-add-to-load-path (concat-path *user-emacs-vendor-directory*
                                  "helm-descbinds"))
(my-req 'helm-descbinds)

;; seijiseikana
(my-add-to-load-path (concat-path *user-emacs-vendor-directory*
                                  "seijiseikana-el"))
(my-req 'seijiseikana)

(provide 'my-init-vendor)
