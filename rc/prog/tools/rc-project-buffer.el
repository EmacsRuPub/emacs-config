;;; rc-project-buffer.el --- 

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(add-to-list 'load-path custom-ext-path/project-buffer-mode)

(require 'iproject)
(iproject-key-binding)

(eval-after-load "project-buffer-mode"
	'(progn
		 (require 'project-buffer-mode+)
		 (require 'project-buffer-occur)
		 (project-buffer-mode-p-setup)
		 (define-key project-buffer-mode-map [(control ?f)]
			 'project-buffer-occur)
		 ))

;;; rc-project-buffer.el ends here
