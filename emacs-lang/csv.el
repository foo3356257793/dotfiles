;;; csv.el --- mirrors ftplugin/csv.lua -*- lexical-binding: t; -*-
;;
;; .csv opens in text-mode; restore plain paste (bypass the global auto-indent
;; p=`] maps) and drop autoindent.

(with-eval-after-load 'evil
  (add-hook 'find-file-hook
            (lambda ()
              (when (and buffer-file-name (string-match-p "\\.csv\\'" buffer-file-name))
                (setq-local electric-indent-inhibit t)
                (evil-local-set-key 'normal (kbd "p") #'evil-paste-after)
                (evil-local-set-key 'normal (kbd "P") #'evil-paste-before)))))
