
;;; commands

;; menu
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

(defparameter *app-menu*
  '(("net"
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

;; dmenu
(defcommand mydmenu () ()
  (run-shell-command "dmenu_run"))

;; from simias
;; paste.lisp.org/display/95891
(defvar *swap-selected-frame* nil)

(defcommand swap-windows (&optional (frame (tile-group-current-frame (current-group)))) ()
  (if *swap-selected-frame*
      (progn
        (let ((win1 (frame-window *swap-selected-frame*))
              (win2 (frame-window frame)))
          (when win1 (pull-window win1 frame))
          (when win2 (pull-window win2 *swap-selected-frame*)))
        (setf *swap-selected-frame* nil))
      (setf *swap-selected-frame* frame)))

;; paste.lisp.org/+21ZP
(defun shift-windows-forward (frames win)
  (when frames
    (let ((frame (car frames)))
      (shift-windows-forward (cdr frames)
                             (frame-window frame))
      (when win
        (pull-window win frame)))))

;; swap 2 windows
(defcommand rotate-windows () ()
  (let* ((frames (group-frames (current-group)))
         (win (frame-window (car (last frames)))))
    (shift-windows-forward frames win)))

(defcommand v-to-hsplit () ()
  (only)
  (hsplit))

(defcommand v-to-vsplit () ()
  (only)
  (vsplit))

;; toggle between vertical and horizontal split
(defcommand toggle-split () ()
  (let* ((group (current-group))
         (cur-frame (tile-group-current-frame group))
         (frames (group-frames group)))
    (if (eq (length frames) 2)
        (progn (if (or (neighbour :left cur-frame frames)
                       (neighbour :right cur-frame frames))
                   (progn
                     (only)
                     (vsplit))
                   (progn
                     (only)
                     (hsplit))))
        (message "Works only with 2 frames"))))
