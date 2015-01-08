;;; util-various.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(defun tcp-send (server port &optional timeout)
  "Отправить текст текущего буфера на server:port"
  (if (not timeout) (setq timeout 60))

  (let* ((res "*TCP/Result*")
         (cur-buf (buffer-name))
         (proc (open-network-stream "HttpRequest"
                                    (progn (switch-to-buffer (get-buffer-create res))
                                           (erase-buffer)
                                           (switch-to-buffer cur-buf) res)
                                    server port)))

    (process-send-string proc (buffer-string))
    (while (equal (process-status proc) 'open)
      (when (not (accept-process-output proc timeout))
        (delete-process proc)
        (error "Network timeout.")))

    (switch-to-buffer res)
    (beginning-of-buffer)
    (split-window)
    (switch-to-buffer cur-buf)))

(defun w3m-open-current-page-in-firefox ()
  "Opens the current URL in Mozilla Firefox."
  (interactive)
  (browse-url-firefox w3m-current-url))

(defun w3m-open-link-or-image-in-firefox ()
  "Opens the current link or image in Firefox."
  (interactive)
  (browse-url-firefox (or (w3m-anchor)
                          (w3m-image))))

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

;; http://stackoverflow.com/questions/2238418/emacs-lisp-how-to-get-buffer-major-mode
(defun custom/buffer-mode (buffer-or-string)
  "Returns the major mode associated with a buffer."
  (save-excursion
    (set-buffer buffer-or-string)
    major-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Edit files as root
;; http://nflath.com/2009/08/tramp/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sudo-edit-current-file ()
  (interactive)
  (let ((pos (point)))
    (find-alternate-file
     (concat "/sudo:root@localhost:" (buffer-file-name (current-buffer))))
    (goto-char pos)))

(defadvice ido-find-file (after find-file-sudo activate) ;; TODO find-file-hook
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun sudo-find-file (file-name)
  "Like find file, but opens the file as root."
  (interactive "FSudo Find File: ")
  (let ((tramp-file-name (concat "/sudo::" (expand-file-name file-name))))
    (find-file tramp-file-name)))

(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

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

;;{{{ Insert
(defun iy-insert-user ()
  (interactive)
  (insert (user-full-name)))

(defun iy-insert-time ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M:%S")))

(defun iy-insert-timestamp ()
  (interactive)
  (insert (format-time-string "%s")))

(defun iy-insert-date ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

(defun iy-insert-file-name ()
  (interactive)
  (insert (file-name-nondirectory (buffer-file-name))))

(defun iy-dwim-downcase (arg)
  (interactive "p")
  (if (region-active-p)
      (downcase-region (region-beginning) (region-end))
    (downcase-word arg)))

(defun iy-dwim-upcase (arg)
  (interactive "p")
  (if (region-active-p)
      (upcase-region (region-beginning) (region-end))
    (upcase-word arg)))

(defun iy-dwim-capitalize (arg)
  (interactive "P")
  (when (consp arg) (setq arg 1))
  (if (region-active-p)
      (capitalize-region (region-beginning) (region-end))
    (capitalize-word (prefix-numeric-value arg))))

(defun shrink-whitespaces ()
  "Remove white spaces around cursor to just one or none.
If current line does not contain non-white space chars, then remove blank lines to just one.
If current line contains non-white space chars, then shrink any whitespace char surrounding cursor to just one space.
If current line is a single space, remove that space.

Calling this command 3 times will always result in no whitespaces around cursor."
  (interactive)
  (let (
        cursor-point
        line-has-meat-p ; current line contains non-white space chars
        spaceTabNeighbor-p
        whitespace-begin whitespace-end
        space-or-tab-begin space-or-tab-end
        line-begin-pos line-end-pos
        )
    (save-excursion
      ;; todo: might consider whitespace as defined by syntax table, and also consider whitespace chars in unicode if syntax table doesn't already considered it.
      (setq cursor-point (point))

      (setq spaceTabNeighbor-p (if (or (looking-at " \\|\t") (looking-back " \\|\t")) t nil) )
      (move-beginning-of-line 1) (setq line-begin-pos (point) )
      (move-end-of-line 1) (setq line-end-pos (point) )
      ;; (re-search-backward "\n$") (setq line-begin-pos (point) )
      ;; (re-search-forward "\n$") (setq line-end-pos (point) )
      (setq line-has-meat-p (if (< 0 (count-matches "[[:graph:]]" line-begin-pos line-end-pos)) t nil) )
      (goto-char cursor-point)

      (skip-chars-backward "\t ")
      (setq space-or-tab-begin (point))

      (skip-chars-backward "\t \n")
      (setq whitespace-begin (point))

      (goto-char cursor-point) (skip-chars-forward "\t ")
      (setq space-or-tab-end (point))
      (skip-chars-forward "\t \n")
      (setq whitespace-end (point))
      )

    (if line-has-meat-p
        (let (deleted-text)
          (when spaceTabNeighbor-p
            ;; remove all whitespaces in the range
            (setq deleted-text (delete-and-extract-region space-or-tab-begin space-or-tab-end))
            ;; insert a whitespace only if we have removed something
            ;; different that a simple whitespace
            (if (not (string= deleted-text " "))
                (insert " ") ) ) )

      (progn
        ;; (delete-region whitespace-begin whitespace-end)
        ;; (insert "\n")
        (delete-blank-lines)
        )
      ;; todo: possibly code my own delete-blank-lines here for better efficiency, because delete-blank-lines seems complex.
      )
    )
  )

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

;; Let's see how long it takes to forget I put this here even though it's just a
;; fix for a HEAD issue.
(defun go-back ()
  (interactive)
  (forward-line -1))

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

(defun isearch-forward-at-point (&optional regexp-p no-recursive-edit)
  "Interactive search forward for the symbol at point."
  (interactive "P\np")
  (if regexp-p (isearch-forward regexp-p no-recursive-edit)
    (let* ((end (progn (skip-syntax-forward "w_") (point)))
           (begin (progn (skip-syntax-backward "w_") (point))))
      (if (eq begin end)
          (isearch-forward regexp-p no-recursive-edit)
        (setq isearch-initial-string (buffer-substring begin end))
        (add-hook 'isearch-mode-hook 'isearch-set-initial-string)
        (isearch-forward regexp-p no-recursive-edit)))))

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

(defun find-alternative-file-with-sudo ()
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/sudo:root@localhost:"
             buffer-file-name))))

(defun back-to-indentation-or-beginning ()
  (interactive)
  (if (= (point) (save-excursion (back-to-indentation) (point)))
      (beginning-of-line)
    (back-to-indentation)))

(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive) (flet ((yes-or-no-p (prompt) t)) (revert-buffer)))

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

(defun join-region (beg end)
  "Apply join-line over region."
  (interactive "r")
  (if mark-active
      (let ((beg (region-beginning))
            (end (copy-marker (region-end))))
        (goto-char beg)
        (while (< (point) end)
          (join-line 1)))))

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

;TODO: maybe remove code duplication (watch similar functions over here)
(defun file-string (file)
    "Read the contents of a file and return as a string."
    (with-temp-buffer
      (insert-file-contents file)
      (buffer-string)))

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

(provide 'custom-utils)

;;; util-various.el ends here
