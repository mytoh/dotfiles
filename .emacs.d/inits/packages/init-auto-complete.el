;; auto-complete
(req 'auto-complete
    (req 'auto-complete-config )
                                        ;  (ac-config-default)
  (global-auto-complete-mode t)
  (define-key ac-completing-map (kbd "C-n") 'ac-next)
  (define-key ac-completing-map (kbd "C-p") 'ac-previous)
  (setq ac-dwim t)

  (req 'ac-ja)

  ;; completion for eshell
  ;; from valvallow.blogspot.jp/2011/02/eshell.html
  (req 'pcomplete
      (add-to-list 'ac-modes 'eshell-mode)
    (ac-define-source pcomplete
      '((candidates . pcomplete-completions)))
    (defun my-ac-eshell-mode ()
      (setq ac-sources
            '(ac-source-pcomplete
              ac-source-words-in-buffer
              ac-source-dictionary)))
    (add-hook 'eshell-mode-hook
              (lambda ()
                (lambda ()
                  (my-ac-eshell-mode)
                  (define-key eshell-mode-map (kbd "C-i") 'auto-complete))))
    (custom-set-faces
     '(eshell-prompt-face ((t (:foreground "maroon2" :bold nil)))))))


(provide 'init-auto-complete)
