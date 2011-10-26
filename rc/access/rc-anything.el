;;; rc-anything.el --- 

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extensions
;############################################################################

(require 'anything)
(require 'anything-config)
(require 'anything-extension)
(require 'anything-match-plugin)
(require 'anything-show-completion)


;#############################################################################
;#   Custom definitions
;############################################################################
(defvar anything-c-source-lacarte
  '((name . "Lacarte")
    (candidates
     . (lambda () (delete '(nil) (lacarte-get-overall-menu-item-alist))))
    (candidate-number-limit . 9999)
    (action . call-interactively)))

;; TODO: code below fails; fix it
;; have file name history keep out non-existent files
;; (let ((source (find-if
;;                (lambda (s)
;;                  (string= (cdr (assoc 'name s)) "File Name History"))
;;                anything-sources)))
;;   (setcdr (assoc 'candidates source)
;;           (lambda ()
;;             (remove-if-not 'file-exists-p file-name-history))))


;#############################################################################
;#   Variables
;############################################################################
(setq anything-idle-delay 0.2)
(setq anything-samewindow t)
(setq anything-input-idle-delay 0.2)
(setq anything-candidate-number-limit nil)
(setq anything-sources
      (list
       anything-c-source-file-name-history ;; !!REQUIRED!!
       anything-c-source-files-in-current-dir+
       anything-c-source-files-in-all-dired
       anything-c-source-file-cache
       anything-c-source-buffers+
       anything-c-source-buffer-not-found			 
       anything-c-source-bookmarks
       anything-c-source-register
       anything-c-source-fixme
       anything-c-source-create
       anything-c-source-recentf
       anything-c-source-occur
       anything-c-source-ffap-line
       anything-c-source-ffap-guesser
       anything-c-source-org-headline
       anything-c-source-calculation-result
       anything-c-source-locate
       anything-c-source-lacarte
       ))


;#############################################################################
;#   Keybindings
;############################################################################
(global-set-key "\C-xa" 'anything-at-point)

;;; rc-anything.el ends here
