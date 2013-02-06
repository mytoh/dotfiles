

;;; {{{ hooks
;; {{{ mouse click hook
(setf *mode-line-click-hook*
      (list (lambda (&rest args)
              (cond ((eq (second args) 1)
                     (run-commands "gnext"))
                    ((eq (second args) 3)
                     (run-commands "gprev"))))))
;;; }}}

;; print key sequence
(defun show-key-seq (key seq val)
  (message (print-key-seq (reverse seq))))
(add-hook *key-press-hook* 'show-key-seq)

;; {{{ Male's code for key sequence display
;; (defun key-press-hook (key key-seq cmd)
;;   (declare (ignore key))
;;   (unless (eq *top-map* *resize-map*)
;;     (let ((*message-window-gravity* :bottom-left))
;;       (message "Key sequence: ~A" (print-key-seq (reverse key-seq))))
;;     (when (stringp cmd)
;;       ;; Give 'em time to read it.
;;       (sleep 0.01))))
;; (defmacro replace-hook (hook fn)
;;   `(remove-hook ,hook ,fn)
;;   `(add-hook ,hook ,fn))
;; (replace-hook *key-press-hook* 'key-press-hook)
;;}}}
;;;}}}
