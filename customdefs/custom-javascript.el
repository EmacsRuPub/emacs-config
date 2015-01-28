;; -*- coding: utf-8 -*-
;;
;; Filename: custom-javascript.el
;; Created: Вс окт 26 19:46:22 2014 (+0300)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar js2r-path-to-tests "/test/"
  "Path to tests from a root shared with sources")

(defvar js2r-path-to-sources "/lib/"
  "Path to sources from a root shared with tests")

(defvar js2r-test-suffix "-test"
  "The suffix added to test files")

(defun possible-test-file-suffixes ()
  (cons (concat js2r-test-suffix ".js")
        '("Test.js" "_test.js" "-test.js")))

(defun looks-like-test-file-name (file-name)
  (--any? (s-ends-with-p it file-name) (possible-test-file-suffixes)))

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

(provide 'custom-javascript)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom-javascript.el ends here
