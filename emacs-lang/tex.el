;;; tex.el --- mirrors ftplugin/tex.lua -*- lexical-binding: t; -*-

(defun my/tex-env (env)
  "Insert a LaTeX ENV, point on the blank middle line."
  (insert (format "\\begin{%s}\n\n\\end{%s}" env env))
  (forward-line -1) (end-of-line))

(defun my/tex-quote ()
  "Wrap WORD at point in ``...'' (mirrors <ll>\")."
  (interactive)
  (let ((b (bounds-of-thing-at-point 'word)))
    (when b
      (goto-char (cdr b)) (insert "''")
      (goto-char (car b)) (insert "``"))))

(defun my/tex-setup ()
  (setq-local fill-column 68 tab-width 2 indent-tabs-mode nil)
  ;; typo-correction abbrevs
  (dolist (p '(("teh" "the") ("hte" "the") ("taht" "that") ("htat" "that")
               ("thigns" "things") ("adn" "and") ("waht" "what")
               ("somewaht" "somewhat") ("tehn" "then") ("sucess" "success")
               ("succes" "success") ("sucessful" "successful")
               ("succesful" "successful") ("worte" "wrote") ("htem" "them")
               ("wsa" "was") ("ot" "to") ("mroe" "more")))
    (define-abbrev local-abbrev-table (car p) (cadr p)))
  (abbrev-mode 1))

(dolist (hook '(LaTeX-mode-hook latex-mode-hook tex-mode-hook))
  (add-hook hook #'my/tex-setup))

(with-eval-after-load 'evil
  (dolist (hook '(LaTeX-mode-hook latex-mode-hook tex-mode-hook))
    (add-hook hook
              (lambda ()
                (evil-local-set-key 'normal (kbd "go") (lambda () (interactive) (evil-open-below 1) (insert "\\item ")))
                (evil-local-set-key 'normal (kbd "gO") (lambda () (interactive) (evil-open-above 1) (insert "\\item ")))))))

(with-eval-after-load 'evil-leader
  (dolist (mode '(latex-mode LaTeX-mode tex-mode))
    (evil-leader/set-key-for-mode mode "li" (lambda () (interactive) (my/tex-env "itemize")   (insert "\n\\item ")))
    (evil-leader/set-key-for-mode mode "le" (lambda () (interactive) (my/tex-env "enumerate") (insert "\n\\item ")))
    (evil-leader/set-key-for-mode mode "la" (lambda () (interactive) (my/tex-env "align*")))
    (evil-leader/set-key-for-mode mode "lb" (lambda () (interactive) (my/tex-env "bmatrix")))
    (evil-leader/set-key-for-mode mode "ls" (lambda () (interactive) (insert "\\section{}")       (backward-char)))
    (evil-leader/set-key-for-mode mode "lS" (lambda () (interactive) (insert "\\subsection{}")    (backward-char)))
    (evil-leader/set-key-for-mode mode "lB" (lambda () (interactive) (insert "\\subsubsection{}") (backward-char)))
    (evil-leader/set-key-for-mode mode "lp" (lambda () (interactive) (insert "\\paragraph{}")     (backward-char)))))
