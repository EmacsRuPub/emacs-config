(setq config-basedir (file-name-directory
                      (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path (concat config-basedir "system"))

(load-library "base")
(load-library "pathutil")

(reverse-input-method 'russian-computer)

(setq shell-file-name "/bin/bash")

(setq message-log-max t)

(setq custom-file (at-config-basedir "customizations.el"))

(add-to-list 'load-path (at-config-basedir "rc"))
(add-to-list 'load-path (at-config-basedir "bundles"))

(mapcar 'load
        (mapcar
         (lambda (path) (at-config-basedir path))
         '("rc-el-get.el"
           "constants.el"
           "credentials.el.gpg"
           )))

(require 'use-package)

(mapcar 'load
  (all-files-under-dir-recursively
   (at-config-basedir "customdefs")))

(load (at-config-basedir "systemtraits.el"))

(mapcar 'load
  (all-files-under-dir-recursively
   (at-config-basedir "private")))

(require 'bundle-main)

(mapcar 'load
        (mapcar
         (lambda (path) (at-config-basedir path))
         '("rc-auto-modes.el"
           "rc-desktop.el"
           )))
