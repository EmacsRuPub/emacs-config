;;; rc-hexview.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'hexview-mode)

(global-set-key (kbd "C-c h v") 'hexview-find-file)

(provide 'rc-hexview)

;;; rc-hexview.el ends here
