;;; util-various.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(defun my-find-thing-at-point ()
  "Find variable, function or file at point."
  (interactive)
  (cond ((not (eq (variable-at-point) 0))
         (call-interactively 'describe-variable))
        ((function-called-at-point)
         (call-interactively 'describe-function))
        (t (find-file-at-point))))

;Make cursor stay in the same column when scrolling using pgup/dn.
;Previously pgup/dn clobbers column position, moving it to the
;beginning of the line.
;<http://www.dotemacs.de/dotfiles/ElijahDaniel.emacs.html>
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

(defun custom/insert-uuid ()
  (interactive)
  (shell-command-on-region (point) (point) "uuidgen" t)
  (delete-backward-char 1))

(defun sudo-edit-current-file ()
  (interactive)
  (let ((pos (point)))
    (find-alternate-file
     (concat "/sudo:root@localhost:" (buffer-file-name (current-buffer))))
    (goto-char pos)))

;;{{{ String functions
(defun iy-string-camel-to-underscore (string)
  "Convert camel string to upcase one which concat words using underscore"
  (let ((case-fold-search nil))
    (replace-regexp-in-string
     "\\([[:upper:]]\\)\\([[:upper:]][[:lower:]]\\)" "\\1_\\2"
     (replace-regexp-in-string
      "\\([[:lower:]]\\)\\([[:upper:]]\\)" "\\1_\\2" string))))

(defun camel-to-underscore (start end)
  (interactive "r")
  (let ((origin (buffer-substring start end)))
    (delete-region start end)
    (insert (iy-string-camel-to-underscore origin))))
;;}}}

(defun downcase-dwim (arg)
  (interactive "p")
  (if (region-active-p)
      (downcase-region (region-beginning) (region-end))
    (downcase-word arg)))

(defun upcase-dwim (arg)
  (interactive "p")
  (if (region-active-p)
      (upcase-region (region-beginning) (region-end))
    (upcase-word arg)))

(defun capitalize-dwim (arg)
  (interactive "P")
  (when (consp arg) (setq arg 1))
  (if (region-active-p)
      (capitalize-region (region-beginning) (region-end))
    (capitalize-word (prefix-numeric-value arg))))

;; This override for transpose-words fixes what I consider to be a flaw with the
;; default implementation in simple.el. To traspose chars or lines, you always
;; put the point on the second char or line to transpose with the previous char
;; or line. The default transpose-words implementation does the opposite by
;; flipping the current word with the next word instead of the previous word.
;; The new implementation below instead makes transpose-words more consistent
;; with how transpose-chars and trasponse-lines behave.
(defun transpose-words (arg)
  "[Override for default transpose-words in simple.el]
Interchange words around point, leaving point at end of
them. With prefix arg ARG, effect is to take word before or
around point and drag it backward past ARG other words (forward
if ARG negative). If ARG is zero, the words around or after
point and around or after mark are interchanged."
  (interactive "*p")
  (if (eolp) (forward-char -1))
  (transpose-subr 'backward-word arg)
  (forward-word (+ arg 1)))

(defun custom/remove-elc-on-save ()
  "If you're saving an elisp file, likely the .elc is no longer valid."
  (make-local-variable 'after-save-hook)
  (add-hook 'after-save-hook
            (lambda ()
              (if (file-exists-p (concat buffer-file-name "c"))
                  (delete-file (concat buffer-file-name "c"))))))

;; (Utilities) ;;

;<http://www.cabochon.com/~stevey/blog-rants/my-dot-emacs-file.html>
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it is visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

;; Compliment to kill-rectangle (just like kill-ring-save compliments
;; kill-region)
;; http://www.emacsblog.org/2007/03/17/quick-tip-set-goal-column/#comment-183
(defun kill-save-rectangle (start end &optional fill)
  "Save the rectangle as if killed, but don't kill it. See
`kill-rectangle' for more information."
  (interactive "r\nP")
  (kill-rectangle start end fill)
  (goto-char start)
  (yank-rectangle))

(defun string-camel-to-underscore (string)
  "Convert camel string to upcase one which concat words using underscore"
  (let ((case-fold-search nil))
    (replace-regexp-in-string
     "\\([[:upper:]]\\)\\([[:upper:]][[:lower:]]\\)" "\\1_\\2"
     (replace-regexp-in-string
      "\\([[:lower:]]\\)\\([[:upper:]]\\)" "\\1_\\2" string))))

(defun camel-to-underscore (start end)
  (interactive "r")
  (let ((origin (buffer-substring start end)))
    (delete-region start end)
    (insert (iy-string-camel-to-underscore origin))))

(defun back-to-indentation-or-beginning ()
  (interactive)
  (if (= (point) (save-excursion (back-to-indentation) (point)))
      (beginning-of-line)
    (back-to-indentation)))

(defun get-all-template-variables-django ()
  (interactive)
  (beginning-of-buffer)
  (let ((variables-list '()))
    (while (search-forward "{{" nil t)
      (let ((beg (+ (point) 1)))
        (search-forward "}}" nil t)
        (let ((end (- (point) 3)))
          (setq variables-list (cons (buffer-substring-no-properties beg end) variables-list)))))
    (spawn-buffer)
    (dolist (variable (nreverse variables-list))
      (insert variable)
      (insert "\n"))))

(defun compact-spaces-in-region (beg end)
  "replace all whitespace in the region with single spaces"
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (re-search-forward "\\s-+" nil t)
        (replace-match "")))))

;; FIXME code duplication, think of finding the widely used util or something similar
(autoload 'vc-git-root "vc-git")
(autoload 'vc-svn-root "vc-svn")
(autoload 'vc-hg-root "vc-hg")

(defun custom/project-root (file-path)
  "Guess the project root of the given FILE-PATH."
  (or (vc-git-root file-path)
       (vc-svn-root file-path)
       (vc-hg-root file-path)
       file-path))

(defun custom/copy-project-subpath ()
  (interactive)
  (let* ((current-file (buffer-file-name))
         (project-root (file-truename (custom/project-root current-file)))
         (selection (substring current-file (length project-root))))
    (with-temp-buffer
      (insert selection)
      (clipboard-kill-region (point-min) (point-max)))))

(defun create-restclient-sandbox ()
  (interactive)
  (let ((restbuffer (generate-new-buffer "*restclient-sandbox*")))
    (switch-to-buffer restbuffer)
    (restclient-mode)))

(defun custom/find-url-backward ()
  (interactive)
  (re-search-backward url-regexp nil t))

(defun custom/find-url-forward ()
  (interactive)
  (re-search-forward url-regexp nil t))

(defun elisp-var-printable (var)
  (if (boundp var)
      (let* ((var-value (symbol-value var))
             (is-string-value (stringp var-value)))
        (format "(setq %s %s)"
                (symbol-name var)
                (if is-string-value
                    (concat "\"" var-value "\"")
                  var-value)))
    nil))

(defun write-string-to-file (string file)
  (with-temp-buffer
    (insert string)
    (when (file-writable-p file)
      (write-region (point-min)
                    (point-max)
                    file))))

(defun custom/get-file-md5 ()
  (interactive)
  (when (derived-mode-p 'dired-mode)
    (let ((abs-file-name (dired-get-filename)))
      (unless (file-directory-p abs-file-name)
        (with-temp-buffer
          (let ((prefix-arg t))
            (shell-command (format "md5sum %s" abs-file-name))
            (buffer-string)))))))

;TODO: maybe make org-protocol solution instead
(defun youtube-dl ()
  (interactive)
  (let* ((str (current-kill 0))
         (default-directory "~/Downloads")
         (proc (get-buffer-process (ansi-term "/bin/bash"))))
    (term-send-string
     proc
     (concat "cd ~/Downloads && youtube-dl " str "\n"))))

;;;###autoload
(defun keys-describe-prefixes ()
  (interactive)
  (with-output-to-temp-buffer "*Bindings*"
    (dolist (letter-group (list
                           (cl-loop for c from ?a to ?z
                                    collect (string c))
                           (cl-loop for c from ?α to ?ω
                                    collect (string c))))
      (dolist (prefix '("" "C-" "M-" "C-M-"))
        (princ (mapconcat
                (lambda (letter)
                  (let ((key (concat prefix letter)))
                    (format ";; (global-set-key (kbd \"%s\") '%S)"
                            key
                            (key-binding (kbd key)))))
                letter-group
                "\n"))
        (princ "\n\n")))))

(provide 'custom-utils)

;;; util-various.el ends here
