;;; rc-msk.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

;;{{{ Mark

(defvar things-map
  '((?w . word)
    (?W . symbol)
    (?s . sexp)
    (?d . defun)
    (?l . list)
    (?n . line)
    (?. . sentence)
    (?p . paragraph)
    (?P . page)
    (?f . filename)
    (?u . url)
    (?c . comment))
  "Map key to thing")

(defun iy-ido-mark-thing ()
  (interactive)
  (thing-region
   (ido-completing-read "thing: " (mapcar (lambda (th) (prin1-to-string (cdr th))) things-map) nil t)))

(defun iy-mark-thing (arg)
  "key . thing

(?w . word)
(?W . symbol)
(?s . sexp)
(?d . defun)
(?l . list)
(?n . line)
(?. . sentence)
(?p . paragraph)
(?P . page)
(?f . filename)
(?u . url)
(?c . comment)"

  (interactive "P")
  (condition-case e
      (let* ((echo-keystrokes nil)
             (ev last-command-event)
             (thing (cdr (assq ev things-map))))
        (while thing
          (condition-case e
              (progn (mark-thing thing arg t))
            (error (message (cadr e))))
          (setq ev (read-event))
          (setq thing (cdr (assq ev things-map))))
        (push ev unread-command-events))
    ('quit (call-interactively 'keyboard-quit))))

(defun iy-mark-surround-thing ()
  (interactive)
  (let ((thing (cdr (assq last-command-event things-map))))
    (when thing
      (thing-region (prin1-to-string thing)))))

(defun iy-forward-thing (arg)
  (interactive "P")
  (let* ((echo-keystrokes nil)
         (ev last-command-event)
         (thing (cdr (assq ev things-map))))
    (while thing
      (condition-case e
          (progn (forward-thing thing (prefix-numeric-value arg)))
        (error (message (cadr e))))
      (setq ev (read-event))
      (setq thing (cdr (assq ev things-map))))
    (push ev unread-command-events)))

(defun iy-backward-thing (arg)
  (interactive "P")
  (iy-forward-thing (- (prefix-numeric-value arg))))

(defun iy-begining-of-thing ()
  (interactive)
  (let ((thing (cdr (assq last-command-event things-map))))
    (when thing
      (beginning-of-thing thing))))

(defun iy-end-of-thing ()
  (interactive)
  (let ((thing (cdr (assq last-command-event things-map))))
    (when thing
      (end-of-thing thing))))

;;}}}


;;; rc-msk.el ends here
