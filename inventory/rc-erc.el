;;; rc-erc-temp.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; ERC setup
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq erc-timestamp-only-if-changed-flag nil
      erc-timestamp-format "[%H:%M] "
      erc-fill-prefix " "
      erc-timestamp-mode t
      erc-max-buffer-size 20000
      erc-interpret-mirc-color nil
      erc-insert-timestamp-function 'erc-insert-timestamp-left
      erc-kill-queries-on-quit nil
      erc-keywords nil)
(setq erc-button-url-regexp
      "\\([-a-zA-Z0-9_=!?#$@~`%&*+\\/:;,]+\\.\\)+[-a-zA-Z0-9_=!?#$@~`%&*+\\/:;,]*[-a-zA-Z0-9\\/]")

;; (erc-scrolltobottom-enable)
;; (erc-scrolltobottom-disable)
;; (add-hook 'erc-mode-hook 'erc-add-scroll-to-bottom)
;; (setq erc-keywords '((".*Online.*" (:foreground "green"))
;; (".*Busy" (:foreground "red"))
;; (".*Away" (:foreground "red"))
;; (".*Idle" (:foreground "orange"))
;; ))

(setq erc-keywords nil)
(make-variable-buffer-local 'erc-fill-column)
(make-variable-buffer-local 'erc-hide-list)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Change fill column on resize
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun qdot/erc-set-fill-columns ()
  (interactive)
  (save-excursion
    (walk-windows
     (lambda (w)
       (let ((buffer (window-buffer w)))
(set-buffer buffer)
(when (eq major-mode 'erc-mode)
(message "Window size: %d" (window-width w))
(setq erc-fill-column (- (window-width w) 2))))))))

(setq window-configuration-change-hook (cddr window-configuration-change-hook))

;;(add-hook 'window-configuration-change-hook 'qdot/erc-set-fill-columns)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Privmsg window allocation
;;
;; We create a buffer with a ton of windows pointing to the bitlbee-placeholder
;; buffer. These can then be used to throw query windows into as they're
;; created by IMs or IRC privmsgs, so we don't have to worry about ERC screwing
;; with whatever buffer we're in now.
;;
;; Similarly, whenever we kill a query window, we should have it pop back to
;; the placeholder buffer so it can be reused.
;;
;; We also make the assumption that the privmsg allocation frame is the one
;; with the &bitlbee channel buffer in one of its windows. I just usually
;; assume bitlbee is going to be running anyways, so this seemed ok for my
;; setup.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Since we have our own allocator, just have ERC bury the buffers and then
;; we'll take care of them ourselves
(setq erc-auto-query 'bury)

(defun qdot/free-query-window-p (window)
  (let ((r nil))
    (if (string= "bitlbee-placeholder" (buffer-name (window-buffer window)))
        (setq r t))
    r))

(defun qdot/erc-move-query-to-placeholder (buffer)
  (let*
      ((bitlbee-window (get-buffer-window "&bitlbee" t)))
    (when bitlbee-window
      (let*
((bitlbee-window-list (window-list (window-frame bitlbee-window)))
(free-window-list (qdot/filter 'qdot/free-query-window-p bitlbee-window-list)))
(when (not (memq buffer (mapcar 'window-buffer bitlbee-window-list)))
(set-window-buffer (car free-window-list) buffer))))))

(defun qdot/erc-privmsg-query-allocate (proc parsed)
  ;; Find the frame holding the bitlbee& buffer. We'll consider that our privmsg window
  ;; Once we find it, walk the windows until we find an open bitlbee-placeholder
  ;; Set the window list to that so we can just pick the first window off the top
  (if (get-buffer-window "&bitlbee" t)
      (let*
          (
           (nick (car (erc-parse-user (erc-response.sender parsed))))
           (target (car (erc-response.command-args parsed)))
           (msg (erc-response.contents parsed))
           (query (if (not erc-query-on-unjoined-chan-privmsg)
nick
(if (erc-current-nick-p target)
nick
target))))

        ;;If the buffer doesn't even exist yet, go ahead and run auto-query to make it happen
        (if (not (erc-get-buffer query proc))
            (erc-auto-query proc parsed))
        ;;If we find one, allocate into that, otherwise, commense undefined behavior
        (when (and (erc-current-nick-p target)
                   (not (erc-is-message-ctcp-and-not-action-p msg))
                   (not (get-buffer-window (erc-get-buffer query proc) t)))
          (qdot/erc-move-query-to-placeholder (erc-get-buffer query proc)))))
  nil)

(add-hook 'erc-server-PRIVMSG-functions 'qdot/erc-privmsg-query-allocate)

;; Once we close a query window, return it to being a query placeholder window

(defun qdot/erc-query-buffer-recycle ()
  (if (and (erc-query-buffer-p (current-buffer)) (get-buffer "bitlbee-placeholder"))
      (set-window-buffer (get-buffer-window (current-buffer)) (get-buffer "bitlbee-placeholder")))
  nil)

(add-hook 'kill-buffer-hook 'qdot/erc-query-buffer-recycle)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; ZNC IRC Bouncer Setup
;;
;; I use the ZNC IRC bouncer to keep IRC connected, kinda like screen, except
;; far more complicated and only useful for one thing. Yay!
;;
;; ZNC divides up networks to be one per account, so we have to start once ERC
;; instance per network we want to connect to.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq qdot/erc-znc-server-rename-list (list))

(defun qdot/erc-znc-connect (nick)
  (interactive "ZNC Nick:")
  (erc :server qdot/erc-znc-remote-server :port qdot/erc-znc-port :nick nick :full-name nick)
  )

(defun qdot/erc-znc-rename-server-buffer ()
  (interactive)
  (let ((current-network (caddr (split-string (erc-current-nick) "-"))))
    (save-excursion
      (set-buffer (erc-server-buffer))
      (rename-buffer (concat "znc-" current-network))
      (message (format "Renamed buffer to %s" (concat "znc-" current-network)))
      )))

(defun qdot/erc-znc-initialize (proc parsed)
  ;; Prepend all ZNC buffers with znc-
  (if (and (not (string-match "znc-" (buffer-name (erc-server-buffer)))) (string-match "qdot-znc" (erc-current-nick)))
      (progn
        (qdot/erc-znc-rename-server-buffer)
        (erc-server-send (format "PASS %s:%s" (erc-current-nick) qdot/erc-znc-password))))
  nil)

(add-hook 'erc-server-NOTICE-functions 'qdot/erc-znc-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; ZNC variables and utility functions
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq qdot/erc-znc-nicks '("qdot-znc-freenode" "qdot-znc-mozilla"))
(defvar qdot/erc-znc-password "doesnotmatter")
(defvar qdot/erc-znc-remote-server "localhost")
(defvar qdot/erc-znc-port 9999)

(defun qdot/erc-znc-start ()
  (interactive)
  (mapcar 'qdot/erc-znc-connect qdot/erc-znc-nicks))

(defun qdot/bitlbee-connect ()
  (interactive)
  (qdot/erc-znc-connect "qdot-znc-bitlbee"))

(defun qdot/bitlbee-reallocate-query-buffers ()
  ;; For each already opened query window, reallocate
  (mapc (lambda (buf) (qdot/erc-move-query-to-placeholder buf))
(qdot/filter 'erc-query-buffer-p (buffer-list))))

(defun qdot/bitlbee-resume-layout ()
  (interactive)
  ;; If we havn't created a placeholder buffer yet, do so now, make it
  ;; readonly.
  (with-current-buffer (get-buffer-create "bitlbee-placeholder")
    (setq buffer-read-only t))
  (save-excursion
    ;; Bring up the bitlbee nicklist
    (set-buffer "&bitlbee")
    (erc-nicklist))
  (wg-revert-workgroup (wg-get-workgroup "bitlbee"))
  (qdot/bitlbee-reallocate-query-buffers))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Kill all ERC windows and connections for the current frame
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq erc-fill-function 'erc-fill-static)
(setq erc-fill-static-center 0)

;; Don't track common events
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
"324" "329" "332" "333" "353" "477"))

(setq erc-current-nick-highlight-type 'nick)

(setq erc-track-use-faces t)
(setq erc-track-faces-priority-list
      '(erc-current-nick-face erc-keyword-face))
(setq erc-track-priority-faces-only 'all)

;; Make erc-hide-list buffer-local
;; http://web.archiveorange.com/archive/v/rByihNiNJaOnTUlfaxLs

(defun erc-display-buffer-list (buffer)
  "Sanitize a 'buffer' name or list, and convert to a buffer-name list."
  (cond ((bufferp buffer) (list buffer))
((listp buffer) buffer)
((processp buffer) (list (process-buffer buffer)))
((eq 'all buffer)
;; Hmm, or all of the same session server?
(erc-buffer-list nil erc-server-process))
((and (eq 'active buffer) (erc-active-buffer))
(list (erc-active-buffer)))
((erc-server-buffer-live-p)
(list (process-buffer erc-server-process)))
(t (list (current-buffer)))))

(defun erc-display-message (parsed type buffer msg &rest args)
  "Display MSG in BUFFER.

ARGS, PARSED, and TYPE are used to format MSG sensibly.

See also `erc-format-message' and `erc-display-line'.

NOTE: PATCHED VERSION that takes into account that erc-hide-list
is buffer local"
  (let ((string (if (symbolp msg)
(apply 'erc-format-message msg args)
msg)))
    (setq string
(cond
((null type)
string)
((listp type)
(mapc (lambda (type)
(setq string
(erc-display-message-highlight type string)))
type)
string)
((symbolp type)
(erc-display-message-highlight type string))))

    (if (not (erc-response-p parsed))
(erc-display-line string buffer)
      (erc-put-text-property 0 (length string) 'erc-parsed parsed string)
      (erc-put-text-property 0 (length string) 'rear-sticky t string)
      (dolist (buf (erc-display-buffer-list buffer))
(unless (member (erc-response.command parsed)
(if (bufferp buf)
(with-current-buffer buf erc-hide-list)
erc-hide-list))
(erc-display-line string buf))))))

(setq qdot/erc-event-channels '("&bitlbee"))

(add-hook 'erc-join-hook
(lambda ()
(make-local-variable 'blink-matching-paren)
(setq blink-matching-paren nil)
"Only show joins/hides/quits for channels we
specify in qdot/erc-event-channels"
(when (not (member (buffer-name (current-buffer))
qdot/erc-event-channels))
(setq erc-hide-list '( "PART" "QUIT" "JOIN")))))

(defun qdot/clear-irc-buffer ()
  "If the current buffer is and ERC buffer, clear all text out of
it.

This function exists due to the fact that calling /CLEAR only
recenters the buffer so that prior history cannot be seen.
"
  (interactive)
  (when (member (current-buffer) (erc-buffer-list))
    (erc-truncate-buffer-to-size 0)))

(defun erc-cmd-CLEAR ()
  (qdot/clear-irc-buffer))

(defun qdot/erc-turn-off-parens ()
  (when (member (current-buffer) (erc-buffer-list))
    (setq completion-auto-help nil)
    (setq blink-matching-paren nil)))

(add-hook 'after-change-major-mode-hook 'qdot/erc-turn-off-parens)

(defun qdot/replace-gtalk-asterisks (input)
  (when (string-match "^gt-" (buffer-name (current-buffer)))
    ;; erc-send-current-line uses the "str" variable before this hook
    ;; to set what is being sent. Yay dynamic scoping! :( :( :(
    (setq str (replace-regexp-in-string "\\*" "•" input))))

(add-hook 'erc-send-pre-hook 'qdot/replace-gtalk-asterisks)

(defun qdot/erc-kill-all-channel-buffers ()
  (interactive)
  (dolist (channel (erc-buffer-list))
    (when (string-match-p "#" (buffer-name channel))
      (save-excursion
(set-buffer channel)
(kill-buffer)))))

;; Walk all of the server buffers first
;; Close those first, which autodetaches us from channels
;; Then go back through and close everything

(defun qdot/kill-erc-buffers (bitlbee)
  (mapcar
   (lambda (arg)
     (when (and (erc-server-buffer-p arg)
(if bitlbee
(string-match (buffer-name arg) "znc-bitlbee")
(not (string-match (buffer-name arg) "znc-bitlbee"))))
       (save-excursion
(set-buffer arg)
(erc-quit-server "Wheee.")
(if (get-buffer-process arg)
(delete-process (get-buffer-process arg)))
(kill-buffer))))
   (buffer-list)))

(defun qdot/kill-irc ()
  (interactive)
  (qdot/kill-erc-buffers nil))

(defun qdot/kill-bitlbee ()
  (interactive)
  (qdot/kill-erc-buffers t))

(add-hook 'kill-emacs-hook 'qdot/kill-irc)
(add-hook 'kill-emacs-hook 'qdot/kill-bitlbee)

(setq qdot/bitlbee-status-nicks '("subgirl13" "xiuvx" "bokehcat" "qdot76367" "gt-JaredAllen"))

(defun qdot/filter-bitlbee-joins-parts (msg)
  (when (and (string= "&bitlbee" (buffer-name (current-buffer)))
(= (string-match "***" msg) 0))
    (setq erc-insert-this nil)
    (dolist (nick qdot/bitlbee-status-nicks)
      (if (string-match nick msg)
(setq erc-insert-this t)))))

(add-hook 'erc-insert-pre-hook 'qdot/filter-bitlbee-joins-parts)
(setq erc-insert-pre-hook nil)
(defalias 'qdot/kill-erc 'qdot/kill-irc)

;; (require 'erc-nicklist);; For bitlbee

;; (and
;;  (require 'erc-highlight-nicknames)
;;  (add-to-list 'erc-modules 'highlight-nicknames)
;;  )

;; (add-to-list 'erc-modules 'scrolltobottom)

;; (setq erc-server-coding-system '(koi8-r . koi8-r))

;#############################################################################
;#   Network and channel presets
;############################################################################
;; (setq erc-autojoin-channels-alist
;;       '(("freenode.net" "#couchdb" "#haskell" "#git" "#xmonad")
;;         ("irc.freenode.net" "#git")
;;         ("freenode.net" "#clojure")
;;         ("irc.int.ru" "#unix")
;;         ("irc.fu-berlin.de" "#unix.ru" "#fidorus")
;;         ("fu-berlin.de" "#unix.ru" "#fidorus")
;;         ))

;; (defun erc-connect ()
;;   "Connect to IRC."
;;   (interactive)
;;   (progn
;;     (erc-select :server "irc.int.ru" :port 6667 :nick custom/erc-nick)
;;     (erc-select :server "irc.freenode.net" :port 6667 :nick custom/erc-nick)
;;     ;; (erc-select :server "irc.fu-berlin.de" :port 6667 :nick "alexott")
;;    ))


;;; rc-erc-temp.el ends here
