

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

(provide 'init-paredit)
