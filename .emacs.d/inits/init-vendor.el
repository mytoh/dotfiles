;;; plugins under vendor directory
(my-vendor-install-packages '(("emacs-powerline" "git://github.com/jonathanchu/emacs-powerline")
                       ("nyan-mode" "git://github.com/TeMPOraL/nyan-mode")
                       ("highlight-sexp" "git://github.com/daimrod/highlight-sexp")
                       ("emux-el" "git://github.com/m2ym/emux-el")))

;; update plugins
(my-vendor-update-packages *user-emacs-vendor-directory*)
;; powerline, github.com/jonathanchu/emacs-powrline
(my-add-to-load-path (concat *user-emacs-vendor-directory*
                             "emacs-powerline"))
(my-req 'powerline
        (setq powerline-arrow-shape 'arrow)   ;; arrow, curve, arrow14
        )
;; nyan-mode, github.com/TeMPOraL/nyan-mode
(my-add-to-load-path (concat *user-emacs-vendor-directory*
                             "nyan-mode"))
;; emux-el github.com/m2ym/emux-el
(my-add-to-load-path (concat *user-emacs-vendor-directory*
                             "emux-el"))
(my-req 'emux)

;; highlight-sexp
(my-add-to-load-path (concat *user-emacs-vendor-directory*
                             "highlight-sexp"))
(my-req 'highlight-sexp
        (add-hook 'lisp-mode-hook 'highlight-sexp-mode)
        (add-hook 'emacs-lisp-mode-hook 'highlight-sexp-mode)
        (add-hook 'scheme-mode-hook 'highlight-sexp)
        (setq hl-sexp-foreground-color nil)
        (setq hl-sexp-background-color "#1a1a1a"))

(provide 'init-vendor)
