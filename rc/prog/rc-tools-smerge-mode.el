;;; rc-smerge-mode.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(autoload 'smerge-mode "smerge-mode" nil t)

(defun sm-try-smerge ()
  (save-excursion
    (goto-char (point-min))
    (when (re-search-forward "^<<<<<<< " nil t)
      (smerge-mode 1))))
(add-hook 'find-file-hooks 'sm-try-smerge t)

(provide 'rc-smerge-mode)

;;; rc-smerge-mode.el ends here
