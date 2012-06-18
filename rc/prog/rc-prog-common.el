;;; rc-prog-common.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load Extensions
;############################################################################
(autoload 'ediff-buffers "ediff" "Intelligent Emacs interface to diff" t)
(autoload 'ediff-files "ediff" "Intelligent Emacs interface to diff" t)
(autoload 'ediff-files-remote "ediff" "Intelligent Emacs interface to diff")

(autoload 'smerge-mode "smerge-mode" nil t)
(autoload 'po-mode "po-mode" "Major mode for translators to edit PO files" t)
(autoload 'gtags-mode "gtags" "" t)
(autoload 'footnote-mode "footnote" nil t) ;; footnote mode
;; (autoload 'paredit-mode "paredit" "Minor mode for pseudo-structurally editing Lisp code." t)
(autoload 'whitespace-mode "whitespace" "Toggle whitespace visualization."        t)
(autoload 'whitespace-toggle-options "whitespace" "Toggle local `whitespace-mode' options." t)

(require 'filecache)
(require 'imenu)
(require 'compile)
(require 'eldoc)


;#############################################################################
;#   Custom definitions
;############################################################################
(defvar qt-version-doc "4.7"
  "string representation of Qt version being used, for construcing URL for online documentation viewing")

(defun open-qt-docs ()
  (interactive)
  (setq symbol-to-search (symbol-at-point))
  (if (not (equal symbol-to-search nil))
      (browse-url (concat "http://doc.qt.nokia.com" "/" qt-version-doc "/" (format "%s" symbol-to-search) ".html"))
    nil)
)


;#############################################################################
;#   Customizations
;############################################################################
(setq text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
;; (eldoc-add-command 'paredit-backward-delete 'paredit-close-round)


;#############################################################################
;#   Keybindings
;############################################################################
(global-set-key (kbd "C-c w q") 'open-qt-docs)

;;; rc-prog-common.el ends here



