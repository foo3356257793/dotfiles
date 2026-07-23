;;; sage.el --- mirrors ftplugin/sage.lua (.sage/.spyx as python) -*- lexical-binding: t; -*-
;;
;; .sage/.spyx open in python-mode (see dotemacs.el), so python.el already
;; applies.  Sage's `m' overrides with load(...) into a Sage REPL.

(defun my/sage-buffer-p ()
  (and buffer-file-name
       (string-match-p "\\.\\(sage\\|spyx\\)\\'" buffer-file-name)))

(defun my/sage-run ()
  "Save and load the file into an inferior Sage REPL (mirrors sage `m')."
  (interactive)
  (save-buffer)
  (my/repl-send
   "*Sage*"
   (lambda ()
     (if (fboundp 'sage-shell:run-sage)
         (sage-shell:run-sage "sage")
       (make-comint "Sage" "sage")))
   (format "load(\"%s\")" (buffer-file-name))))

(with-eval-after-load 'evil
  (dolist (hook '(python-mode-hook python-ts-mode-hook))
    (add-hook hook
              (lambda ()
                (when (my/sage-buffer-p)
                  (evil-local-set-key 'normal (kbd "m") #'my/sage-run))))))
