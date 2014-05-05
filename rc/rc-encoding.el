;;; rc-encoding.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(prefer-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8 'utf-8-unix)
(set-default buffer-file-coding-system 'utf-8-unix)
(set-default default-buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

(provide 'rc-encoding)

;;; rc-encoding.el ends here
