;;; rc-devel-notes.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'devel-notes)

(setq develnotes-file (concat org-dir "/devel-notes.org"))

(global-set-key "\C-cxa" 'develnotes-add-annotation)
(global-set-key "\C-cxv" 'develnotes-visit-file)
(global-set-key "\C-cxt" 'develnotes-add-TODO)
(global-set-key "\C-cxf" 'develnotes-add-FIXME)

(provide 'rc-tools-devel-notes)

;;; rc-devel-notes.el ends here
