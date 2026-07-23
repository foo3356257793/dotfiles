;;; lua.el --- mirrors ftplugin/lua.lua -*- lexical-binding: t; -*-

(defun my/lua-run ()
  "Save and dofile the file in an inferior Lua REPL (mirrors lua `m')."
  (interactive)
  (save-buffer)
  (if (fboundp 'lua-send-string)
      (progn (unless (and (boundp 'lua-process) (process-live-p lua-process))
               (when (fboundp 'lua-start-process) (lua-start-process)))
             (lua-send-string (format "dofile(\"%s\")" (buffer-file-name))))
    (my/repl-send "*lua*" (lambda () (make-comint "lua" "lua"))
                  (format "dofile(\"%s\")" (buffer-file-name)))))

(with-eval-after-load 'evil
  (dolist (hook '(lua-mode-hook lua-ts-mode-hook))
    (add-hook hook (lambda () (evil-local-set-key 'normal (kbd "m") #'my/lua-run)))))
