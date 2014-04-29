;; -*- coding: utf-8 -*-
;;
;; Filename: defun-javascript.el
;; Created: Вт апр 29 22:52:08 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (defadvice js2r-inline-var (after reindent-buffer activate)
;;   (cleanup-buffer))

;; (defun js2-hide-test-functions ()
;;   (interactive)
;;   (save-excursion
;;     (goto-char (point-min))
;;     (ignore-errors
;;       (while (re-search-forward "\"[^\"]+\": function (")
;;         (js2-mode-hide-element)))))

;; ;; js2-mode steals TAB, let's steal it back for yasnippet
;; (defun js2-tab-properly ()
;;   (interactive)
;;   (let ((yas/fallback-behavior 'return-nil))
;;     (unless (yas/expand)
;;       (indent-for-tab-command)
;;       (if (looking-back "^\s*")
;;           (back-to-indentation)))))

;; (defun cjsp--eldoc-innards (beg)
;;   (save-excursion
;;     (goto-char beg)
;;     (search-forward "=")
;;     (let ((start (point)))
;;       (search-forward "*/")
;;       (forward-char -2)
;;       (buffer-substring-no-properties start (point)))))

;; (defun cjsp--indentation-of-html-line (html line-number)
;;   (with-temp-buffer
;;     (insert html)
;;     (html-mode)
;;     (indent-region (point-min) (point-max))
;;     (goto-line line-number)
;;     (back-to-indentation)
;;     (current-column)))

;; (defun cjsp--line-number-in-eldoc (p beg)
;;   (save-excursion
;;     (goto-char p)
;;     (let ((l (line-number-at-pos)))
;;       (goto-char beg)
;;       (- l (line-number-at-pos) -1))))

;; (defun js2-lineup-comment (parse-status)
;;   "Indent a multi-line block comment continuation line."
;;   (let* ((beg (nth 8 parse-status))
;;          (first-line (js2-same-line beg))
;;          (p (point))
;;          (offset (save-excursion
;;                    (goto-char beg)
;;                    (cond

;;                     ((looking-at "/\\*:DOC ")
;;                      (+ 2 (current-column)
;;                         (cjsp--indentation-of-html-line
;;                          (cjsp--eldoc-innards beg)
;;                          (cjsp--line-number-in-eldoc p beg))))

;;                     ((looking-at "/\\*")
;;                      (+ 1 (current-column)))

;;                     (:else 0)))))
;;     (unless first-line
;;       (indent-line-to offset))))

;;(mark-js2-in-right-window
;; (js2-node-at-point)) ;; js2-name-node


;; (define-key js2-mode-map (kbd "C-c RET jt") 'jump-to-test-file)
;; (define-key js2-mode-map (kbd "C-c RET ot") 'jump-to-test-file-other-window)
;; (define-key js2-mode-map (kbd "C-c RET js") 'jump-to-source-file)
;; (define-key js2-mode-map (kbd "C-c RET os") 'jump-to-source-file-other-window)
;; (define-key js2-mode-map (kbd "C-c RET jo") 'jump-between-source-and-test-files)
;; (define-key js2-mode-map (kbd "C-c RET oo") 'jump-between-source-and-test-files-other-window)

;; (define-key js2-mode-map (kbd "C-c RET ta") 'toggle-assert-refute)
;; (define-key js2-mode-map (kbd "TAB") 'js2-tab-properly)

;; ;; Don't redefine C-a for me please, js2-mode
;; (define-key js2-mode-map (kbd "C-a") nil)
;; ;; When renaming/deleting js-files, check for corresponding testfile
;; (define-key js2-mode-map (kbd "C-x C-r") 'js2r-rename-current-buffer-file)
;; (define-key js2-mode-map (kbd "C-x C-k") 'js2r-delete-current-buffer-file)
;; (define-key js2-mode-map (kbd "C-c t") 'js2-hide-test-functions)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; defun-javascript.el ends here
