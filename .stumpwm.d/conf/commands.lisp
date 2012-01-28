
;;; commands {{{

;;{{{ menu
;; from wiki tips_and_tricks page
(defcommand mymenu () ()
  (labels ((pick (options)
                 (let ((selection (select-from-menu (current-screen) options "")))
                   (cond
                     ((null selection)
                      (throw 'stumpwm::error "Abort."))
                     ((stringp (second selection))
                      (second selection))
                     (t
                       (pick (cdr selection)))))))
          (let ((choice (pick *app-menu*)))
            (run-shell-command choice))))

(defparameter *app-menu* '(("net"
                            ;; sub menu
                              ("firefox" "firefox"))
                           ("fun"
                            ;; sub menu
                            ("option 2" "xlogo")
                            ("gnuchess" "xboard"))
                           ("work"
                            ;; sub menu
                            ("gvim" "gvim"))
                           ("graphics"
                            ;;sub menu
                            ("gimp" "gimp"))))
;;}}}

;;;}}}


