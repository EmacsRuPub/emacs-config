;; -*- coding: utf-8 -*-
;;
;; Filename: custom-navigate.el
;; Created: Вс июн  1 21:30:30 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-namespace custom/

(defun helm-find-files ()
  (interactive)
  (helm-other-buffer '(
                       helm-source-files-in-current-dir
                       helm-source-recentf
                       helm-source-file-name-history
                       helm-source-findutils
                       helm-source-locate
                       )
                     "*helm-find-files*"))

(defun occur-and-switch (search)
  (interactive "sSearch for: ")
  (occur (regexp-quote search))
  (switch-to-buffer-other-window "*Occur*"))

(defun isearch-occur ()
  (interactive)
  (let ((case-fold-search isearch-case-fold-search))
    (occur-and-switch (if isearch-regexp isearch-string
                        (regexp-quote isearch-string)))))

(defadvice occur-mode-goto-occurrence (after close-occur activate)
  (delete-other-windows))

(defvar suppress-projectile-symbol-at-point nil
  "Whether to suppress inserting symbol at point while using projectile searches")

(defadvice projectile-symbol-at-point (around projectile-suppress-symbol-at-point activate)
  (if suppress-projectile-symbol-at-point
      (setq ad-return-value "")
    (setq ad-return-value ad-do-it)))

(defun projectile-ag (arg)
  (interactive "p")
  (message "arg: %s" arg)
  (if (equal arg 4)
      (setq suppress-projectile-symbol-at-point t)
    (setq suppress-projectile-symbol-at-point nil))
  (call-interactively 'projectile-ag))

;;TODO: make implemetation less straightforward or find "right way" to do it
(defun process-thing-at-point ()
  (interactive)
  (cond
   ((equal major-mode 'ag-mode) (compile-goto-error))
   ((or (equal major-mode 'jabber-chat-mode)
        (equal major-mode 'erc-mode)) (browse-url (thing-at-point 'url t)))
   (t (browse-url (thing-at-point 'url t)))))

(defun open-urls-in-region (beg end)
  "Open URLs between BEG and END."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (re-search-forward org-plain-link-re nil t)
        (org-open-at-point)))))

(defun spawn-buffer()
  (interactive)
  (let ((buffer-name (generate-new-buffer-name "*new-buffer*")))
    (generate-new-buffer buffer-name)
    (switch-to-buffer buffer-name)))

(defun ibuffer-filter-by-extname (qualifier)
  (interactive "sFilter by extname: ")
  (ibuffer-filter-by-filename (concat "\\." qualifier "$")))

(defun update-frames (heads-count)
  (let ((frames-count (length (frame-list))))
    (cond
     ((= heads-count 2)
      (when (= frames-count 1)
        (make-frame-command)))
     ((= heads-count 1)
      (when (> frames-count 1)
        (delete-other-frames)))
     (t
      (delete-other-frames)))))

;;Make cursor stay in the same column when scrolling using pgup/dn.
;;Previously pgup/dn clobbers column position, moving it to the
;;beginning of the line.
;;<http://www.dotemacs.de/dotfiles/ElijahDaniel.emacs.html>
(defadvice scroll-up (around ewd-scroll-up first act)
  "Keep cursor in the same column."
  (let ((col (current-column)))
    ad-do-it
    (move-to-column col)))
(defadvice scroll-down (around ewd-scroll-down first act)
  "Keep cursor in the same column."
  (let ((col (current-column)))
    ad-do-it
    (move-to-column col)))

(defvar url-regexp "\\(http\\(s\\)*://\\)\\(www.\\)*\\|\\(www.\\)")

(defun find-url-backward ()
  (interactive)
  (re-search-backward url-regexp nil t))

(defun find-url-forward ()
  (interactive)
  (re-search-forward url-regexp nil t)
)

(defun get-file-md5 ()
  (interactive)
  (when (derived-mode-p 'dired-mode)
    (let ((abs-file-name (dired-get-filename)))
      (unless (file-directory-p abs-file-name)
        (with-temp-buffer
          (let ((prefix-arg t))
            (shell-command (format "md5sum %s" abs-file-name))
            (buffer-string)))))))

;; some customizations for nested hydras
(defvar hydra-stack nil)

(defun hydra-push (expr)
  (push `(lambda () ,expr) hydra-stack))

(defun hydra-pop ()
  (interactive)
  (let ((x (pop hydra-stack)))
    (when x
      (funcall x))))

)

(provide 'custom-navigate)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom-navigate.el ends here
