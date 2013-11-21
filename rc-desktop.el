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
(setq-default desktop-path (quote ("~")))
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

;; ;; DESKTOP
;; (desktop-save-mode t)
;; (setq history-length 250
;;       desktop-path '("~/.emacs.d/"))
;; (add-to-list 'desktop-globals-to-save 'file-name-history)
;; (add-to-list 'desktop-modes-not-to-save 'Info-mode)
;; (add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
;; (global-set-key (kbd "M-P") 'my-desktop-change)


;; ;;; http://scottfrazersblog.blogspot.ru/2009/12/emacs-named-desktop-sessions.html

;; (require 'desktop)

;; (defvar my-desktop-session-dir
;;   (concat (getenv "HOME") "/.emacs.d/desktop-sessions/")
;;   "*Directory to save desktop sessions in")

;; (defvar my-desktop-session-name-hist nil
;;   "Desktop session name history")

;; (defun my-desktop-save (&optional name)
;;   "Save desktop by name."
;;   (interactive)
;;   (unless name
;;     (setq name (my-desktop-get-session-name "Save session" t)))
;;   (when name
;;     (make-directory (concat my-desktop-session-dir name) t)
;;     (desktop-save (concat my-desktop-session-dir name) t)))

;; (defun my-desktop-save-and-clear ()
;;   "Save and clear desktop."
;;   (interactive)
;;   (call-interactively 'my-desktop-save)
;;   (desktop-clear)
;;   (setq desktop-dirname nil))

;; (defun my-desktop-read (&optional name)
;;   "Read desktop by name."
;;   (interactive)
;;   (unless name
;;     (setq name (my-desktop-get-session-name "Load session")))
;;   (when name
;;     (desktop-clear)
;;     (desktop-read (concat my-desktop-session-dir name))))

;; (defun my-desktop-change (&optional name)
;;   "Change desktops by name."
;;   (interactive)
;;   (let ((name (my-desktop-get-current-name)))
;;     (when name
;;       (my-desktop-save name))
;;     (call-interactively 'my-desktop-read)))

;; (defun my-desktop-name ()
;;   "Return the current desktop name."
;;   (interactive)
;;   (let ((name (my-desktop-get-current-name)))
;;     (if name
;;         (message (concat "Desktop name: " name))
;;       (message "No named desktop loaded"))))

;; (defun my-desktop-get-current-name ()
;;   "Get the current desktop name."
;;   (when desktop-dirname
;;     (let ((dirname (substring desktop-dirname 0 -1)))
;;       (when (string= (file-name-directory dirname) my-desktop-session-dir)
;;         (file-name-nondirectory dirname)))))

;; (defun my-desktop-get-session-name (prompt &optional use-default)
;;   "Get a session name."
;;   (let* ((default (and use-default (my-desktop-get-current-name)))
;;          (full-prompt (concat prompt (if default
;;                                          (concat " (default " default "): ")
;;                                        ": "))))
;;     (completing-read full-prompt (and (file-exists-p my-desktop-session-dir)
;;                                       (directory-files my-desktop-session-dir))
;;                      nil nil nil my-desktop-session-name-hist default)))

;; (defun my-desktop-kill-emacs-hook ()
;;   "Save desktop before killing emacs."
;;   (when (file-exists-p (concat my-desktop-session-dir "last-session"))
;;     (setq desktop-file-modtime
;;           (nth 5 (file-attributes (desktop-full-file-name (concat my-desktop-session-dir "last-session"))))))
;;   (my-desktop-save "last-session"))

;; (add-hook 'kill-emacs-hook 'my-desktop-kill-emacs-hook)

;; (when (require 'session nil t)
;;   (add-hook 'after-init-hook 'session-initialize)
;;   (add-to-list 'session-globals-exclude 'org-mark-ring))

;; (if iy-backup-enable-desktop
;;     (progn
;;       (desktop-save-mode 1)
;;       (setq history-length 250)
;;       (add-to-list 'desktop-globals-to-save 'file-name-history)
;;       (add-to-list 'desktop-modes-not-to-save 'Info-mode)
;;       (add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
;;       (add-to-list 'desktop-modes-not-to-save 'fundamental-mode)))

;; (recentf-mode)

;; (push 'pick-backup el-get-packages)

;; (provide 'iy-backup)
