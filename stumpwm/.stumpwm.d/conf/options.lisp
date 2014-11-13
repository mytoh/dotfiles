
(defun my-setup-options ()
  (message "setup options")
  ;; message window
  (set-bg-color "gray14")
  (set-fg-color "orange")
  (set-border-color "grey10")
  (set-msg-border-width 1)
  ;; (set-font "-mplus-goth_p-medium-r-normal--10-*-75-75-p-50-iso8859-1")
  ;; (set-font  "-artwiz-lime-normal-normal-normal-*-10-*-*-*-m-50-iso10646-1")
  ;; (set-font "-artwiz-limemod-medium-r-normal--10-110-75-75-m-50-iso8859-1")
  ;; (set-font "-mplus-fxd-medium-r-normal--10-*-75-75-c-60-iso8859-1")
  (set-font "-benis-lemon-medium-r-normal--10-*-75-75-m-50-iso8859-1")
  ;; windows
  (set-focus-color "khaki")
  (set-unfocus-color "grey10")
  (set-win-bg-color "grey20")
  (set-normal-gravity :top-right)
  (set-transient-gravity :top-right)
  (set-frame-outline-width 1)

  ;; options
  (setf
   *startup-message*                 nil
   ;; border
   *normal-border-width*             1
   *maxsize-border-width*            1
   *transient-border-width*          1
   *window-border-style*             :tight ;; thick,thin,none,tight
   ;; number map
   *frame-number-map*                "aoeuidhtnspyfgcrlqjkxbmwvz"
   *window-number-map*               "aoeuidhtns"
   *group-number-map*                "aoeuidhtns"
   ;; focus
   *mouse-focus-policy*              :sloppy
   *run-or-raise-all-groups*         t
   *new-window-preferred-frame*      '(:empty :focused)
   ;; gravity
   *message-window-gravity*          :bottom-left
   *input-window-gravity*            :bottom-left
   *input-history-ignore-duplicates* t

   ;; formats
   *window-format*                   "^7*(^9*%n%m%15t^7*)^n" ;;^5 magenta
   *group-format*                    "^7*%t^3%s^n" ;;^7 white
   ))

(my-setup-options)
