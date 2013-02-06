


(defun my-setup-colours ()
  (setf *colors* (list "grey"          ; 0 black
                       "palevioletred" ; 1 red
                       "lightblue"     ; 2 green
                       "bisque"        ; 3 yellow
                       "lightskyblue"  ; 4 blue
                       "slateblue"     ; 5 magenta
                       "aquamarine"    ; 6 cyan
                       "honeydew"      ; 7 white
                       "thistle"       ; 8 user
                       "lightskyblue")); 9 user
  (update-color-map (current-screen)))

(defun my-setup-modeline ()
  (setf
   *mode-line-background-color*      "grey10"
   *mode-line-foreground-color*      "DarkKhaki"
   *mode-line-border-color*          "pink"
   *mode-line-position*              :top
   *mode-line-border-width*          0
   *mode-line-pad-x*                 1
   *mode-line-pad-y*                 1
   *mode-line-timeout*               3)

  (if (not (head-mode-line (current-head)))
      (toggle-mode-line (current-screen) (current-head)))

  (setf *screen-mode-line-format*  ;; ^n : normal bg and fg color
        (list "%g ^8*|^n "
              "^2*%W ^8*|^n "
              '(:eval (run-shell-command "~/.stumpwm.d/modeline.scm" t))
              "^8*|^n %d "
              )))

(my-setup-colours)
(my-setup-modeline)
