(setq config-basedir (file-name-directory
                      (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path (concat config-basedir "system"))

(load-library "base")
(load-library "pathutil")

(reverse-input-method 'russian-computer)

(setq shell-file-name "/bin/bash")

(setq message-log-max t)

(setq custom-file (at-config-basedir "customizations.el"))

;; A bunch of directories for various working datasets
;; As the order of loading corresponding extensions,
;; is cumbersome to maintain we should customize them ASAP (here)
;;TODO: think of less straightforward customization way
(setq auto-save-list-file-prefix (at-data-dir "/auto-save-list/.saves-"))
(setq bookmark-default-file (at-data-dir "/bookmarks"))
(setq tramp-persistency-file-name (at-data-dir "/tramp"))
(setq eshell-directory-name (at-data-dir "/eshell/"))
(setq shared-game-score-directory (at-data-dir "/games"))
(setq pcache-directory (at-data-dir "/var/pcache/"))
(setq url-configuration-directory (at-data-dir "/url/"))
(setq request-storage-directory (at-data-dir "/request"))
(setq image-dired-dir (at-data-dir "/image-dired/"))

(add-to-list 'load-path (at-config-basedir "rc"))
(add-to-list 'load-path (at-config-basedir "bundles"))

(mapcar 'load
        (mapcar
         (lambda (path) (at-config-basedir path))
         '("constants.el"
           "credentials.el.gpg"
           )))

(load (at-config-basedir "system/packages.el"))

(f-files (at-config-basedir "customdefs")
         (lambda (entry) (load entry))
         t)

(load (at-config-basedir "systemtraits.el"))

(f-files (at-config-basedir "private")
         (lambda (entry) (load entry))
         t)

(require 'bundle-main)

(mapcar 'load
        (mapcar
         (lambda (path) (at-config-basedir path))
         '("rc-auto-modes.el"
           "rc-desktop.el"
           )))
