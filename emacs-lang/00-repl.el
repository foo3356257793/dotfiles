;;; 00-repl.el --- shared inferior-REPL helper -*- lexical-binding: t; -*-
;;
;; Replaces the tmux.send(...) mechanism: instead of firing a line into a tmux
;; pane, we send it to an inferior REPL running inside Emacs (Q13 decision).

(require 'comint)

(defun my/repl-send (buffer-name start-fn line)
  "Ensure REPL BUFFER-NAME (started by START-FN) exists, then send LINE to it."
  (unless (and (get-buffer buffer-name)
               (comint-check-proc buffer-name))
    (save-window-excursion (funcall start-fn)))
  (let ((proc (get-buffer-process buffer-name)))
    (comint-send-string proc (concat line "\n"))
    (display-buffer buffer-name)))
