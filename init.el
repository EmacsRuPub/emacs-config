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
         '("constants.el"
           "credentials.el.gpg"
           )))

(load (at-config-basedir "system/packages.el"))

(require 'use-package)

(use-package f)

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
