;;; defun-jabber-custom.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(defvar url-regexp "\\(http\\(s\\)*://\\)\\(www.\\)*\\|\\(www.\\)")
(defvar use-zenburn-in-jabber t "Paint jabber-el buffers with zenburn colors")

;; fails on some URLs, i.e. opens too many times
(defun open-urls-in-region ()
  (interactive)
  (save-excursion
    (setq beginning (region-beginning))
    (setq end (region-end))
    (goto-char beginning)
    (while (< (point) end)
        (re-search-forward url-regexp nil t)
        (if (< (point) end)
            (browse-url (thing-at-point 'url))))))

;; uses s
;; TODO maybe use s in some other similar utils
(defun custom-jabber/cite-region ()
  (interactive)
  (let* ((content
          (buffer-substring
           (region-beginning) (region-end)))
         (result nil))
    (when (not (s-blank? content))
      (setq result
            (mapcar (lambda (x)
                      (if (s-starts-with? "[" x)
                          (nth 2 (s-match "^\\(\\[[0-9-\\ :]+\\] \\)\\(.*\\)" x))
                        x))
                    (s-lines (s-trim-right content))))
      (end-of-buffer)
      (insert-for-yank-1
       (s-append "\n"
                 (s-join "\n"
                         (mapcar (lambda (x) (s-prepend "> " x)) result)))))))

(provide 'custom-jabber)

;;; defun-jabber-custom.el ends here
