;; -*- coding: utf-8 -*-
;;
;; Filename: rc-prodigy.el
;; Created: Ср фев 12 16:30:14 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'prodigy)

(prodigy-define-service
  :name "Mount Magrathea"
  :command "/home/octocat/workspace/mount-teleschool-loc.sh"
  :cwd "/home/octocat/workspace"
  :tags '(work))

(provide 'rc-prodigy)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-prodigy.el ends here
