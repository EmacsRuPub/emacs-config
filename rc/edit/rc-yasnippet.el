;;; rc-yasnippet.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory custom/yasnippet-dir)

;; hook for automatic reloading of changed snippets
(defun update-yasnippets-on-save ()
  (when (string-match "/resources/yasnippet" buffer-file-name)
    (yas/load-directory custom/yasnippet-dir)))
(add-hook 'after-save-hook 'update-yasnippets-on-save)

(provide 'rc-yasnippet)

;;; rc-yasnippet.el ends here
