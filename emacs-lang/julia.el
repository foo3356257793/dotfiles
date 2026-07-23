;;; julia.el --- mirrors ftplugin/julia.lua -*- lexical-binding: t; -*-

(defun my/julia-run ()
  "Save and include the file in the Julia REPL (mirrors julia `m')."
  (interactive)
  (save-buffer)
  (if (fboundp 'julia-repl-send-string)
      (progn (julia-repl-send-string (format "include(\"%s\")" (buffer-file-name))))
    (my/repl-send "*julia*" (lambda () (when (fboundp 'julia-repl) (julia-repl)))
                  (format "include(\"%s\")" (buffer-file-name)))))

(defun my/julia-testset ()
  "Insert a @testset skeleton (mirrors <ll>lt)."
  (interactive)
  (insert "function TEST_XXX()\n@testset \"TEST XXX\" begin\n\nend\nend"))

(defun my/julia-function ()
  "Insert a function skeleton (mirrors <ll>lf)."
  (interactive)
  (insert "function \nend") (forward-line -1) (end-of-line))

(with-eval-after-load 'evil
  (add-hook 'julia-mode-hook
            (lambda () (evil-local-set-key 'normal (kbd "m") #'my/julia-run))))

(with-eval-after-load 'evil-leader
  (evil-leader/set-key-for-mode 'julia-mode "lt" #'my/julia-testset)
  (evil-leader/set-key-for-mode 'julia-mode "lf" #'my/julia-function))
