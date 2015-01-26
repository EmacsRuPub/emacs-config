;;; custom-clients.el ---

;; Copyright (C) 2015 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

;TODO: parametrize shell for terminal
(defun terminal ()
  "Switch to terminal. Launch if nonexistent."
  (interactive)
  (if (get-buffer "*ansi-term*")
      (switch-to-buffer "*ansi-term*")
    (ansi-term "/bin/zsh"))
  (get-buffer-process "*ansi-term*"))

(defalias 'tt 'terminal)

(provide 'custom-clients)

;;; custom-clients.el ends here
