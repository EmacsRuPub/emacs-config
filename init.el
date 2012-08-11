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

(add-to-list 'load-path "~/site-lisp")
(solidload (concat config-basedir "/constants.el"))
(solidload (concat config-basedir "/credentials.el"))
;; Initializing
(solidload (concat config-basedir "/emacs-rc-auto-mode.el"))
;; ============
(solidload (concat config-basedir "/rc/modes/modes.el"))
(solidload (concat config-basedir "/rc/core/core.el"))
(solidload (concat config-basedir "/rc/util/util.el"))
(solidload (concat config-basedir "/rc/abbrev/abbrev.el"))
(solidload (concat config-basedir "/rc/access/assist.el"))
(solidload (concat config-basedir "/rc/navig/navig.el"))
(solidload (concat config-basedir "/rc/edit/edit.el"))
(solidload (concat config-basedir "/rc/interop/interop.el"))
(solidload (concat config-basedir "/rc/prog/prog.el"))
(solidload (concat config-basedir "/rc/org/org.el"))
(solidload (concat config-basedir "/rc/publish/publish.el"))
(solidload (concat config-basedir "/rc/extras/extras.el"))

(solidload (concat config-basedir "/rc-desktop.el"))

(load custom-file)

(put 'narrow-to-region 'disabled nil)
