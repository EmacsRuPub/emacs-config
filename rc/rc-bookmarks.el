;;; rc-bookmarks.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;; TODO: See if we can customize Bookmarks[+] further

;#############################################################################
;#   Load Extensions
;############################################################################

(require 'bookmark+)
(require 'crosshairs)
(require 'breadcrumb)

(eval-after-load "bm"
  '(progn
     (setq bc-bookmark-limit 1000)
     (setq bm-restore-repository-on-load t)
     (setq-default bm-buffer-persistence t) ;; make bookmarks persistent as default
     (add-hook' after-init-hook 'bm-repository-load) ;; Loading the repository from file when on start up.
     (add-hook 'find-file-hooks 'bm-buffer-restore) ;; Restoring bookmarks when on file find.
     (add-hook 'kill-buffer-hook 'bm-buffer-save) ;; Saving bookmark data on killing a buffer
     ;; Saving the repository to file when on exit.
     ;; kill-buffer-hook is not called when emacs is killed, so we
     ;; must save all bookmarks first.
     (add-hook 'kill-emacs-hook '(lambda nil
                                   (bm-buffer-save-all)
                                   (bm-repository-save)))
     (set-face-attribute 'bm-face nil :foreground "yellow" :inverse-video nil)
     (set-face-attribute 'bm-persistent-face nil :foreground "yellow" :inverse-video nil)
     (global-set-key (kbd "<M-f2>") 'bm-toggle)
     (global-set-key (kbd "<f2>")   'bm-next)
     (global-set-key (kbd "<S-f2>") 'bm-previous)
     ))

(provide 'rc-bookmarks)

;;; rc-bookmarks.el ends here
