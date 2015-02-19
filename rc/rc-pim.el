;; -*- coding: utf-8 -*-
;;
;; Filename: rc-pim.el
;; Created:  Sun May 4 23:57:55 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'deft "deft" "Deft" t)

(require 'calfw)
(require 'keyfreq)

(use-package sauron
  ;; note, you add (setq sauron-debug t) to get errors which can debug if
  ;; there's something wrong; normally, we catch such errors, since e.g an error
  ;; in one of the hooks may cause ERC to fail (i.e., the message won't come
  ;; trough).
  :defer t
  :bind (("C-c r s" . sauron-start)
         ("C-c r p" . sauron-stop)
         ("C-c r t" . sauron-toggle-hide-show)
         ("C-c r c" . sauron-clear))
  :config
  (progn
    (setq sauron-separate-frame nil)
    (setq sauron-hide-mode-line t)
    (setq sauron-max-line-length 120)
    ))

(use-package bbdb-loaddefs
  :defer t
  :commands bbdb
  :init
  (use-package bbdb)
  :bind (("C-c C-b s" . bbdb)
         ("C-c C-b c" . bbdb-create))
  :config
  (progn
    (setq bbdb-change-hook 'bbdb-timestamp-hook)
    (setq bbdb-complete-name-allow-cycling t)
    (setq bbdb-completion-display-record nil)
    (setq bbdb-dwim-net-address-allow-redundancy t)
    (setq bbdb-file '"~/.database.bbdb")
    (setq bbdb-north-american-phone-numbers-p nil)
    (setq bbdb-notice-hook 'bbdb-auto-notes-hook)
    (setq bbdb-offer-save 'savenoprompt) ;'automatic
    (setq bbdb-phone-style 'nil)
    (setq bbdb-quiet-about-name-mismatches t)
    (setq bbdb-readonly-p nil)
    (setq bbdb-sounds-directory nil)
    (setq bbdb-use-alternate-names nil)
    (setq bbdb-use-pop-up nil)
    (setq bbdb/mail-auto-create-p 'bbdb-ignore-most-messages-hook)
    (setq news-reply-header-hook nil)
    (add-to-list 'file-coding-system-alist (cons "\\.bbdb"  'utf-8))
    (define-coding-system-alias 'utf-8-emacs 'utf-8) ; needed by bbdb...
    (bind-key "<tab>" 'my-bbdb-tab-complete message-mode-map)
    (bind-key "C-c C-e" 'bbdb-edit-current-field bbdb-mode-map)
    (bind-key "C-c C-d" 'bbdb-delete-current-record)
    (bind-key "C-c C-f d" 'bbdb-delete-current-field-or-record bbdb-mode-map)
    (bind-key "C-c C-f i" 'bbdb-insert-new-field bbdb-mode-map)
    ))

(with-eval-after-load "deft"
  (setq deft-extension "org")
  (setq deft-directory "~/deft/")
  (setq deft-text-mode 'org-mode)
  ;; (global-set-key (kbd "<f12>") 'deft)
  )

(with-eval-after-load "calfw"
  (require 'calfw-ical)
  (require 'calfw-org)
  (setq calendar-week-start-day 1) ; 0:Sunday, 1:Monday
  ;; Unicode characters
  (setq cfw:fchar-junction ?╬
        cfw:fchar-vertical-line ?║
        cfw:fchar-horizontal-line ?═
        cfw:fchar-left-junction ?╠
        cfw:fchar-right-junction ?╣
        cfw:fchar-top-junction ?╦
        cfw:fchar-top-left-corner ?╔
        cfw:fchar-top-right-corner ?╗)
  ;; Week days
  (setq calendar-day-name-array
        ["Воскресенье" "Понедельник" "Вторник" "Среда" "Четверг" "Пятница" "Суббота"])
  ;; Month
  (setq calendar-month-name-array
        ["Январь" "Февраль" "Март" "Апрель" "Май" "Июнь" "Июль" "Август" "Сентябрь"
         "Октябрь" "Ноябрь" "Декабрь"])
  (custom-set-faces
   '(cfw:face-title ((t (:foreground "#f0dfaf" :weight bold :height 2.0 :inherit variable-pitch))))
   '(cfw:face-header ((t (:foreground "#d0bf8f" :weight bold))))
   '(cfw:face-sunday ((t :foreground "#cc9393" :background "grey10" :weight bold)))
   '(cfw:face-saturday ((t :foreground "#8cd0d3" :background "grey10" :weight bold)))
   '(cfw:face-holiday ((t :background "grey10" :foreground "#8c5353" :weight bold)))
   '(cfw:face-grid ((t :foreground "DarkGrey")))
   '(cfw:face-default-content ((t :foreground "#bfebbf")))
   '(cfw:face-periods ((t :foreground "cyan")))
   '(cfw:face-day-title ((t :background "grey10")))
   '(cfw:face-default-day ((t :weight bold :inherit cfw:face-day-title)))
   '(cfw:face-annotation ((t :foreground "RosyBrown" :inherit cfw:face-day-title)))
   '(cfw:face-disable ((t :foreground "DarkGray" :inherit cfw:face-day-title)))
   '(cfw:face-today-title ((t :background "#7f9f7f" :weight bold)))
   '(cfw:face-today ((t :background: "grey10" :weight bold)))
   '(cfw:face-select ((t :background "#2f2f2f")))
   '(cfw:face-toolbar ((t :foreground "Steelblue4" :background "Steelblue4")))
   '(cfw:face-toolbar-button-off ((t :foreground "Gray10" :weight bold)))
   '(cfw:face-toolbar-button-on ((t :foreground "Gray50" :weight bold))))
  (defun custom/calfw-open-calendar ()
    (interactive)
    (cfw:open-calendar-buffer
     :contents-sources
     (list
      (cfw:org-create-source "Green")  ; orgmode source
      (cfw:ical-create-source "gcal" private/google-calendar-url "IndianRed") ; google calendar ICS
      (cfw:ical-create-source "gcal" private/google-family-calendar-url "IndianRed")))))

(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

(global-set-key (kbd "C-c c") 'custom/calfw-open-calendar)
(global-set-key (kbd "C-c k") 'keyfreq-show)

(provide 'rc-pim)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-pim.el ends here
