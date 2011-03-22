(defun solidload (filename)
  (condition-case err
      (load filename)
    (error (display-warning 'initialization (concat "Load of " filename " failed "
                                                    (prin1-to-string err)) :warning))))

(setq message-log-max t)

(setq custom-file "~/.emacs.d/customizations.el")

(add-to-list 'load-path "~/site-lisp")
(solidload "~/.emacs.d/constants.el")
(solidload "~/.emacs.d/credentials.el")
;; Initializing
(solidload "~/.emacs.d/emacs-rc-auto-mode.el")
;; ============
(solidload "~/.emacs.d/rc/modes/modes.el")
(solidload "~/.emacs.d/rc/core/core.el")
(solidload "~/.emacs.d/rc/util/util.el")
(solidload "~/.emacs.d/rc/abbrev/abbrev.el")
(solidload "~/.emacs.d/rc/access/access.el")
(solidload "~/.emacs.d/rc/edit/edit.el")
(solidload "~/.emacs.d/rc/interop/interop.el")
(solidload "~/.emacs.d/rc/prog/prog.el")
(solidload "~/.emacs.d/rc/org/org.el")
(solidload "~/.emacs.d/rc/publish/publish.el")
(solidload "~/.emacs.d/rc/extras/extras.el")

(load custom-file)

