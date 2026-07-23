;;; python.el --- mirrors ftplugin/python.lua + sage.lua -*- lexical-binding: t; -*-

(defun my/python-run ()
  "Save and %run the file in an inferior Python REPL (mirrors python `m')."
  (interactive)
  (save-buffer)
  (my/repl-send "*Python*" #'run-python
                (format "%%run \"%s\"" (buffer-file-name))))

(defun my/py-var-to-print ()
  "Filter the paragraph through py_var_to_print.py, then align `=' (mirrors <ll>lp)."
  (interactive)
  (let (beg end)
    (save-excursion
      (backward-paragraph) (setq beg (point))
      (forward-paragraph)  (setq end (point)))
    (shell-command-on-region beg end "$HOME/.vim/py_var_to_print.py" nil t)
    (my/align-equals)))

(defun my/py-timing-block ()
  "Insert a perf-counter timing block (mirrors <ll>lt)."
  (interactive)
  (end-of-line)
  (insert "\nstart_tm = time.perf_counter()\n\nend_tm = time.perf_counter()\n"
          "tot_tm = end_tm-start_tm\nprint('TIME = %.3lf' % tot_tm)"))

(defun my/python-setup ()
  (setq-local fill-column 80
              tab-width 4
              python-indent-offset 4)
  (electric-pair-local-mode 1))

(dolist (hook '(python-mode-hook python-ts-mode-hook))
  (add-hook hook #'my/python-setup))

(with-eval-after-load 'evil-leader
  (dolist (mode '(python-mode python-ts-mode))
    (evil-leader/set-key-for-mode mode "lp" #'my/py-var-to-print)
    (evil-leader/set-key-for-mode mode "lt" #'my/py-timing-block)))

;; Python's `m' overrides the global save+make with a REPL %run.
(with-eval-after-load 'evil
  (dolist (hook '(python-mode-hook python-ts-mode-hook))
    (add-hook hook
              (lambda () (evil-local-set-key 'normal (kbd "m") #'my/python-run)))))
