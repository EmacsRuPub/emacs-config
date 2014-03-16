;; -*- coding: utf-8 -*-
;;
;; Filename: rc-helm.el
;; Created: Ср мар  5 17:09:05 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'helm-files)
(require 'helm-info)
(require 'helm-locate)
(require 'helm-misc)

(defun custom-helm ()
  (interactive)
  (helm-other-buffer '(
                       helm-c-source-buffers-list
                       helm-c-source-files-in-current-dir
                       helm-c-source-recentf
                       helm-source-bookmarks
                       helm-source-file-name-history
                       helm-source-findutils
                       helm-source-locate
                       helm-source-occur
                       )
                     "*helm-custom*"))

(global-set-key (kbd "C-&") 'custom-helm)

(provide 'rc-helm)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-helm.el ends here
