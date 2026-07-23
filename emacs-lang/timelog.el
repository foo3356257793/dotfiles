;;; timelog.el --- mirrors ftplugin/timelog.lua (time_log*.yaml) -*- lexical-binding: t; -*-

(defun my/timelog-buffer-p ()
  (and buffer-file-name
       (string-match-p "time_log.*\\.ya?ml\\'" buffer-file-name)))

(defun my/timelog-process ()
  "Run process_time_log.py on the file (mirrors `m')."
  (interactive)
  (save-buffer)
  (compile (format "process_time_log.py %s" (buffer-file-name))))

(defun my/timelog-stamp ()
  "Insert a `- <timestamp>' line below (mirrors <ll>g)."
  (interactive)
  (end-of-line)
  (insert (format "\n- %s" (format-time-string "%Y-%m-%d %H:%M:%S"))))

(with-eval-after-load 'evil
  (add-hook 'find-file-hook
            (lambda ()
              (when (my/timelog-buffer-p)
                (evil-local-set-key 'normal (kbd "m") #'my/timelog-process)))))

(with-eval-after-load 'evil-leader
  (add-hook 'find-file-hook
            (lambda ()
              (when (my/timelog-buffer-p)
                (evil-leader/set-key "g" #'my/timelog-stamp)))))
