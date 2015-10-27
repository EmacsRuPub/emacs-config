;; https://gist.github.com/nyergler/6100112

(add-hook 'hack-local-variables-hook 'run-local-vars-mode-hook)
(defun run-local-vars-mode-hook ()
  "Run a hook for the major-mode after the local variables have been processed."
  (run-hooks (intern (concat (symbol-name major-mode) "-local-vars-hook"))))


(defun detect_buffer_venv (buffer-name)
  (let ((buffer-dir (file-name-directory buffer-name)))
    (while (and (not (file-exists-p
                      (concat buffer-dir "py27/bin/activate")))
                buffer-dir)
      (setq buffer-dir
            (if (equal buffer-dir "/")
                nil
              (file-name-directory (directory-file-name buffer-dir)))))
    ;; return the buffer-dir (or nil)
    (concat buffer-dir "py27")))

(defun detect_buffer_eggs_dirs (buffer-name)
  (let ((buffer-dir (file-name-directory buffer-name)))
    (while (and (not (file-exists-p
                      (concat buffer-dir "eggs")))
                buffer-dir
                )
      (setq buffer-dir
            (if (equal buffer-dir "/")
                nil
              (file-name-directory (directory-file-name buffer-dir)))))
    (if buffer-dir
        (directory-files (concat buffer-dir "eggs") t ".\.egg")
      nil)))

(setq additional_paths nil)

(defun setup-jedi-extra-args ()
  (let ((venv (detect_buffer_venv buffer-file-name))
        (egg-dirs (detect_buffer_eggs_dirs buffer-file-name)))
    (make-local-variable 'jedi:server-args)
    (when venv (set 'jedi:server-args (list "--virtual-env" venv)))
    (when egg-dirs
      (dolist (egg egg-dirs)
        (set 'jedi:server-args (append jedi:server-args (list "--sys-path" egg))))))
  (make-local-variable 'additional_paths)
  (when additional_paths
    (dolist (path additional_paths)
      (set 'jedi:server-args (append jedi:server-args (list "--sys-path" path))))))

(setq jedi:setup-keys t)

(add-hook 'python-mode-local-vars-hook 'setup-jedi-extra-args)
(add-hook 'python-mode-local-vars-hook 'jedi:setup)
