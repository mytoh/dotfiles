;; from emacs wiki, load path section
(let ((default-directory "~/.emacs.d/elisp/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))
(concat user-emacs-directory
        (convert-standard-filename "elisp/"))
(setq default-directory "~/")
(setq Info-additional-directory-list '("~/.emacs.d/info"))

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;; encodings
(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(setq file-name-coding-system 'utf-8-unix)
(set-clipboard-coding-system 'utf-8-unix)
(setq buffer-file-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
;(utf-translate-cjk-mode t)
;; server for emacsclient
(server-start)
;; truncate lines
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)
;; use space instead tab
(setq-default tab-width 4 indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)
;; delete whole line with C-k
(setq kill-whole-line t)
;; change yes-no to y-n
(fset 'yes-or-no-p 'y-or-n-p)
;;disable startup message
(setq inhibit-startup-screen -1)
(line-number-mode t)
(column-number-mode t)
;; show empty line
(setq-default indicate-empty-lines t)
;; function name in modeline
(which-function-mode 1)
;; backspace with C-h
;(global-set-key "\C-h" 'backward-delete-char)
;; show images
(auto-image-file-mode t)
;; highlight region
(transient-mark-mode t)
;; highlight current line
(global-hl-line-mode nil)
;; flash parens
(show-paren-mode t)
;; line by line scrolling
(setq scroll-step 1 
      scroll-conservatively 10000) 
;; 
(setq-default scroll-down-aggressively 0.4
              scroll-up-aggressively   0.4)

;; no backup file 
(setq backup-inhibited t)
;; delete autosave file when quit
(setq delete-auto-save-files t)
;; search incase-sensitive
(setq completion-ignore-case t)
;; always show possible completion-mode
;(icomplete-mode 1)
;; don't flach cursor
(blink-cursor-mode 0)
;; share clipboard with x
(setq x-select-enable-clipboard t)
;; disable follow link question
(setq vc-follow-symlinks t)
;; clock in modeline
(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time)
;; tool bar
(tool-bar-mode -1)
;; menubar
(menu-bar-mode -1)
;; highlight
(global-font-lock-mode t)
(setq font-lock-maximus-decoration t)
;; 
(auto-compression-mode t)
;; iswitch mode in C-x b
(iswitchb-mode t)
;; set initial frame size, place, font
(if (boundp 'window-system)
    (setq initial-frame-alist
	  (append (list
                  '(alpha . 93) ;; tranparency for defalt
	           '(vertical-scroll-bars . nil) ;; scroll bars
	           '(width . 179) ;; window width
	           '(height . 52) ;; window height
	           '(top . 0)     ;; window placement
	           '(left . 0)    ;; window placement
	           '(font . "Inconsolata 10")
	           )
	      initial-frame-alist)))
(setq default-frame-alist initial-frame-alist)

;; reload face setting for first fram
(add-hook 'window-setup-hook
          '(lambda ()
             (face-set-after-frame-default (selected-frame))))

(setq initial-scratch-message ";; *scratch buffer*

")


;;;;; faces  ;;;;;
(custom-set-faces
 '(default   ((t
	      (:background "gray7" 
	       :foreground "#d0d0d0" 
	       :height 80
	       ))))
 '(cursor    ((t
               (:background "white"
               ))))
 '(highlight ((t
               (:background "HotPink2"
                :foreground "gray11"
	       ))))
 '(region    ((t
	       (:background "dark slate blue"
	       ))))
 '(modeline ((t
	      (:background "gray30"
	       :foreground "white"
	      ))))
 '(mode-line-buffer-id ((t
                         (:background "gray15"
                          :foreground "linen"
                          ))))
 '(font-lock-comment-face ((t
                            (:foreground "gray35"
                            ))))
 '(linum    ((t
	      (:inherit shadow :background "gray45"
	      )))))

;; scheme program
(setq scheme-program-name "gosh")
; set encoding to utf-8 
(setq process-coding-system-alist
      (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))
