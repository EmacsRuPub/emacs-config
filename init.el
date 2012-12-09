(defun solidload (filename)
  (condition-case err
      (load filename)
    (error (display-warning 'initialization (concat "Load of " filename " failed "
                                                    (prin1-to-string err)) :warning))))

(setq message-log-max t)

(setq home-directory (getenv "HOME"))
(setq global-username "octocat")

(setq config-basedir (concat home-directory "/.emacs.d"))

(setq custom-file (concat config-basedir "/customizations.el"))

(let ((default-directory (concat config-basedir "/rc")))
  (normal-top-level-add-subdirs-to-load-path))
(add-to-list 'load-path (concat config-basedir "/defuns"))

(mapcar 'solidload
        (mapcar
         (lambda (path) (concat config-basedir path))
         '("/rc-el-get.el"
           "/ext/load-ext-manual.el"
           "/defuns.el"
           "/constants.el"
           "/credentials.el"
           "/bundle.el"
           "/emacs-rc-auto-mode.el"
           "/rc-desktop.el")
         ))

(load custom-file)
