;;; rc-command-log.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'command-log-mode)

(global-set-key (kbd "C-c C-l t") 'command-log-mode)
(global-set-key (kbd "C-c C-l b") 'clm/open-command-log-buffer)

;;; rc-command-log.el ends here
