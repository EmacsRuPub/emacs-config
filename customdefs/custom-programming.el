(define-namespace custom/

(defvar flake8-conf-alist nil
  "Alist of flake8 configuration files for various projects")

;;FIXME: try to use flycheck's builtin functionality
(defun find-project-flake8-config ()
  (let* ((project-root (file-truename (custom/project-root default-directory)))
         (config-path (cdr (assoc (file-name-base (directory-file-name project-root)) flake8-conf-alist))))
    (if (file-name-absolute-p config-path)
        (when (file-exists-p config-path)
          config-path)
      (concat project-root config-path))))

;; FIXME code duplication, think of finding the widely used util or something similar
(autoload 'vc-git-root "vc-git")
(autoload 'vc-svn-root "vc-svn")
(autoload 'vc-hg-root "vc-hg")

(defun project-root (file-path)
  "Guess the project root of the given FILE-PATH."
  (or (vc-git-root file-path)
      (vc-svn-root file-path)
      (vc-hg-root file-path)
      file-path))

(defun create-restclient-sandbox ()
  (interactive)
  (let ((restbuffer (generate-new-buffer "*restclient-sandbox*")))
    (switch-to-buffer restbuffer)
    (restclient-mode)))

)

(provide 'custom-programming)
