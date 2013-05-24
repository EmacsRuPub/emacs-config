;;; rc-rebox2.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'rebox2)
(global-set-key (kbd "M-q") 'rebox-dwim)
(global-set-key (kbd "S-M-q") 'rebox-cycle)

(provide 'rc-rebox2)

;;; rc-rebox2.el ends here
