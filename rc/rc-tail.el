;;; rc-tail.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'tail)

(setq tail-max-size 20)

(global-set-key (kbd "C-c t f") 'tail-file)

(provide 'rc-tail)

;;; rc-tail.el ends here
