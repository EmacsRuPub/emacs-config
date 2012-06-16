;;; rc-command-log.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'command-log-mode)
;; (add-hook 'LaTeX-mode-hook 'command-log-mode)

(global-set-key "\C-c\C-l" 'clm/open-command-log-buffer)

;;; rc-command-log.el ends here
