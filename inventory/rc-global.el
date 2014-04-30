;; -*- coding: utf-8 -*-
;;
;; Filename: rc-global.el
;; Created: Пт апр  5 01:00:03 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'gtags-mode "gtags" "" t)

(require 'xgtags)

(add-hook 'php-mode-hook (lambda () (ggtags-mode 1)))
;; (add-hook 'python-mode-hook (lambda () (ggtags-mode 1)))

;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
;;               (ggtags-mode 1))))

;; (defun gtags-root-dir ()
;;  "Returns GTAGS root directory or nil if doesn't exist."
;;  (with-temp-buffer
;;    (if (zerop (call-process "global" nil t nil "-pr"))
;;        (buffer-substring (point-min) (1- (point-max)))
;;      nil)))

;; (defun gtags-update ()
;;  "Make GTAGS incremental update"
;;  (call-process "global" nil nil nil "-u"))

;; (defun gtags-update-hook ()
;;  (when (gtags-root-dir)
;;    (gtags-update)))

;; (add-hook 'after-save-hook #'gtags-update-hook)

;; For projects with a huge amount of files, “global -u” can take a
;; very long time to complete. For changes in a single file, we can
;; update the tags with “gtags --single-update” and do it in the
;; background:

;; (defun gtags-update-single(filename)
;;  "Update Gtags database for changes in a single file"
;;  (interactive)
;;  (start-process "update-gtags" "update-gtags" "bash" "-c" (concat "cd " (gtags-root-dir) " ; gtags --single-update " filename )))

;; (defun gtags-update-current-file()
;;  (interactive)
;;  (defvar filename)
;;  (setq filename (replace-regexp-in-string (gtags-root-dir) "." (buffer-file-name (current-buffer))))
;;  (gtags-update-single filename)
;;  (message "Gtags updated for %s" filename))

;; (defun gtags-update-hook()
;;  "Update GTAGS file incrementally upon saving a file"
;;  (when gtags-mode
;;    (when (gtags-root-dir)
;;      (gtags-update-current-file))))

;; (add-hook 'after-save-hook 'gtags-update-hook)

(provide 'rc-global)

;; HELP keybindings
;; (define-key keymap "\C-cw" sub-keymap)
;; (define-key sub-keymap "d" 'xgtags-find-tag)
;; (define-key sub-keymap "c" 'xgtags-find-rtag)
;; (define-key sub-keymap "s" 'xgtags-find-symbol)
;; (define-key sub-keymap "g" 'xgtags-find-with-grep)
;; (define-key sub-keymap "i" 'xgtags-find-with-idutils)
;; (define-key sub-keymap "n" 'xgtags-select-next-tag)
;; (define-key sub-keymap "p" 'xgtags-select-prev-tag)
;; (define-key sub-keymap "\t" 'xgtags-make-complete-list)
;; (define-key sub-keymap "u" 'xgtags-pop-stack)
;; ;;   (define-key sub-keymap "" 'xgtags-find-tag-from-here)
;; (define-key sub-keymap "f" 'xgtags-find-file)
;; ;;   (define-key sub-keymap "" 'xgtags-display-browser)
;; (define-key sub-keymap "x" 'xgtags-switch-to-buffer)
;; (define-key sub-keymap "\C-x" 'xgtags-switch-to-buffer-other-window)
;; (define-key sub-keymap "r" 'xgtags-query-replace-regexp)
;; xgtags-select-mode-map
;; (define-key keymap "\e*" 'xgtags-pop-stack)
;; (define-key keymap "\^?" 'scroll-down)
;; (define-key keymap " " 'scroll-up)
;; (define-key keymap "\C-b" 'scroll-down)
;; (define-key keymap "\C-f" 'scroll-up)
;; (define-key keymap "k" 'previous-line)
;; (define-key keymap "j" 'next-line)
;; (define-key keymap "p" 'previous-line)
;; (define-key keymap "n" 'next-line)
;; (define-key keymap "q" 'xgtags-pop-stack)
;; (define-key keymap "u" 'xgtags-pop-stack)
;; (define-key keymap "\C-t" 'xgtags-pop-stack)
;; (define-key keymap "\C-m" 'xgtags-select-tag-near-point)
;; (define-key keymap "\e." 'xgtags-select-tag-near-point)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-global.el ends here
