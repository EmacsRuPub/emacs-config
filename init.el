(defun solidload (filename)
  (condition-case err
      (load filename)
    (error (display-warning 'initialization (concat "Load of " filename " failed "
                                                    (prin1-to-string err)) :warning))))

;(defun solidload (filename)
;  (condition-case err
;      (load filename)
;    (error (backtrace))))

;; (setq debug-on-error t)
;; (setq stack-trace-on-error t)

(setq message-log-max t)

(setq home-directory (getenv "HOME"))
(setq global-username user-login-name)

(setq config-basedir (file-name-directory
                      (or (buffer-file-name) load-file-name)))

(setq custom-file (concat config-basedir "customizations.el"))

(add-to-list 'load-path (concat config-basedir "rc"))

;; For a new non-file buffer set its major mode based on the buffer name.
;; http://thread.gmane.org/gmane.emacs.devel/115520/focus=115794
;; (setq-default major-mode (lambda ()
;;                            (if buffer-file-name
;;                                (fundamental-mode)
;;                              (let ((buffer-file-name (buffer-name)))
;;                                (set-auto-mode)))))

(mapcar 'solidload
        (mapcar
         (lambda (path) (concat config-basedir path))
         '("rc-el-get.el"
           "ext/load-ext-manual.el"
           "constants.el"
           "credentials.el"
           "bundle.el"
           "emacs-rc-auto-mode.el"
           "rc-desktop.el")
         ))

(load custom-file)