; load cmuscheme.el for scheme program
(autoload 'scheme-mode "cmuscheme" "Major mode for Schem." t)
(autoload 'run-schapeme "cmuscheme" "Run an inferior Scheme process." t)
;; split window
;; run scheme in one window
(defun scheme-other-window ()
  "Run scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme scheme-program-name))
;; call func by Ctrl-c 
(define-key global-map
  "\C-cS" 'scheme-other-window)

;; changelog 
(defun memo ()
  (interactive)
    (add-change-log-entry
     nil
     (expand-file-name "~/.changelog")))
(define-key global-map (kbd "C-x M") 'memo)
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; elisp packages ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; auto-install
;; original setting see
;; http://d.hatena.ne.jp/xorphitus/20101103/1288776927
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;; update package names
  (auto-install-update-emacswiki-package-name t)
  ;; enable install-elisp functions
  (auto-install-compatibility-setup))

;; auto-complete.el
(require 'auto-complete)
(global-auto-complete-mode t)

;; w3m 
(require 'w3m-load)
(global-set-key (kbd "C-c w") 'w3m)
(add-hook 'w3m-mode-hook
         '(lambda ()
            (local-set-key (kbd "f") 'w3m-go-to-linknum)
            ( message "starting  w3m")))
;; anything
(require 'anything-startup)

;; split-root written by rubikitch
(require 'split-root)
(defvar split-root-window-height nil)
(defun display-buffer-function--split-root (buf &optional ignore)
  (let ((window (split-root-window split-root-window-height)))
    (set-window-buffer window buf)
    window))
;for anything window
(setq anything-display-function 'display-buffer-function--split-root)

;; magit 
(require 'magit)

;; emms
(require 'emms)
(require 'emms-setup)
(require 'emms-mode-line-icon)
(require 'emms-info-libtag)
(require 'emms-history)
(require 'anything-emms)
(emms-devel)
(emms-default-players)
(setq emms-repeat-playlist t
      emms-info-asynchronously t
      emms-info-auto-update t
      later-do-interval 0.0001
      emms-player-list '(emms-player-mplayer)
      emms-source-file-default-directory "~/local/var/musica/"
      emms-playlist-buffer-name "*music*")
;; for emms-print-metadata in emms-info-libtag
;; install taglib
;; $git clone git://git.sv.gnu.org/emms.git
;; move src directory 
;; $gcc -I/path/to/include/taglib -L/path/to/lib -ltag_c file -o newfile
(setq emms-info-functions '(emms-info-libtag))

;; load history file on startup 
;; default ~/.emacs.d/emms-history
(emms-history-load)

;(emms-add-directory-tree "~/local/var/musica/")
(emms-add-playlist "~/.emacs.d/playlist.ems")
(setq emms-source-playlist-native "~/.emacs.d/playlist.ems")

;; Show the current track each time EMMS
;; starts to play a track with "NP : "
(add-hook 'emms-player-started-hook 'emms-show)
(add-hook 'emms-player-paused-hook 'emms-show)
(setq emms-show-format "NP: %s")
;; icon setup
(setq emms-mode-line-icon-before-format "("
      emms-mode-line-format "%s)"
      emms-mode-line-icon-color "blue")
(emms-mode-line 1)
;; this function from "http://unixforever.blogspot.com/2010/06/sample-emms-emacs-configuration.html"
;; to use this disable emms-mode-line
;(setq emms-mode-line-mode-line-function
;  (lambda nil
;    (let ((track (emms-playlist-current-selected-track)))
;      (let ((title (emms-track-get track 'info-title)))
;        (let ((name (emms-track-get track 'name)))
;          (if (not (null title))
;                (format emms-mode-line-format title)
;                (if (not (null (string-match "^url: " (emms-track-simple-description track))))
;                      (format emms-mode-line-format "Internet Radio")
;      (setq name2 (replace-regexp-in-string ".*.\/" "" name))
;      (format emms-mode-line-format name2))))))))
;(emms-mode-line-disable)
;(emms-mode-line-enable)
;(load "emms")
;; show time 
(emms-playing-time 1)
;; keybindings 
(global-set-key (kbd "C-c <SPC>") 'emms-pause) 
(global-set-key (kbd "C-c p") 'emms-previous)
(global-set-key (kbd "C-c n") 'emms-next)
(global-set-key (kbd "C-c s") 'emms-stop)
(global-set-key (kbd "C-c f") 'emms-show)
(global-set-key (kbd "C-c b") 'emms-smart-browse)

(emms-cache-sync)

;;; navi2ch
(autoload 'navi2ch' "navi2ch" "Navigator for 2ch for Emacs" t)

;;; icicles
(require 'icicles)
(icy-mode 1)

;;; sessin.el
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;; tumme
;(require 'tumme)
;(tumme-setup-dired-keybindings)

;; minibuf-electric-gnuemacs
(require 'minibuf-electric-gnuemacs)

;;; skk
(require 'skk-setup)
(require 'skk-study)
(require 'skk-autoloads)
(require 'skk-hint)
;; Skk-Server Aquaskk
(setq skk-server-portnum 1178)
(setq skk-server-host "localhost")
(global-set-key "\C-x\C-j" 'skk-mode)
(setq skk-kakutei-when-unique-candidate t)
(setq skk-cdb-large-jisyo "~/.skk-jisyo.mine.cdb")
(setq skk-preload t)
(setq skk-show-annotation t)
(setq skk-show-tooltip t)
(setq skk-show-inline t)
(setq skk-egg-like-newline t)
(setq skk-dcomp-activate t)
(setq skk-dcomp-multiple-activate t)
;; azik 
;(setq skk-use-azik t)
;(setq skk-azik-keyboard-type 'en)
;; act
(require 'skk)
(setq skk-act-use-normal-y t)
(setq skk-use-act t)
;;;ppp from skk info
;(add-hook 'isearch-mode-hook
;          #'(lambda ()
;              (when (and (boundp 'skk-mode)
;                         skk-mode
;                         skk-isearch-mode-enable)
;                (skk-isearch-mode-cleanup))))
;(add-hook 'isearch-mode-end-hook
;          #'(lambda ()
;              (when (and (featurep 'skk-isearch)
;                         skk-isearch-mode-enable)
;                (skk-isearch-mode-cleanup))))
;;; for mac
(setq mac-pass-control-to-system nil)

;;; gosh-mode
;;(require 'gosh-config)

;; moccur
(require 'color-moccur)
(require 'moccur-edit)

(cd "~/")





