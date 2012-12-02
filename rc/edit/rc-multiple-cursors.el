;;; rc-multiple-cursors.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c C-.") 'mc/mark-all-like-this-in-defun)
(global-set-key (kbd "C-c C->") 'mc/mark-all-like-this-dwim)
(global-set-key (kbd "C-c C-,") 'set-rectangular-region-anchor)

(provide 'rc-multiple-cursors)

;;; rc-multiple-cursors.el ends here
