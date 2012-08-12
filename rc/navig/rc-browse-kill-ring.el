;;; rc-browse-kill-ring.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'browse-kill-ring)

(global-set-key (kbd "C-c k") 'browse-kill-ring)

(provide 'rc-browse-kill-ring)

;;; rc-browse-kill-ring.el ends here
