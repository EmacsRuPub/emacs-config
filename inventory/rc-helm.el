;;; rc-helm.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'helm-config)
(require 'helm-gtags)
(require 'helm-files)
(require 'helm-info)
(require 'helm-locate)
(require 'helm-misc)

(helm-mode 1)

(setq enable-recursive-minibuffers t)

(setq helm-gtags-ignore-case t)
(setq helm-gtags-read-only t)
(setq helm-gtags-auto-update t)

(add-hook 'php-mode-hook 'helm-gtags-mode)
;; (add-hook 'helm-gtags-mode-hook
;;           '(lambda ()
;;               (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
;;               (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
;;               (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
;;               (local-set-key (kbd "M-g M-p") 'helm-gtags-parse-file)
;;               (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)))

(defun custom-helm ()
  (interactive)
  (helm-other-buffer '(
                       helm-c-source-buffer-not-found
                       helm-c-source-buffers-list
                       helm-source-bookmarks
                       helm-source-bookmark-set
                       helm-source-jabber-contacts
                       helm-c-source-files-in-current-dir
                       helm-c-source-recentf
                       helm-source-file-name-history
                       helm-source-minibuffer-history
                       helm-source-occur
                       helm-source-locate
                       )
                     "*helm-custom*"))

(global-set-key (kbd "C-&") 'custom-helm)

(provide 'rc-helm)

;;; rc-helm.el ends here
