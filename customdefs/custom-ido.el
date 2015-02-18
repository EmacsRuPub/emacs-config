;; -*- coding: utf-8 -*-
;;
;; Filename: custom-ido.el
;; Created: Чт май 29 17:30:28 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Fix ido-ubiquitous for newer packages
(defmacro ido-ubiquitous-use-new-completing-read (cmd package)
  `(with-eval-after-load ,package
     (defadvice ,cmd (around ido-ubiquitous-new activate)
       (let ((ido-ubiquitous-enable-compatibility nil))
         ad-do-it))))

(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))

(defvar ido-completing-read-use-initial-input-as-default-commands nil
 "Use initial input as default in list commands")

(defvar ido-completing-read-use-initial-input--running nil)

(defadvice ido-read-internal (around ido-completing-read-use-initial-input-as-default)
 ;;(defun ido-read-internal (item prompt history &optional default require-match initial)
 (if (and
      (not ido-completing-read-use-initial-input--running)
      (memq this-command ido-completing-read-use-initial-input-as-default-commands))
     (let ((ido-completing-read-use-initial-input--running t))
       (setq default (or default initial))
       (setq initial nil)
       ad-do-it)
   ad-do-it))

;; func accepts buffer and must return a string or nil
(defun make-buffer-alist-by (func)
 (let ((hash (make-hash-table :test 'equal))
       alist)
   (mapc
    (lambda (buf)
      (let ((key (funcall func buf)))
        (when key (puthash key (cons buf (gethash key hash)) hash))))
    (buffer-list 'current))
   (maphash (lambda (k v) (setq alist (cons (cons k v) alist))) hash)
   alist))

(defun ido-switch-buffer-two-steps (prompt func &optional hist)
 (let ((alist (make-buffer-alist-by func)))
   (switch-to-buffer
    (ido-completing-read
     "Buffer: "
     (mapcar 'buffer-name
             (cdr (assoc (ido-completing-read prompt alist nil t nil hist) alist)))))))

(defvar ido-switch-buffer-by-major-mode-hist nil)
(defun ido-switch-buffer-by-major-mode ()
  (interactive)
  (ido-switch-buffer-two-steps
   "Mode: "
   (lambda (buf)
     (replace-regexp-in-string "-mode$" ""
                               (symbol-name (with-current-buffer buf major-mode))))
   ido-switch-buffer-by-major-mode-hist))

(defvar ido-switch-buffer-by-ext-name-hist nil)
(defun ido-switch-buffer-by-ext-name ()
  (interactive)
  (ido-switch-buffer-two-steps
   "Extension: "
   (lambda (buf)
     (file-name-extension (or (buffer-file-name buf) "")))
   ido-switch-buffer-by-ext-name-hist))

(defun ido-backspace ()
  "Forward to `backward-delete-char'.
On error (read-only), quit without selecting."
  (interactive)
  (condition-case nil
      (backward-delete-char 1)
    (error
     (minibuffer-keyboard-quit))))

(defalias 'modb 'ido-switch-buffer-by-major-mode)
(defalias 'extb 'ido-switch-buffer-by-ext-name)

(provide 'custom-ido)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom-ido.el ends here
