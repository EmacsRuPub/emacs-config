;;; emacs-rc-desktop.el --- Load desktop settings

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'desktop)
(eval-when-compile
  (require 'cl))


;#############################################################################
;#   Custom defuns
;############################################################################

(defun desktop-autosave-save ()
  (desktop-save-in-desktop-dir))
(add-hook 'auto-save-hook (lambda () (desktop-autosave-save)))

(defun my-desktop-ignore-semantic (desktop-buffer-file-name)
  "Function to ignore cedet minor modes during restore of buffers"
  nil)


;#############################################################################
;#   Desktop-related variables
;############################################################################
(setq-default desktop-missing-file-warning nil)
(setq-default desktop-path '("~"))
(setq-default desktop-save t)
(setq-default desktop-save-mode t)
(setq-default save-place t)
(setq history-length 250)
(setq desktop-buffers-not-to-save
      (concat "\\(" "^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\|^tags\\|^TAGS"
              "\\|\\.emacs.*\\|\\.diary\\|\\.newsrc-dribble\\|\\.bbdb"
              "\\)$"))


;#############################################################################
;#   Desktop load setup
;############################################################################
(desktop-save-mode t)

(when (fboundp 'desktop-load-default)
  (desktop-load-default)
  (mapcar
   (lambda (symbol)
     (add-to-list 'desktop-globals-to-save symbol))
   '((buffer-name-history      . 100)
     (dired-regexp-history     . 20)
     (extended-command-history . 100)
     (file-name-history        . 500)
     (grep-history             . 50)
     (minibuffer-history       . 100)
     (query-replace-history    . 60)
     (read-expression-history  . 60)
     (regexp-history           . 60)
     (regexp-search-ring       . 20)
     (search-ring              . 20)
     (shell-command-history    . 50)))
  (desktop-read)
  )


;#############################################################################
;#   Desktop list customizations
;############################################################################
(add-to-list 'desktop-globals-to-save 'file-name-history)
(add-to-list 'desktop-locals-to-save 'buffer-file-coding-system)
(add-to-list 'desktop-locals-to-save 'tab-width)
(add-to-list 'desktop-locals-to-save 'buffer-file-coding-system)
(add-to-list 'desktop-minor-mode-handlers '(semantic-stickyfunc-mode . my-desktop-ignore-semantic))
(add-to-list 'desktop-minor-mode-handlers '(senator-minor-mode . my-desktop-ignore-semantic))
(add-to-list 'desktop-minor-mode-handlers '(semantic-idle-scheduler-mode . my-desktop-ignore-semantic))
(add-to-list 'desktop-minor-mode-handlers '(semantic-idle-summary-mode . my-desktop-ignore-semantic))
(add-to-list 'desktop-minor-mode-handlers '(semantic-idle-completions-mode . my-desktop-ignore-semantic))
(add-to-list 'desktop-minor-mode-handlers '(semantic-mru-bookmark-mode . my-desktop-ignore-semantic))
(add-to-list 'desktop-minor-mode-handlers '(semantic-decoration-mode . my-desktop-ignore-semantic))
(add-to-list 'desktop-minor-mode-handlers '(srecode-minor-mode . my-desktop-ignore-semantic))
(add-to-list 'desktop-minor-mode-handlers '(ede-minor-mode . my-desktop-ignore-semantic))
(add-to-list 'desktop-modes-not-to-save 'dired-mode)
(add-to-list 'desktop-modes-not-to-save 'Info-mode)
(add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
(add-to-list 'desktop-modes-not-to-save 'fundamental-mode)

(provide 'desktop-autosave)

;;; emacs-rc-desktop.el ends here
