(defun solidload (filename)
  (condition-case err
      (load filename)
    (error (display-warning 'initialization (concat "Load of " filename " failed "
                                                    (prin1-to-string err)) :warning))))

(setq message-log-max t)

(setq config-basedir "/Users/octocat/.emacs.d")

(setq custom-file (concat config-basedir "/customizations.el"))

(let ((default-directory (concat config-basedir "/rc")))
  (normal-top-level-add-subdirs-to-load-path))

(mapcar 'solidload
        (mapcar
         (lambda (path) (concat config-basedir path))
         '("/rc-el-get.el"
           "/ext/load-ext-manual.el"
           "/defuns/defuns.el"
           "/constants.el"
           "/credentials.el"
           "/bundle.el"
           "/emacs-rc-auto-mode.el"
           "/rc-desktop.el")
         ))

(load custom-file)
