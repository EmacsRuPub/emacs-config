;; -*- coding: utf-8 -*-
;;
;; Filename: custom-publishing.el
;; Created: Сб май 31 23:29:10 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun custom/ps-print-buffer-with-faces ()
  (interactive)
  (ps-print-buffer-with-faces (concat
             ps-print-path "/"
             (buffer-name) "-"
             (format-time-string "%Y-%m-%dT%H-%M-%S") ".ps")))

(defun custom/ps-print-region-with-faces ()
  (interactive)
  (ps-print-region-with-faces (region-beginning) (region-end) (concat
                     ps-print-path "/"
                     (buffer-name) "-"
                     (format-time-string "%Y-%m-%dT%H-%M-%S") "-region.ps")))

(provide 'custom-publishing)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom-publishing.el ends here
