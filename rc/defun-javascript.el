;; -*- coding: utf-8 -*-
;;
;; Filename: defun-javascript.el
;; Created: Вс мар 31 12:24:12 2013 (+0400)
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


(require 'cl)
(require 's)
;; (require 'dash)

(defvar js2r-path-to-tests "/test/"
  "Path to tests from a root shared with sources")

(defvar js2r-path-to-sources "/lib/"
  "Path to sources from a root shared with tests")

(defvar js2r-test-suffix "-test"
  "The suffix added to test files")

(make-variable-buffer-local 'js2r-path-to-tests)
(make-variable-buffer-local 'js2r-path-to-sources)
(make-variable-buffer-local 'js2r-test-suffix)

;; Toggle between source and test
(defun jump-between-source-and-test-files (arg)
  (interactive "P")
  (if (looks-like-test-file-name (buffer-file-name))
      (jump-to-source-file arg)
    (jump-to-test-file arg)))

(defun jump-between-source-and-test-files-other-window (arg)
  (interactive "P")
  (if (looks-like-test-file-name (buffer-file-name))
      (jump-to-source-file-other-window arg)
    (jump-to-test-file-other-window arg)))

;; Duplicate object property node

(defun js2r-duplicate-object-property-node ()
  (interactive)
  (js2r--guard)
  (let ((node (js2r--closest 'js2-object-prop-node-p)))
    (goto-char (js2-node-abs-pos node))
    (skip-syntax-backward " >")
    (insert (buffer-substring (point) (js2-node-abs-end node)) ",")
    (skip-syntax-forward " >")))

;; Rename tests and sources

(defun js2r--rename-file (old-name new-name)
  (let ((modified-p (buffer-modified-p)))
    (rename-file old-name new-name 1)
    (rename-buffer new-name)
    (set-visited-file-name new-name)
    (set-buffer-modified-p modified-p)))

(defun also-rename-other (old-name new-name)
  (let (old-other new-other)
    (condition-case nil
        (if (and (looks-like-test-file-name old-name)
                 (looks-like-test-file-name new-name))
            (setq old-other (guess-source-file old-name)
                  new-other (guess-source-file new-name))
          (setq old-other (guess-test-file old-name)
                new-other (guess-test-file new-name)))
      (error nil))

    (when (and old-other new-other
               (file-exists-p old-other)
               (not (file-exists-p new-other))
               (yes-or-no-p (format "Also rename %S to %S?" old-other new-other)))

      (let ((b (find-buffer-visiting old-other)))
        (if b
            (with-current-buffer b
              (js2r--rename-file old-other new-other))
          (rename-file old-other new-other 1))))))

(defun js2r-rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (cond ((get-buffer new-name)
               (error "A buffer named '%s' already exists!" new-name))
              (t
               (js2r--rename-file filename new-name)
               (also-rename-other filename new-name)
               (message "File '%s' successfully renamed to '%s'" name (file-name-nondirectory new-name))))))))

;; Delete tests and sources

(defun also-delete-other (file-name)
  (let (other-name)
    (condition-case nil
        (setq other-name
              (if (looks-like-test-file-name file-name)
                  (guess-source-file file-name)
                (guess-test-file file-name)))
      (error nil))

    (when (and other-name
               (file-exists-p other-name)
               (yes-or-no-p (format "Also delete %S?" other-name)))

      (let ((b (find-buffer-visiting other-name)))
        (when b (kill-buffer b)))

      (delete-file other-name))))

(defun js2r-delete-current-buffer-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (also-delete-other filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

;; Jump to source-file

(defun jump-to-source-file (arg)
  (interactive "P")
  (let ((file (guess-source-file (buffer-file-name))))
    (if (or (file-exists-p file) arg)
        (find-file file)
      (error "%s not found." file))))

(defun possible-test-file-suffixes ()
  (cons (concat js2r-test-suffix ".js")
        '("Test.js" "_test.js" "-test.js")))

(defun looks-like-test-file-name (file-name)
  (--any? (s-ends-with-p it file-name) (possible-test-file-suffixes)))

(defun jump-to-source-file-other-window (arg)
  (interactive "P")
  (let ((file (guess-source-file (buffer-file-name))))
    (if (or (file-exists-p file) arg)
        (find-file-other-window file)
      (error "%s not found." file))))

(defun guess-source-file (file-name)
  (unless (looks-like-test-file-name file-name)
    (error "This doesn't look like a test file."))
  (format "%s/%s.js" (s-chop-suffix "/" (guess-source-folder file-name)) (guess-source-file-name file-name)))

(defun guess-source-file-name (file-name)
  (s-chop-suffixes (possible-test-file-suffixes) (file-name-nondirectory file-name)))

(defun guess-source-folder (file-name)
  (let ((test-dir (file-name-directory file-name)))
    (when (not (string-match-p js2r-path-to-tests test-dir))
      (error "Unable to locate source folder. Set js2r-path-to-tests and -sources."))
    (let ((source-dir (replace-regexp-in-string
                       js2r-path-to-tests
                       js2r-path-to-sources
                       test-dir)))
      (if (file-exists-p source-dir)
          source-dir
        (error "Unable to locate source folder. Verify js2r-path-to-tests and -sources")))))


;; Jump to test-file

(defun jump-to-test-file (arg)
  (interactive "P")
  (let ((file (guess-test-file (buffer-file-name))))
    (if (or (file-exists-p file) arg)
        (find-file file)
      (error "%s not found." file))))

(defun jump-to-test-file-other-window (arg)
  (interactive "P")
  (let ((file (guess-test-file (buffer-file-name))))
    (if (or (file-exists-p file) arg)
        (find-file-other-window file)
      (error "%s not found." file))))

(defun guess-test-file (file-name)
  (when (looks-like-test-file-name file-name)
    (error "Looks like you're already in the test file."))
  (or (test-file-that-exists file-name "-test")
      (test-file-that-exists file-name "_test")
      (test-file-that-exists file-name "Test")
      (test-file-name file-name js2r-test-suffix)))

(defun test-file-that-exists (file-name suffix)
  (let ((file (test-file-name file-name suffix)))
    (if (file-exists-p file) file nil)))

(defun test-file-name (file-name suffix)
  (format "%s/%s%s.js" (s-chop-suffix "/" (guess-test-folder file-name)) (test-file-name-stub file-name) suffix))

(defun test-file-name-stub (file-name)
  (s-chop-suffix ".js" (file-name-nondirectory file-name)))

(defun guess-test-folder (file-name)
  (let ((source-dir (file-name-directory file-name)))
    (when (not (string-match-p js2r-path-to-sources source-dir))
      (error "Unable to locate test folder. Set js2r-path-to-tests and -sources."))
    (let ((test-dir (replace-regexp-in-string
                     js2r-path-to-sources
                     js2r-path-to-tests
                     source-dir)))
      (if (file-exists-p test-dir)
          test-dir
        (error "Unable to locate test folder. Verify js2r-path-to-tests")))))

;; Toggle assert/refute

(defun toggle-assert-refute ()
  (interactive)
  (save-excursion
    (end-of-line)
    (re-search-backward "\\(assert\\|refute\\)")
    (if (looking-at "assert")
        (progn
          (kill-word 1)
          (insert "refute"))
      (kill-word 1)
      (insert "assert"))))

;; Mark a js2-node in right window

(defun remove-js2-mark-overlay ()
  (interactive)
  (mapc #'(lambda (o)
            (when (eq (overlay-get o 'type) 'mark-js2-in-right-window)
              (delete-overlay o)))
        (overlays-in (point-min) (point-max))))

(defmacro mark-js2-in-right-window (func)
  `(progn
     (kill-comment nil)
     (windmove-right)
     (remove-js2-mark-overlay)
     (let* ((node ,func)
            (beg (js2-node-abs-pos node))
            (end (js2-node-abs-end node))
            (o (make-overlay beg end nil nil t)))
       (overlay-put o 'face 'region)
       (overlay-put o 'type 'mark-js2-in-right-window)
       (windmove-left)
       (save-excursion
         (insert (format " ;; %s" (js2-node-short-name node)))))))

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

(provide 'defun-javascript)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; defun-javascript.el ends here
