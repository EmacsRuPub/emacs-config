;; -*- coding: utf-8 -*-
;;
;; Filename: rc-help.el
;; Created:  Mon Jun 30 19:02:26 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package info)
(add-to-list 'Info-directory-list "/usr/share/info")

(push "/usr/share/info" Info-directory-list)
(setenv "MANPATH" "/usr/share/man:/usr/local/man")

(defun custom/open-info (topic bname)
  "Open info on TOPIC in BNAME."
  (if (get-buffer bname)
      (progn
        (switch-to-buffer bname)
        (unless (string-match topic Info-current-file)
          (Info-goto-node (format "(%s)" topic))))
    (info topic bname)))

(setq Info-additional-directory-list
      (list (concat home-directory "/help/info")))

(defhydra hydra-apropos (global-map "C-c h"
                         :color blue
                         :hint nil)
  "Apropos"
  ("a" apropos)
  ("d" apropos-documentation)
  ("v" apropos-variable)
  ("c" apropos-command)
  ("l" apropos-library)
  ("u" apropos-user-option)
  ("i" info-apropos "info")
  ("t" tags-apropos "tags")
  ("e" apropos-value)
  ("m" helm-man-woman))

(defhydra hydra-info-to (:hint nil :color teal)
  "
_o_rg _e_lisp e_m_acs _h_yperspec"
  ("o" (custom/open-info "org" "*org info*"))
  ("e" (custom/open-info "elisp" "*elisp info*"))
  ("m" (custom/open-info "emacs" "*emacs info*"))
  ("h" (custom/open-info "gcl" "*hyperspec*")))
(global-set-key (kbd "C-c C-h") 'hydra-info-to/body)

(provide 'rc-help)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-help.el ends here
