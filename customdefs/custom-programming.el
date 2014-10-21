(defvar flake8-conf-alist nil
  "Alist of flake8 configuration files for various projects")

;FIXME: try to use flycheck's builtin functionality
(defun find-project-flake8-config ()
  (let* ((project-root (file-truename (custom/project-root default-directory)))
         (config-path (cdr (assoc (file-name-base (directory-file-name project-root)) flake8-conf-alist))))
    (if (file-name-absolute-p config-path)
        (when (file-exists-p config-path)
          config-path)
      (concat project-root config-path))))
