
(defun my-start-programs ()
  (message "starting up programs")
  ;; (run-shell-command "exec trayer --expand true --alpha 100  --tint 0x303030 --transparent true --padding 1 --margin 0 --edge bottom --align right --SetDockType true --SetPartialStrut true --heighttype pixel --height 8 --widthtype request --width 100 " )
  ;;(run-shell-command "stalonetray" )
  (run-shell-command "exec sh ~/.fehbg" )
  ;; (run-shell-command "exec compton -i 0.9 -e 0.9" )
  (run-shell-command "exec ~/.stumpwm.d/dzen.sh" )
  (run-shell-command "exec unclutter -idle 1 -jitter 2 -root")
  (run-shell-command "exec wmname LG3D"))

(defun my-set-cursor ()
(stumpwm:run-shell-command "xsetroot -cursor_name left_ptr"))

(my-start-programs)
