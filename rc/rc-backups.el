;;; rc-backups.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(defconst emacs-tmp-dir "~/.emacs-backups")

(setq backup-by-copying t)              ; don't clobber symlinks
(setq backup-by-copying-when-linked t)  ; Copy linked files, don't rename.
(setq backup-directory-alist `(("." . ,emacs-tmp-dir)))    ; don't litter my fs tree
(setq auto-save-file-name-transforms `((".*" ,emacs-tmp-dir t)))
(setq delete-old-versions t)
(setq kept-new-versions 16)
(setq kept-old-versions 2)
(setq version-control t)               ; use versioned backups

(provide 'rc-backups)
;;; rc-backups.el ends here
