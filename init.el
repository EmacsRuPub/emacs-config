(defun solidload (filename)
  (condition-case err
      (load filename)
    (error (display-warning 'initialization (concat "Load of " filename " failed "
                                                    (prin1-to-string err)) :warning))))

(setq config-basedir "/Users/octocat/.emacs.d")
(setq message-log-max t)

(setq el-get-sources-system-file
  (concat config-basedir "/el-get-sources-system.el"))

(solidload (concat config-basedir "/rc-el-get.el"))
(solidload (concat config-basedir "/ext/load-ext-manual.el"))
(solidload (concat config-basedir "/defuns/defuns.el"))
(setq custom-file (concat config-basedir "/customizations.el"))
(solidload (concat config-basedir "/constants.el"))
(solidload (concat config-basedir "/credentials.el"))

(solidload (concat config-basedir "/emacs-rc-auto-mode.el"))

(let ((default-directory (concat config-basedir "/rc")))
  (normal-top-level-add-subdirs-to-load-path))
(solidload (concat config-basedir "/bundle.el"))

(solidload (concat config-basedir "/rc-desktop.el"))

(load custom-file)
