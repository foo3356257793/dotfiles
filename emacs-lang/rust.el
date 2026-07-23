;;; rust.el --- mirrors ftplugin/rust.lua -*- lexical-binding: t; -*-

(defun my/cargo-build ()
  "Save and cargo build (mirrors rust `m')."
  (interactive) (save-buffer) (compile "cargo build"))

(defun my/rust-setup ()
  (setq-local fill-column 80 tab-width 4 indent-tabs-mode nil)
  (electric-pair-local-mode 1))

(dolist (hook '(rust-mode-hook rust-ts-mode-hook))
  (add-hook hook #'my/rust-setup))

(with-eval-after-load 'evil
  (dolist (hook '(rust-mode-hook rust-ts-mode-hook))
    (add-hook hook (lambda () (evil-local-set-key 'normal (kbd "m") #'my/cargo-build)))))
