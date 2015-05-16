;; -*- coding: utf-8 -*-
;;
;; Filename: defun-themes.el
;; Created: Чт апр  4 18:25:49 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-namespace custom/

(defvar fonts-def (make-hash-table :test 'equal)
  "User's font definitions")

(defun set-xwindows-font (key)
  (set-face-attribute 'default nil :font (gethash key fonts-def)))

(setf (gethash "consolas-base" fonts-def) "Consolas:size=12")
(setf (gethash "terminus" fonts-def) "Terminus:size=14")
(setf (gethash "terminus-bold" fonts-def) "TerminusBold:size=12")
(setf (gethash "monaco" fonts-def) "Monaco:size=12")
(setf (gethash "ptmono" fonts-def) "PTMono:size=12")
(setf (gethash "adobe-courier-bold-14" fonts-def) "-Adobe-Courier-bold-normal-normal-*-14-*-*-*-m-90-iso10646-1")
(setf (gethash "adobe-helvetica-bold-12" fonts-def) "-Adobe-Helvetica-bold-normal-normal-*-12-*-*-*-*-70-iso10646-1")
(setf (gethash "adobe-helvetica-bold-14" fonts-def) "-Adobe-Helvetica-bold-normal-normal-*-14-*-*-*-*-82-iso10646-1")
(setf (gethash "adobe-utopia-bold-12" fonts-def) "-Adobe-Utopia-bold-normal-normal-*-12-*-*-*-*-70-iso10646-1")
(setf (gethash "lucidatypewriter-bold-12" fonts-def) "-B&H-LucidaTypewriter-bold-normal-normal-Sans-12-*-*-*-m-70-iso10646-1")
(setf (gethash "adobe-helvetica-bold-12-1" fonts-def) "-adobe-helvetica-bold-o-normal--12-*-75-75-p-69-iso10646-1")
(setf (gethash "dec-terminal-bold-14" fonts-def) "-DEC-Terminal-bold-normal-normal-*-14-*-*-*-c-80-iso10646-1")
(setf (gethash "dec-terminal-normal-14" fonts-def) "-DEC-Terminal-normal-normal-normal-*-14-*-*-*-c-80-iso10646-1")
(setf (gethash "misc-fixed-normal-13" fonts-def) "-Misc-Fixed-normal-normal-normal-*-13-*-*-*-c-70-iso10646-1")
(setf (gethash "adobe-courier-bold-12" fonts-def) "-adobe-courier-bold-r-normal--12-*-75-75-m-70-iso10646-1")
(setf (gethash "b&h-luxi-mono-bold" fonts-def) "-b&h-Luxi Mono-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(setf (gethash "b&h-lucidatypewriter-bold-12" fonts-def) "-b&h-lucidatypewriter-bold-r-normal-sans-12-*-75-75-m-70-iso10646-1")
(setf (gethash "b&h-lucidatypewriter-medium-12" fonts-def) "-b&h-lucidatypewriter-medium-r-normal-sans-12-*-75-75-m-70-iso10646-1")
(setf (gethash "bitstream-courier-10-pitch-bold" fonts-def) "-bitstream-Courier 10 Pitch-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(setf (gethash "bitstream-courier-10-pitch-normal" fonts-def) "-bitstream-Courier 10 Pitch-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(setf (gethash "bitstream-terminal-medium-18" fonts-def) "-bitstream-terminal-medium-r-normal--18-*-100-100-c-110-iso8859-1")
(setf (gethash "dec-terminal-bold-14-1" fonts-def) "-dec-terminal-bold-r-normal--14-*-75-75-c-80-iso8859-1")
(setf (gethash "dec-terminal-medium-14" fonts-def) "-dec-terminal-medium-r-normal--14-*-75-75-c-80-iso8859-1")
(setf (gethash "ibm-courier-bold" fonts-def) "-ibm-Courier-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(setf (gethash "ibm-courier-normal" fonts-def) "-ibm-Courier-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(setf (gethash "microsoft-consolas-for-powerline-bold" fonts-def) "-microsoft-Consolas for Powerline-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(setf (gethash "microsoft-consolas-for-powerline-normal" fonts-def) "-microsoft-Consolas for Powerline-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(setf (gethash "microsoft-consolas-bold" fonts-def) "-microsoft-Consolas-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(setf (gethash "microsoft-consolas-normal" fonts-def) "-microsoft-Consolas-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(setf (gethash "misc-fixed-bold-13" fonts-def) "-misc-fixed-bold-r-normal--13-*-75-75-c-70-iso10646-1")
(setf (gethash "misc-fixed-medium-r-normal-13" fonts-def) "-misc-fixed-medium-r-normal--13-*-75-75-c-70-iso10646-1")
(setf (gethash "misc-fixed-medium-r-normal-13" fonts-def) "-misc-fixed-medium-r-normal--13-*-75-75-c-80-iso10646-1")
(setf (gethash "misc-fixed-medium-r-normal-14" fonts-def) "-misc-fixed-medium-r-normal--14-*-75-75-c-70-iso10646-1")
(setf (gethash "monotype-andale-mono-normal" fonts-def) "-monotype-Andale Mono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(setf (gethash "monotype-courier-new-bold" fonts-def) "-monotype-Courier New-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(setf (gethash "monotype-courier-new-normal" fonts-def) "-monotype-Courier New-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(setf (gethash "dejavu-sans-mono-bold" fonts-def) "-unknown-DejaVu Sans Mono-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(setf (gethash "dejavu-sans-mono-normal" fonts-def) "-unknown-DejaVu Sans Mono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(setf (gethash "freemono-bold" fonts-def) "-unknown-FreeMono-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(setf (gethash "freemono-normal" fonts-def) "-unknown-FreeMono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(setf (gethash "liberation-mono-bold" fonts-def) "-unknown-Liberation Mono-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(setf (gethash "liberation-mono-normal" fonts-def) "-unknown-Liberation Mono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(setf (gethash "urw-nimbus-mono-l-bold" fonts-def) "-urw-Nimbus Mono L-bold-normal-normal-*-16-*-*-*-m-0-iso10646-1")
(setf (gethash "urw-nimbus-mono-l-normal" fonts-def) "-urw-Nimbus Mono L-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(setf (gethash "xos4-terminus-bold-16" fonts-def) "-xos4-Terminus-bold-normal-normal-*-16-*-*-*-c-80-iso10646-1")
(setf (gethash "bsvera-sans-mono" fonts-def) "Bitstream Vera Sans Mono:size=12")

)

(provide 'themes-definitions)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; defun-themes.el ends here
