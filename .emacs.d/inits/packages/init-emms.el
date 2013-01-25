;; emms
(req 'emms-setup
     (emms-devel)
     (emms-default-players)
     (emms-all)
     (require 'emms-source-playlist)
     (require 'emms-source-file)
     (add-hook 'emms-player-standard-hook 'emms-show)
     (setq emms-show-format "NP: %s")
     (setq emms-source-file-default-directory "~/local/var/musiikki"))

(provide 'init-emms)
