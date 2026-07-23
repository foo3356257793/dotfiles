;;; txt.el --- mirrors ftplugin/txt.lua -*- lexical-binding: t; -*-

(defun my/txt-setup ()
  (setq-local fill-column 68 tab-width 4)
  (dolist (p '(("teh" "the") ("hte" "the") ("taht" "that") ("htat" "that")
               ("thigns" "things") ("adn" "and") ("waht" "what")
               ("somewaht" "somewhat") ("tehn" "then") ("sucess" "success")
               ("succes" "success") ("sucessful" "successful")
               ("succesful" "successful") ("worte" "wrote") ("htem" "them")
               ("wsa" "was") ("ot" "to") ("mroe" "more")))
    (define-abbrev local-abbrev-table (car p) (cadr p)))
  (abbrev-mode 1))

(add-hook 'text-mode-hook #'my/txt-setup)

(with-eval-after-load 'evil
  (add-hook 'text-mode-hook
            (lambda ()
              (evil-local-set-key 'normal (kbd "go") (lambda () (interactive) (evil-open-below 1) (insert "- ")))
              (evil-local-set-key 'normal (kbd "gO") (lambda () (interactive) (evil-open-above 1) (insert "- "))))))
