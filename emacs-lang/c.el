;;; c.el --- mirrors ftplugin/c.lua (+ cpp.lua reuses it) -*- lexical-binding: t; -*-

(defun my/reindent-buffer ()
  "Reindent the whole buffer (mirrors <ll>= gg=G)."
  (interactive) (indent-region (point-min) (point-max)))

(defun my/comment-banner ()
  "Fill the line to column 80 with `#' (mirrors <ll>cx)."
  (interactive)
  (end-of-line)
  (when (< (current-column) 80)
    (insert (make-string (- 80 (current-column)) ?#))))

(defun my/c-make ()
  "Save and make (mirrors c `M')."
  (interactive) (save-buffer) (compile "make"))

(defun my/c-setup ()
  (setq-local fill-column 80 c-basic-offset 2 tab-width 2 indent-tabs-mode nil)
  (electric-pair-local-mode 1))

(dolist (hook '(c-mode-hook c-ts-mode-hook c++-mode-hook c++-ts-mode-hook))
  (add-hook hook #'my/c-setup))

(with-eval-after-load 'evil
  (dolist (hook '(c-mode-hook c-ts-mode-hook c++-mode-hook c++-ts-mode-hook))
    (add-hook hook (lambda () (evil-local-set-key 'normal (kbd "M") #'my/c-make)))))

(with-eval-after-load 'evil-leader
  (dolist (mode '(c-mode c-ts-mode c++-mode c++-ts-mode))
    (evil-leader/set-key-for-mode mode "=" #'my/reindent-buffer)
    (evil-leader/set-key-for-mode mode "cx" #'my/comment-banner)))
