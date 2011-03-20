;;; emacs-rc-haskell.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extensions
;############################################################################
(add-to-list 'load-path "~/site-lisp/shime")

(autoload 'turn-on-haskell-ghci "haskell-ghci" "Turn on interaction with a GHCi interpreter." t)

(require 'hs-lint)
(require 'shime)


;#############################################################################
;#   Customizations
;############################################################################
(setq haskell-program-name "ghci")
(setq inferior-haskell-wait-and-jump t)
(setq shime-default-session-name "shime")
(setq hs-lint-replace-with-suggestions t)

(define-key haskell-mode-map [f5] 'shime-load-file)
(define-key haskell-mode-map (kbd "C-c C-c") 'shime-cabal-build)
(define-key haskell-mode-map (kbd "C-c c") 'shime-cabal-ido)

;; flymake settings for ghc
(defvar flymake-ghc-options (list "-Wall"))
(defvar flymake-ghc-packages (mapcar (lambda (p) (concat "-package " p)) '("QuickCheck")))

;; (push '(".+\\.hs$" flymake-Haskell-init flymake-Haskell-cleanup) flymake-allowed-file-name-masks)
;; (push '("^\\(\.+\.hs\\|\.lhs\\):\\([0-9]+\\):\\([0-9]+\\):\\(.\+\\)" 1 2 3 4) flymake-err-line-patterns) ;; fix to proper handling of warnings


;#############################################################################
;#   Custom definitions
;############################################################################
(defun flymake-get-Haskell-cmdline (source base-dir)
  (list "ghc"
        (append
         (list "--make" (concat "-i" base-dir) source)
         flymake-ghc-options
         flymake-ghc-packages)))

(defun flymake-Haskell-init ()
  (flymake-simple-make-init-impl
   'flymake-create-temp-inplace
   nil nil
   (file-name-nondirectory buffer-file-name)
   'flymake-get-Haskell-cmdline))

(defun flymake-Haskell-cleanup ()
  (delete-file flymake-temp-source-file-name))


(defun substitute-pattern-with-unicode (pattern symbol)
  "Add a font lock hook to replace the matched part of PATTERN with the
Unicode symbol SYMBOL looked up with UNICODE-SYMBOL."
  (interactive)
  (font-lock-add-keywords
   nil `((,pattern
          (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                    ,(unicode-symbol symbol)
                                    'decompose-region)
                    nil))))))

(defun substitute-patterns-with-unicode (patterns)
  "Call SUBSTITUTE-PATTERN-WITH-UNICODE repeatedly."
  (mapcar #'(lambda (x)
              (substitute-pattern-with-unicode (car x)
                                               (cdr x)))
          patterns))

;; Unicode symbols in buffer
(defun unicode-symbol (name)
  "Translate a symbolic name for a Unicode character -- e.g., LEFT-ARROW
 or GREATER-THAN into an actual Unicode character code. "
  (decode-char 'ucs (case name
                      ('left-arrow 8592)
                      ('up-arrow 8593)
                      ('right-arrow 8594)
                      ('down-arrow 8595)
                      ('double-vertical-bar #X2551)
                      ('equal #X003d)
                      ('not-equal #X2260)
                      ('identical #X2261)
                      ('not-identical #X2262)
                      ('less-than #X003c)
                      ('greater-than #X003e)
                      ('less-than-or-equal-to #X2264)
                      ('greater-than-or-equal-to #X2265)
                      ('logical-and #X2227)
                      ('logical-or #X2228)
                      ('logical-neg #X00AC)
                      ('nil #X2205)
                      ('horizontal-ellipsis #X2026)
                      ('double-exclamation #X203C)
                      ('prime #X2032)
                      ('double-prime #X2033)
                      ('for-all #X2200)
                      ('there-exists #X2203)
                      ('element-of #X2208)
                      ('square-root #X221A)
                      ('squared #X00B2)
                      ('cubed #X00B3)
                      ('lambda #X03BB)
                      ('alpha #X03B1)
                      ('beta #X03B2)
                      ('gamma #X03B3)
                      ('delta #X03B4))))

(defun haskell-unicode ()
  (interactive)
  (substitute-patterns-with-unicode
   (list
    (cons "\\s \\(<-\\)\\s " 'left-arrow)
    (cons "\\s \\(->\\)\\s " 'right-arrow)
    (cons "\\s \\(==\\)\\s " 'identical)
    (cons "\\s \\(/=\\)\\s " 'not-identical)
    (cons "\\s \\(()\\)\\s " 'nil)
    (cons "\\<\\(sqrt\\)\\>" 'square-root)
    (cons "\\s \\(&&\\)\\s " 'logical-and)
    (cons "\\s \\(||\\)\\s " 'logical-or)
    (cons "\\<\\(not\\)\\>" 'logical-neg)
    (cons "\\s \\(>\\)\\[^=\\]" 'greater-than)
    (cons "\\s \\(<\\)\\[^=\\]" 'less-than)
    (cons "\\s \\(>=\\)\\s " 'greater-than-or-equal-to)
    (cons "\\s \\(<=\\)\\s " 'less-than-or-equal-to)
    (cons "\\<\\(alpha\\)\\>" 'alpha)
    (cons "\\<\\(beta\\)\\>" 'beta)
    (cons "\\<\\(gamma\\)\\>" 'gamma)
    (cons "\\<\\(delta\\)\\>" 'delta)
    ;; (cons "\\s \\(''\\)\\s " 'double-prime)
    ;; (cons "\\s \\('\\)\\s " 'prime)
    (cons "\\s (\\(\\\\\\)\\s *\\w" 'lambda)
    (cons "\\s \\(!!\\)\\s " 'double-exclamation)
    (cons "\\s \\(\\.\\.\\)\\s " 'horizontal-ellipsis))))



;#############################################################################
;#   Hooks
;############################################################################
(defun custom/haskell-mode-hook ()
  (turn-on-haskell-doc-mode)
  (turn-on-haskell-indent)
  (turn-on-haskell-ghci)
  (turn-on-eldoc-mode)
  (turn-on-haskell-indentation)
  (local-set-key "\C-cl" 'hs-lint)
  (local-set-key "\C-ch" 'haskell-hoogle)
  (local-set-key "\C-c\C-h" 'haskell-hayoo)
  (setq tab-width 4)
  ;; (turn-on-haskell-simple-indent)
  (setq haskell-font-lock-symbols t)
  )
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
(add-hook 'haskell-mode-hook 'common-hooks/comment-hook)
(add-hook 'haskell-mode-hook 'common-hooks/show-prog-keywords)
(add-hook 'haskell-mode-hook 'common-hooks/newline-hook)
(add-hook 'haskell-mode-hook 'custom/haskell-mode-hook)
(add-hook 'haskell-mode-hook 'haskell-unicode)

;;; emacs-rc-haskell.el ends here
