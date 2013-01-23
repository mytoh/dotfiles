 ;;; -*- coding: utf-8; lexical-binding: t -*-

(defun my-scheme-add-keywords (face-name keyword-rules)
  (let* ((keyword-list (mapcar #'(lambda (x)
                                   (symbol-name (cdr x)))
                               keyword-rules))
         (keyword-regexp (concat "(\\("
                                 (regexp-opt keyword-list)
                                 "\\)[ \n]")))
    (font-lock-add-keywords 'scheme-mode
                            `((,keyword-regexp 1 ',face-name))))
  (mapc #'(lambda (x)
            (put (cdr x)
                 'scheme-indent-function
                 (car x)))
        keyword-rules))

;; added for r6rs
(my-scheme-add-keywords
 'my-font-lock-scheme-syntax-face
 '((2 . library)
   (0 . export)
   (0 . import)))

;; r7rs
(my-scheme-add-keywords
 'my-font-lock-scheme-syntax-face
 '((2 . define-library)))

(provide 'my-init-scheme)
