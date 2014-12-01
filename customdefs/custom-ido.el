;; -*- coding: utf-8 -*-
;;
;; Filename: custom-ido.el
;; Created: Чт май 29 17:30:28 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun mine-goto-symbol-at-point ()
  "Will navigate to the symbol at the current point of the cursor"
  (interactive)
  (ido-goto-symbol (thing-at-point 'symbol)))

(defun ido-goto-symbol (&optional a-symbol)
  "Will update the imenu index and then use ido to select a symbol to navigate to"
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols (symbol-list)
                       (when (listp symbol-list)
                         (dolist (symbol symbol-list)
                           (let ((name nil) (position nil))
                             (cond
                              ((and (listp symbol) (imenu--subalist-p symbol))
                               (addsymbols symbol))
                              ((listp symbol)
                               (setq name (car symbol))
                               (setq position (cdr symbol)))
                              ((stringp symbol)
                               (setq name symbol)
                               (setq position (get-text-property 1 'org-imenu-marker symbol))))
                             (unless (or (null position) (null name))
                               (add-to-list 'symbol-names name)
                               (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    (let* ((selected-symbol
            (if (null a-symbol)
                (ido-completing-read "Symbol? " symbol-names)
              a-symbol))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (cond
       ((overlayp position)
        (goto-char (overlay-start position)))
       (t
        (goto-char position))))))

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

(defun custom/ido-navigation ()
  (local-set-key (kbd "<up>") 'ido-prev-match)
  (local-set-key (kbd "<down>") 'ido-next-match)
  )

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

(defalias 'modb 'ido-switch-buffer-by-major-mode)
(defalias 'extb 'ido-switch-buffer-by-ext-name)

(provide 'custom-ido)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom-ido.el ends here
