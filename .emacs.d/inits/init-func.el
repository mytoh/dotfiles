 ;;; -*- coding: utf-8; lexical-binding: t -*-
;;http://www.reddit.com/r/emacs/comments/umb24/expandfilename_is_good_for_path_concat_too/
(defun* concat-path (&rest parts)
  (reduce  (lambda (a b) (expand-file-name b a)) parts))

(defun my-before-save-hook ()
  (save-excursion
    (goto-char (point-min))
    (delete-trailing-whitespace)
    (while (re-search-forward (rx (submatch (syntax close-parenthesis))
                                  (submatch (one-or-more (in  " \t")))
                                  (submatch (syntax close-parenthesis))) nil t)
      (replace-match  "))" nil nil))
    (while (re-search-forward (rx (submatch (syntax open-parenthesis))
                                  (submatch (one-or-more (in  " \t")))
                                  (submatch (syntax open-parenthesis))) nil t)
      (replace-match  "((" nil nil))
    (indent-region (point-min) (point-max))))

(defun my-indent-buffer ()
  "milkypostman/dotemacs/defun.el"
  (interactive)
  (indent-region (point-min) (point-max)))

(provide 'init-func)

