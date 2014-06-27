;; -*- coding: utf-8 -*-
;;
;; Filename: rc-supercite.el
;; Created: Чт июн 26 11:56:47 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'filladapt)
(autoload 'sc-cite-original     "supercite" "Supercite 3.1" t)
(autoload 'sc-submit-bug-report "supercite" "Supercite 3.1" t)
(add-hook 'mail-citation-hook 'sc-cite-original)
(add-hook 'sc-load-hook
          (cond
           ((eq system-type 'darwin)
            'sc-setup-filladapt)
           ((eq system-type 'windows-nt)
            'sc-setup-filladapt)
           ((eq system-type 'gnu/linux)
            (lambda ()
              (filladapt-mode 1)))))
(setq message-cite-function 'sc-cite-original
      news-reply-header-hook nil
      sc-citation-leader ""
      sc-preferred-attribution-list
      '("sc-lastchoice"
        "x-attribution"
        "sc-consult"
        "initials"
        "firstname"
        "lastname")
      sc-electric-references-p t  ; allows me to select header n,p,RET
      sc-cite-region-limit t      ; no default citing to avoid filling
      sc-nested-citation-p nil
      sc-auto-fill-region-p nil
      sc-blank-lines-after-headers nil
      sc-attrib-selection-list
      '(("sc-from-address" ((".*" . (bbdb/sc-consult-attr (sc-mail-field "sc-from-address"))))))
      sc-mail-glom-frame
      '((begin                        (setq sc-mail-headers-start (point)))
        ("^x-attribution:[ \t]+.*$"   (sc-mail-fetch-field t) nil t)
        ("^\\S +:.*$"                 (sc-mail-fetch-field) nil t)
        ("^$"                         (progn (bbdb/sc-default)
                                             (list 'abort '(step . 0))))
        ("^[ \t]+"                    (sc-mail-append-field))
        (sc-mail-warn-if-non-rfc822-p (sc-mail-error-in-mail-field))
        (end                          (setq sc-mail-headers-end (point))))
      )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-supercite.el ends here
