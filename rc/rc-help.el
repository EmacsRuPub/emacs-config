;; -*- coding: utf-8 -*-
;;
;; Filename: rc-help.el
;; Created:  Mon Jun 30 19:02:26 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'info)
(add-to-list  'Info-directory-list "/usr/share/info")

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
  ("e" apropos-value))

;TODO: bind to key
(defhydra hydra-info-to (global-map "C-c C-h"
                         :hint nil :color teal)
  "
_o_rg e_l_isp _e_macs _h_yperspec"
  ("o" (custom/open-info "org" "*org info*"))
  ("e" (custom/open-info "elisp" "*elisp info*"))
  ("m" (custom/open-info "emacs" "*emacs info*"))
  ("h" (custom/open-info "gcl" "*hyperspec*")))

(provide 'rc-help)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-help.el ends here
