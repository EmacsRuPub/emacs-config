;;; emacs-rc-scheme.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;; TODO: test out Geiser
;; http://www.google.com/url?sa=D&q=http://gitorious.org/geiser
;; https://github.com/jaor/geiser
;; git://git.sv.gnu.org/geiser.git
;; http://comments.gmane.org/gmane.lisp.scheme.geiser/20
;; http://www.nongnu.org/geiser/geiser_3.html
;; http://programming-musings.org/2009/05/14/geiser/
;; http://www.nongnu.org/geiser/geiser_4.html

;#############################################################################
;#   Load extensions
;############################################################################
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme" t)

(require 'quack)


;#############################################################################
;#   Customizations
;############################################################################
(setq scheme-program-name "mzscheme")
(setq quack-remap-find-file-bindings-p nil)
;; for Geiser; keep them
;; (setq geiser-impl-installed-implementations '(plt guile))
;; (setq geiser-impl-default-implementation 'plt)


;#############################################################################
;#   Custom definitions
;############################################################################
(defun insert-balanced-comments (arg)
  "Insert a set of balanced comments around the s-expression
containing the point.  If this command is invoked repeatedly
(without any other command occurring between invocations), the
comment progressively moves outward over enclosing expressions."
  (interactive "*p")
  (save-excursion
    (when (eq last-command this-command)
      (when (search-backward "#|" nil t)
        (save-excursion
          (delete-char 2)
          (while (and (< (point) (point-max)) (not (looking-at " *|#")))
            (forward-sexp))
          (replace-match ""))))
    (while (> arg 0)
      (backward-char 1)
      (cond ((looking-at ")") (incf arg))
            ((looking-at "(") (decf arg))))
    (insert "#|")
    (forward-sexp)
    (insert "|#")))

(defun remove-balanced-comments ()
  "Remove a set of balanced comments enclosing point."
  (interactive "*")
  (save-excursion
    (when (search-backward "#|" nil t)
      (delete-char 2)
      (while (and (< (point) (point-max)) (not (looking-at " *|#")))
        (forward-sexp))
      (replace-match ""))))

(defun r5rs-call ()
  "Calls r5rs info for current symbol"
  (interactive)
  (ignore-errors
    (let ((symbol (thing-at-point 'symbol)))
      (info "(r5rs)")
      (Info-index symbol))))


;#############################################################################
;#   Hooks
;############################################################################
(defun custom/scheme-mode-hook ()
  "My customization of Scheme Mode"
  (turn-on-eldoc-mode)
  ;; (paredit-mode +1)
  (local-set-key [(control c) (\;)] 'insert-balanced-comments)
  (local-set-key [(control c) (:)] 'remove-balanced-comments)
  (local-set-key [f1] 'r5rs-call)
)

(add-hook 'scheme-mode-hook 'common-hooks/newline-hook)
(add-hook 'scheme-mode-hook 'custom/scheme-mode-hook)
(add-hook 'scheme-mode-hook 'common-hooks/comment-hook)
(add-hook 'scheme-mode-hook 'common-hooks/show-prog-keywords)
(add-hook 'inferior-scheme-mode-hook '(lambda () (split-window)))

;;; emacs-rc-scheme.el ends here
