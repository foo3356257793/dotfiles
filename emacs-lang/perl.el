;;; perl.el --- mirrors ftplugin/perl.lua -*- lexical-binding: t; -*-

(defun my/perl-check ()
  "Run `perl -c' on the file (mirrors makeprg / <ll>k)."
  (interactive) (save-buffer) (compile (format "perl -c %s" (buffer-file-name))))

(defun my/perl-run ()
  "Run the file with perl (mirrors <ll>k)."
  (interactive) (save-buffer) (compile (format "perl %s" (buffer-file-name))))

(defun my/perl-setup ()
  (setq-local fill-column 80 cperl-indent-level 2 tab-width 4 indent-tabs-mode nil)
  (electric-pair-local-mode 1))

(add-hook 'cperl-mode-hook #'my/perl-setup)

(with-eval-after-load 'evil-leader
  (evil-leader/set-key-for-mode 'cperl-mode "=" #'my/reindent-buffer)
  (evil-leader/set-key-for-mode 'cperl-mode "cx" #'my/comment-banner)
  (evil-leader/set-key-for-mode 'cperl-mode "k" #'my/perl-run))
