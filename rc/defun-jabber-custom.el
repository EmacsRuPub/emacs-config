;;; defun-jabber-custom.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(defvar url-regexp "\\(http\\(s\\)*://\\)\\(www.\\)*\\|\\(www.\\)")

(defun custom/find-url-backward ()
  (interactive)
  (re-search-backward url-regexp nil t))

(defun custom/find-url-forward ()
  (interactive)
  (re-search-forward url-regexp nil t))

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


;#############################################################################
;#   Jabber smileys
;############################################################################
(require 'xml)

(defun smiley-parse-node (node)
  "Extracts smiley data of type (REGEXP 1 FILENAME) from a node."
  (when (listp node)
    (let* ((filename
            (cdr (assq 'file (xml-node-attributes node))))
           (smilies
            (mapcar
             (lambda (data) (car (last data)))
             (xml-get-children node 'string))))
                        (list
        (concat (regexp-opt smilies "\\(") "\\W")
        1 filename)
       )))

(defun smiley-parse-file (filename)
  "Returns smiley data list for smiley-regexp-alist."
  (let ((root (xml-parse-file filename)))
    (mapcar 'smiley-parse-node
            (xml-get-children
             (car root) ;; we skip <messaging-emoticon-map>
             'emoticon))
    ))

(defvar smiley-base-directory nil
  "Directory containing smiley packs (folders).")

(defun smiley-load-theme (pack)
  "Loads smiley theme PACK into smiley.el.
  Each theme should be a folder inside smiley-data-directory. For example
  smiley-data-directory is set to '/home/bobry/.emacs.d/smileys, so possible
  directory structure could be:
  .
  |-- default
  |-- kolobok
  `-- tango

  default, kolobok and tango are valid PACK values."
  (interactive "sTheme: ")
  (when smiley-base-directory
    (let* ((smiley-dir (format "%s/%s/" smiley-base-directory pack ))
                                         (smiley-path (concat smiley-dir "emoticons.xml")))
      (when (file-exists-p smiley-path)
        (setq
         smiley-style 'low-color ;; this is done for compatibility reasons
         smiley-data-directory smiley-dir
         smiley-regexp-alist (smiley-parse-file smiley-path))
        (smiley-update-cache))
      )))

;; in client code:
;; (add-hook 'jabber-chat-mode-hook 'autosmiley-mode)
;; (setq smiley-base-directory (concat (getenv "HOME") "/.emacs.d/resources/smileys/"))
;; (add-to-list 'gnus-smiley-file-types "gif")
;; (smiley-load-theme "kolobok")

(provide 'defun-jabber-custom)

;;; defun-jabber-custom.el ends here
