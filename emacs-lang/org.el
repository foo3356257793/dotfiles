;;; org.el --- mirrors ftplugin/org.lua -*- lexical-binding: t; -*-
;;
;; Real Emacs org-mode replaces the nvim fake-org (tex-syntax + manual regions);
;; its native fontification is a faithful improvement over the hand-rolled one.

(defun my/org-setup ()
  (setq-local tab-width 2 org-indent-mode t))

(add-hook 'org-mode-hook #'my/org-setup)

(with-eval-after-load 'evil
  (add-hook 'org-mode-hook
            (lambda ()
              (evil-local-set-key 'normal (kbd "go") (lambda () (interactive) (evil-open-below 1) (insert "- ")))
              (evil-local-set-key 'normal (kbd "gO") (lambda () (interactive) (evil-open-above 1) (insert "- "))))))
