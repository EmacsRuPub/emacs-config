;TODO: unify slashes usage

(defun at-config-basedir (&optional suffix)
  (concat config-basedir suffix))

(defun at-homedir (&optional suffix)
  (concat home-directory suffix))

(defun at-org-dir (&optional suffix)
  (concat (at-homedir "/org") suffix))
