(setq config-basedir (file-name-directory
                      (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path config-basedir)

(load-library "base")

(setq shell-file-name "/bin/bash")

(setq message-log-max t)

(setq home-directory (getenv "HOME"))
(setq global-username user-login-name)

(setq custom-file (at-config-basedir "customizations.el"))

(add-to-list 'load-path (at-config-basedir "rc"))
(add-to-list 'load-path (at-config-basedir "bundles"))

(mapcar 'load
        (mapcar
         (lambda (path) (concat config-basedir path))
         '("rc-el-get.el"
           "constants.el"
           "credentials.el.gpg"
           )))

(mapcar 'load
  (all-files-under-dir-recursively
   (concat config-basedir "customdefs")))

(load (concat config-basedir "systemtraits.el"))

(require 'bundle-main)

(mapcar 'load
        (mapcar
         (lambda (path) (concat config-basedir path))
         '("rc-auto-modes.el"
           "rc-desktop.el"
           )))
