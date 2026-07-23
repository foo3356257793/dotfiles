;;; twiki.el --- mirrors ftplugin/twiki.lua (.twiki as markdown + math) -*- lexical-binding: t; -*-
;;
;; .twiki opens in markdown-mode (see dotemacs.el); add inline/display $math$
;; highlighting on top.

(add-hook 'markdown-mode-hook
          (lambda ()
            (when (and buffer-file-name (string-match-p "\\.twiki\\'" buffer-file-name))
              (font-lock-add-keywords
               nil
               '(("\\$\\$\\(?:.\\|\n\\)*?\\$\\$" 0 font-lock-keyword-face t)
                 ("\\$[^$]+?\\$"                 0 font-lock-keyword-face t))
               t)
              (font-lock-flush))))
