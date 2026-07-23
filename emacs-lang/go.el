;;; go.el --- mirrors ftplugin/go.lua -*- lexical-binding: t; -*-

(defun my/go-setup ()
  (setq-local indent-tabs-mode t)   ; gofmt uses tabs
  (electric-pair-local-mode 1))

(dolist (hook '(go-mode-hook go-ts-mode-hook))
  (add-hook hook #'my/go-setup))
