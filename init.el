(setq config-basedir (file-name-directory
                      (or (buffer-file-name) load-file-name)))

(defun at-config-basedir (&optional suffix)
  (concat config-basedir suffix))

(org-babel-load-file (at-config-basedir "config.org"))
