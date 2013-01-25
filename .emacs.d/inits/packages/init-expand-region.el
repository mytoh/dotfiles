;; expand-region
(req 'expand-region
     (global-set-key (kbd "C-M-SPC") 'er/expand-region)
     (global-set-key (kbd "C-M-s-SPC") 'er/contract-region))

(provide 'init-expand-region)
