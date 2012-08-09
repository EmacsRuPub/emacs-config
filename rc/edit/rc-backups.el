;;; rc-backups.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(setq backup-by-copying t              ; don't clobber symlinks
      backup-by-copying-when-linked t  ; Copy linked files, don't rename.
      backup-directory-alist
      '(("." . "~/.emacs-backups"))    ; don't ; litter my fs tree
      auto-save-file-name-transforms nil
      delete-old-versions t
      kept-new-versions 16
      kept-old-versions 2
      version-control t)               ; use versioned backups

;;; rc-backups.el ends here
