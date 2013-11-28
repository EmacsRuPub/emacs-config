;;; emacs-rc-bbdb.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'bbdb)

(setq bbdb-use-pop-up nil)
(setq bbdb-sounds-directory nil)
(setq news-reply-header-hook nil)
(setq bbdb-offer-save (quote savenoprompt)) ;'automatic
(setq bbdb-north-american-phone-numbers-p nil)
(setq bbdb-complete-name-allow-cycling t)
(setq bbdb-quiet-about-name-mismatches t)
(setq bbdb-use-alternate-names nil)
(setq bbdb-dwim-net-address-allow-redundancy t)
(setq bbdb-phone-style 'nil)
(setq bbdb-file '"~/.database.bbdb")

(setq bbdb-readonly-p nil)
(setq bbdb-completion-display-record nil)
(setq bbdb/mail-auto-create-p 'bbdb-ignore-most-messages-hook)
(setq bbdb-change-hook 'bbdb-timestamp-hook)
(setq bbdb-notice-hook 'bbdb-auto-notes-hook)

;; complete from bbdb
(defun my-bbdb-tab-complete ()
  (interactive)
  (if (mail-abbrev-in-expansion-header-p)
      (bbdb-complete-name)
    (message-tab)))
(define-key message-mode-map (kbd "<tab>") 'my-bbdb-tab-complete)

(add-to-list 'file-coding-system-alist (cons "\\.bbdb"  'utf-8))

(global-set-key (kbd "C-c C-b c") 'bbdb-create)
(global-set-key (kbd "C-c C-b s") 'bbdb)

(defun my-bbdb-mode-hook ()
  (local-set-key (kbd "C-c C-e") 'bbdb-edit-current-field)
  (local-set-key (kbd "C-c C-d") 'bbdb-delete-current-record)
  (local-set-key (kbd "C-c C-f d") 'bbdb-delete-current-field-or-record)
  (local-set-key (kbd "C-c C-f i") 'bbdb-insert-new-field)
  )
(add-hook 'bbdb-mode-hook 'my-bbdb-mode-hook)

(define-coding-system-alias 'utf-8-emacs 'utf-8) ; needed by bbdb...

(provide 'rc-bbdb)

;;; emacs-rc-bbdb.el ends here
