
;; helm
(req 'helm-config
    (global-set-key (kbd "C-c h") 'helm-mini)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (helm-mode t))
;; helm-themes
(req 'helm-themes)
;; helm-c-moccur
(req 'color-moccur
    (req 'helm-c-moccur))
;; helm-c-yasnippet
(req 'helm-c-yasnippet)
;; helm-git depends on magit
(req 'magit
    (req 'helm-git))

(provide 'init-helm)
