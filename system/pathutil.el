;TODO: unify slashes usage

(defun at-config-basedir (&optional suffix)
  (concat config-basedir suffix))

(defun at-homedir (&optional suffix)
  (concat home-directory suffix))

(defun at-org-dir (&optional suffix)
  (concat (at-homedir "/org/main") suffix))

(defun at-org-inventory-dir (&optional suffix)
  (concat (at-homedir "/org/inventory") suffix))

(defun at-org-mastering-dir (&optional suffix)
  (concat (at-homedir "/org/mastering") suffix))

(defun at-org-job-dir (&optional suffix)
  (concat (at-homedir "/org/job") suffix))
