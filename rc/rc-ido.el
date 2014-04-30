;;; rc-ido.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(require 'ido)
(require 'ido-ubiquitous)
(require 'ido-vertical-mode)
(require 'flx-ido)

(require 'thingatpt)
(require 'imenu)

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
  `(eval-after-load ,package
     '(defadvice ,cmd (around ido-ubiquitous-new activate)
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

(ido-mode 'both)
(ido-ubiquitous-mode 1)
(ido-load-history)
(ido-vertical-mode)
(flx-ido-mode 1)

(ido-ubiquitous-use-new-completing-read yas/expand 'yasnippet)
(ido-ubiquitous-use-new-completing-read yas/visit-snippet-file 'yasnippet)

(setq ido-enable-flex-matching t)
(setq ido-enable-regexp t)
(setq ido-everywhere t)
(setq ido-enable-prefix nil)
(setq ido-auto-merge-work-directories-length -1)
(setq ido-create-new-buffer 'always)
(setq ido-use-filename-at-point 'guess)
(setq ido-show-dot-for-dired t)
(setq confirm-nonexistent-file-or-buffer nil)
(setq ido-enable-tramp-completion nil)
(setq ido-enable-last-directory-history t)
(setq ido-confirm-unique-completion nil)
(setq ido-max-work-directory-list 30)
(setq ido-max-work-file-list 100)
(setq ido-max-directory-size 1000000)
(setq ido-use-url-at-point t)
(setq ido-use-virtual-buffers t)
(setq ido-case-fold t) ; case insensitive
(setq ido-max-prospects 16)
(setq ido-use-faces nil)

(setq ido-completing-read-use-initial-input-as-default-commands
      '(ibuffer-filter-by-mode
        ibuffer-filter-by-used-mode))


(set-default 'imenu-auto-rescan t) ;; Always rescan buffer for imenu

(put 'diredp-do-bookmark-in-bookmark-file 'ido 'ignore)
(put 'diredp-set-bookmark-file-bookmark-for-marked 'ido 'ignore)

(ad-enable-advice
 'ido-read-internal
 'around
 'ido-completing-read-use-initial-input-as-default)

(ad-activate 'ido-read-internal)

(when (eq system-type 'darwin)
  ;; Ignore .DS_Store files with ido mode
  (add-to-list 'ido-ignore-files "\\.DS_Store")
  )

(add-to-list 'ido-work-directory-list-ignore-regexps tramp-file-name-regexp)

(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
(add-hook 'ido-minibuffer-setup-hook 'custom/ido-navigation)

(add-hook 'ido-setup-hook
          (lambda()
            (define-key ido-completion-map (kbd "C-M-p") (lookup-key ido-completion-map (kbd "C-p")))
            (define-key ido-completion-map (kbd "C-M-n") (lookup-key ido-completion-map (kbd "C-n"))) ; currently, this makes nothing. Maybe they'll make C-n key lately.
            (define-key ido-completion-map (kbd "C-p") 'ido-preview-backward)
            (define-key ido-completion-map (kbd "C-n") 'ido-preview-forward)
            (define-key ido-completion-map (kbd "M-m") 'ido-merge-work-directories)
            ))
(add-hook 'ido-setup-hook
          (lambda ()
              ;; Use C-w to go back up a dir to better match normal usage of C-w
              ;; - insert current file name with C-x C-w instead.
              (define-key ido-file-completion-map (kbd "C-w") 'ido-delete-backward-updir)
              (define-key ido-file-completion-map (kbd "C-x C-w") 'ido-copy-current-file-name)))

;; Increase minibuffer size when ido completion is active
(add-hook 'ido-minibuffer-setup-hook
          (function
           (lambda ()
             (make-local-variable 'resize-minibuffer-window-max-height)
             (setq resize-minibuffer-window-max-height 1))))

(global-set-key (kbd "M-s b") 'ido-switch-buffer-by-major-mode)
(global-set-key (kbd "M-s B") 'ido-switch-buffer-by-ext-name)

(provide 'rc-ido)

;;; rc-ido.el ends here
