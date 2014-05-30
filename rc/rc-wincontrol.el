;;; emacs-rc-wincontrol.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet


(require 'window-number)
(require 'buffer-move)
(require 'framemove)


;#############################################################################
;#   Window resizing
;############################################################################
(defun win-resize-top-or-bot ()
  "Figure out if the current window is on top, bottom or in the middle"
  (let* ((win-edges (window-edges))
         (this-window-y-min (nth 1 win-edges))
         (this-window-y-max (nth 3 win-edges))
         (fr-height (frame-height)))
    (cond
     ((eq 0 this-window-y-min) "top")
     ((eq (- fr-height 1) this-window-y-max) "bot")
     (t "mid"))))

(defun win-resize-left-or-right ()
  "Figure out if the current window is to the left, right or in the middle"
  (let* ((win-edges (window-edges))
         (this-window-x-min (nth 0 win-edges))
         (this-window-x-max (nth 2 win-edges))
         (fr-width (frame-width)))
    (cond
     ((eq 0 this-window-x-min) "left")
     ((eq (+ fr-width 4) this-window-x-max) "right")
     (t "mid"))))

(defun win-resize-enlarge-vert ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window -1))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window 1))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window -1))
   (t (message "nil"))))

(defun win-resize-minimize-vert ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window 1))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window -1))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window 1))
   (t (message "nil"))))

(defun win-resize-enlarge-horiz ()
  (interactive)
  (cond
   ((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally -1))
   ((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally 1))
   ((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally -1))))

(defun win-resize-minimize-horiz ()
  (interactive)
  (cond
   ((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally 1))
   ((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally -1))
   ((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally 1))))

(defun spawn-buffer()
  (interactive)
  (let ((buffer-name (generate-new-buffer-name "*new-buffer*")))
    (generate-new-buffer buffer-name)
    (switch-to-buffer buffer-name)))

(defun ibuffer-filter-by-extname (qualifier)
  (interactive "sFilter by extname: ")
  (ibuffer-filter-by-filename (concat "\\." qualifier "$")))

(defun kill-other-buffers ()
  "Kill all buffers but the current one.
Don't mess with special buffers."
  (interactive)
  (dolist (buffer (buffer-list))
    (unless (or (eql buffer (current-buffer)) (not (buffer-file-name buffer)))
      (kill-buffer buffer))))

(defun kill-buffer-other-window ()
  (interactive)
  (kill-buffer
   (window-buffer
    (next-window))))

(defun update-frames (heads-count)
  (interactive "sHeads count: ")
  (let ((frames-count (length (frame-list)))
        (heads (string-to-number heads-count)))
    (cond
     ((= heads 2)
      (when (= frames-count 1)
        (make-frame-command)))
     ((= heads 1)
      (when (> frames-count 1)
        (delete-other-frames)))
     (t
      (delete-other-frames)))))

(window-number-meta-mode)

(setq framemove-hook-into-windmove t)

;#############################################################################
;#   Buffers management
;############################################################################
(require 'ibuffer)
(setq ibuffer-default-sorting-mode 'major-mode) ;recency
(setq ibuffer-always-show-last-buffer :nomini)
(setq ibuffer-default-shrink-to-minimum-size t)
(setq ibuffer-jump-offer-only-visible-buffers t)

(setq ibuffer-saved-filters
      '(("dired" ((mode . dired-mode)))
        ("leechcraft" ((filename . "leechcraft")))
        ("qxmpp" ((filename . "qxmpp")))
        ("xmonad" ((filename . "xmonad")))
        ("jabberchat" ((mode . jabber-chat-mode)))
        ("orgmode" ((mode . org-mode)))
        ("elisp" ((mode . emacs-lisp-mode)))
        ("fundamental" ((mode . fundamental-mode)))
        ("haskell" ((mode . haskell-mode)))))

(setq ibuffer-saved-filter-groups custom/ibuffer-saved-filter-groups)

(setq special-display-regexps (remove "[ ]?\\*[hH]elp.*" special-display-regexps))
(setq special-display-regexps (remove "[ ]?\\*info.*\\*[ ]?" special-display-regexps))
(setq special-display-regexps (remove "[ ]?\\*Messages\\*[ ]?" special-display-regexps))

(add-hook 'ibuffer-mode-hook (lambda () (ibuffer-switch-to-saved-filter-groups "default"))) ;; Make sure we're always using our buffer groups
(add-hook 'ibuffer-mode-hook (lambda () (define-key ibuffer-mode-map (kbd "M-o") 'other-window))) ; was ibuffer-visit-buffer-1-window

;#############################################################################
;#   Keybindings
;############################################################################

;; windows resizing
(global-set-key (kbd "<C-M-down>") 'win-resize-minimize-vert)
(global-set-key (kbd "<C-M-up>") 'win-resize-enlarge-vert)
(global-set-key (kbd "<C-M-right>") 'win-resize-minimize-horiz)
(global-set-key (kbd "<C-M-left>") 'win-resize-enlarge-horiz)

;; buffer controls
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "<f11>") 'buffer-menu)

(global-set-key (kbd "C-S-c <up>") 'buf-move-up)
(global-set-key (kbd "C-S-c <down>") 'buf-move-down)
(global-set-key (kbd "C-S-c <left>") 'buf-move-left)
(global-set-key (kbd "C-S-c <right>") 'buf-move-right)

(global-set-key (kbd "C-s-<up>") 'windmove-up)
(global-set-key (kbd "C-s-<down>") 'windmove-down)
(global-set-key (kbd "C-s-<left>") 'windmove-left)
(global-set-key (kbd "C-s-<right>") 'windmove-right)

(define-key ibuffer-mode-map (kbd "/ .") 'ibuffer-filter-by-extname)

(define-prefix-command 'custom-windowing-keymap)
(define-key custom-windowing-keymap (kbd "s") 'save-current-configuration)
(define-key custom-windowing-keymap (kbd "r") 'resume)
(define-key custom-windowing-keymap (kbd "c") 'wipe)
(global-set-key (kbd "<f2>") 'custom-windowing-keymap)

(provide 'rc-wincontrol)

;;; emacs-rc-wincontrol.el ends here
