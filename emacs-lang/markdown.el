;;; markdown.el --- mirrors ftplugin/markdown.lua -*- lexical-binding: t; -*-
;;
;; markdown-mode provides its own heading/emphasis fontification, so the manual
;; matchadd() highlight layer from the nvim ftplugin is dropped in its favour.

(defun my/md-codeblock-eval (&optional whole)
  "Save and eval the code block at point (or WHOLE file) in *Python* (mirrors <leader>m/M)."
  (interactive)
  (save-buffer)
  (my/repl-send "*Python*" #'run-python
                (if whole
                    (format "codeblock_eval(\"%s\")" (buffer-file-name))
                  (format "codeblock_eval(\"%s\",%d)"
                          (buffer-file-name) (line-number-at-pos)))))

(defun my/md-date-header ()
  "Insert a dated markdown header (mirrors <leader>G)."
  (interactive)
  (insert (format "# %s\n\t= " (format-time-string "%Y%m%d"))))

(defun my/md-full-date ()
  "Insert the full date at point (mirrors <leader>T)."
  (interactive)
  (insert (format-time-string "%a %b %d %Y")))

(defun my/md-setup ()
  (setq-local tab-width 2 fill-column 0))

(add-hook 'markdown-mode-hook #'my/md-setup)

(with-eval-after-load 'evil
  (add-hook 'markdown-mode-hook
            (lambda ()
              (evil-local-set-key 'normal (kbd "go") (lambda () (interactive) (evil-open-below 1) (insert "* ")))
              (evil-local-set-key 'normal (kbd "gO") (lambda () (interactive) (evil-open-above 1) (insert "* "))))))

(with-eval-after-load 'evil-leader
  (evil-leader/set-key-for-mode 'markdown-mode "lc"
    (lambda () (interactive) (insert "```python\n\n```") (forward-line -1)))
  (evil-leader/set-key-for-mode 'markdown-mode "lp" #'my/py-var-to-print)
  (evil-leader/set-key-for-mode 'markdown-mode "m"  #'my/md-codeblock-eval)
  (evil-leader/set-key-for-mode 'markdown-mode "M"  (lambda () (interactive) (my/md-codeblock-eval t)))
  (evil-leader/set-key-for-mode 'markdown-mode "G"  #'my/md-date-header)
  (evil-leader/set-key-for-mode 'markdown-mode "T"  #'my/md-full-date)
  ;; math snippets
  (evil-leader/set-key-for-mode 'markdown-mode "l(" (lambda () (interactive) (my/tex-env "") (delete-char 8) (insert "\\left(\n\n\\right)") (forward-line -1)))
  (evil-leader/set-key-for-mode 'markdown-mode "la" (lambda () (interactive) (my/tex-env "align*")))
  (evil-leader/set-key-for-mode 'markdown-mode "lb" (lambda () (interactive) (my/tex-env "bmatrix"))))
