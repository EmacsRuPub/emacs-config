;;; rc-browser.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Custom definitions
;############################################################################
(defun w3m-open-current-page-in-firefox ()
  "Opens the current URL in Mozilla Firefox."
  (interactive)
  (browse-url-firefox w3m-current-url))

(defun w3m-open-link-or-image-in-firefox ()
  "Opens the current link or image in Firefox."
  (interactive)
  (browse-url-firefox (or (w3m-anchor)
                          (w3m-image))))

(use-package w3m
  :commands w3m
  :init
  (progn
    (use-package w3m-search)
    (add-hook 'w3m-display-hook
              (lambda (url)
                (rename-buffer
                 (format "*w3m: %s*" (or w3m-current-title
                                         w3m-current-url)) t))))
  :config
  (progn
    (setq w3m-coding-system 'utf-8)
    (setq w3m-file-coding-system 'utf-8)
    (setq w3m-file-name-coding-system 'utf-8)
    (setq w3m-input-coding-system 'utf-8)
    (setq w3m-output-coding-system 'utf-8)
    (setq w3m-terminal-coding-system 'utf-8)
    (setq w3m-use-cookies t)
    ;; special chars
    (standard-display-ascii ?\200 [15])
    (standard-display-ascii ?\201 [21])
    (standard-display-ascii ?\202 [24])
    (standard-display-ascii ?\203 [13])
    (standard-display-ascii ?\204 [22])
    (standard-display-ascii ?\205 [25])
    (standard-display-ascii ?\206 [12])
    (standard-display-ascii ?\210 [23])
    (standard-display-ascii ?\211 [14])
    (standard-display-ascii ?\212 [18])
    (standard-display-ascii ?\214 [11])
    (standard-display-ascii ?\222 [?\'])
    (standard-display-ascii ?\223 [?\"])
    (standard-display-ascii ?\224 [?\"])
    (standard-display-ascii ?\227 " -- ")
    (add-to-list 'w3m-search-engine-alist
                 '("emacs-wiki" "http://www.emacswiki.org/cgi-bin/wiki.pl?search=%s"))))

(provide 'rc-browser)

;;; rc-browser.el ends here
