;;http://www.reddit.com/r/emacs/comments/umb24/expandfilename_is_good_for_path_concat_too/
(defun* concat-path (&rest parts)
  (reduce  (lambda (a b) (expand-file-name b a)) parts))

(provide 'my-init-func)
