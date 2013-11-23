;; -*- coding: utf-8 -*-
;;
;; Filename: rc-wanderlust.el
;; Created: Вт сен 17 21:06:40 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Reading f=f
;; (autoload 'fill-flowed "flow-fill")
;; (add-hook 'mime-display-text/plain-hook
;;           (lambda ()
;;             (when (string= "flowed"
;;                            (cdr (assoc "format"
;;                                        (mime-content-type-parameters
;;                                         (mime-entity-content-type entity)))))
;;               (fill-flowed))))

;; (mime-edit-insert-tag "text" "plain" "; format=flowed")




;; (add-hook 'wl-summary-mode-hook 'mc-install-read-mode)
;; (add-hook 'wl-mail-setup-hook 'mc-install-write-mode)


;; (eval-after-load "mailcrypt"
;;   '(setq mc-modes-alist
;;          (append
;;           (quote
;;            ((wl-draft-mode (encrypt . mc-encrypt-message)
;;                            (sign . mc-sign-message))
;;             (wl-summary-mode (decrypt . mc-wl-decrypt-message)
;;                              (verify . mc-wl-verify-signature))))
;;           mc-modes-alist)))


;; ;;Cobbled together from posts by Erik Hetzner & Harald Judt to
;; ;; wl-en@lists.airs.net by Jonathan Groll (msg 4128)

;; (defun mime-edit-insert-multiple-files ()
;;   "Insert MIME parts from multiple files."
;;   (interactive)
;;   (let ((dir default-directory))
;;     (let ((next-file (expand-file-name
;;                       (read-file-name "Insert file as MIME message: "
;;                                       dir))))
;;       (setq file-list (file-expand-wildcards next-file))
;;       (while (car file-list)
;;         (mime-edit-insert-file (car file-list))
;;         (setq file-list (cdr file-list))))))

;; (global-set-key "\C-c\C-x\C-a" 'mime-edit-insert-multiple-files)

;; (add-hook
;;  'mime-view-mode-hook
;;  '(lambda ()
;;     "Disable 'v' for mime-play."
;;     ;; Key bindings
;;     (local-set-key [?v] () )
;;     ))

;; (setq wl-summary-showto-folder-regexp ".*Sent.*")

;; ;; You should set this variable if you use multiple e-mail addresses.
;; (setq wl-user-mail-address-list  '("my.name@gmail.com"
;;                                    "myname@gmail.com"
;;                                    "myname@company.com"))

;; ;; sort the summary
;; (defun my-wl-summary-sort-hook ()
;;   (wl-summary-rescan "date"))

;; (add-hook 'wl-summary-prepared-hook 'my-wl-summary-sort-hook)

;; ;;don't remember "n"/"p" direction when flagging messages:
;; (setq wl-summary-move-direction-toggle nil)

;; (require 'w3m)
;; (require 'mime-w3m)

;; (eval-after-load "w3m"
;;   '(progn
;;      (define-key w3m-mode-map [left] 'backward-char)
;;      (define-key w3m-mode-map [right] 'forward-char)
;;      (define-key w3m-mode-map [up] 'previous-line)
;;      (define-key w3m-mode-map [down] 'next-line)
;;      (define-key w3m-minor-mode-map [left] 'backward-char)
;;      (define-key w3m-minor-mode-map [right] 'forward-char)
;;      (define-key w3m-minor-mode-map [up] 'previous-line)
;;      (define-key w3m-minor-mode-map [down] 'next-line)
;;      ))

;; (setq wl-summary-search-parent-by-subject-regexp nil)

;; (setq wl-use-folder-petname '(modeline read-folder))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-wanderlust.el ends here
