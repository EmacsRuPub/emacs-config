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

(defun js2-print-json-path ()
  "Print the path to the JSON value under point, and save it in the kill ring."
  (interactive)
  (let (next-node node-type rlt key-name)
    (setq next-node (js2-node-at-point))
    ;; scanning from AST, no way to optimise `js2-node-at-point'
    (while (and next-node (arrayp next-node) (> (length next-node) 5))
      (setq node-type (aref next-node 0))
      (cond
       ;; json property node
       ((eq node-type 'cl-struct-js2-object-prop-node)
        (setq key-name (js2-prop-node-name (js2-object-prop-node-left next-node)))
        (if rlt (setq rlt (concat "." key-name rlt))
          (setq rlt (concat "." key-name))))

       ;; array node
       ((or (eq node-type 'cl-struct-js2-array-node)
            (eq node-type 'cl-struct-js2-infix-node))
        (if rlt (setq rlt (concat "[0]" rlt))
          (setq rlt "[0]")))

       (t)) ; do nothing

      ;; get parent node
      (setq next-node (aref next-node 5)))
    ;; clean final result
    (setq rlt (replace-regexp-in-string "^\\." "" rlt))
    (when rlt
      (kill-new rlt)
      (message "%s => kill-ring" rlt))
    rlt))

)

(provide 'custom-programming)
