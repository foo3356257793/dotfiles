(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("melpa-stable" . "http://stable.melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))

(unless (package-installed-p 'use-package)
 (package-refresh-contents)
 (package-install 'use-package))

(setq inhibit-startup-screen t)
(when window-system
 (blink-cursor-mode 0) ; Disable cursor blinking
 (menu-bar-mode -1)     ; No menu bar
 (toggle-scroll-bar -1) ; No scroll bar
 (fringe-mode 0)        ; No fringe
 (tool-bar-mode -1)     ; No tool bar
)

(setq initial-frame-alist
 '(
   (vertical-scroll-bars . nil)
   (width . 90)
   (height . 35)
  ))

(setq default-frame-alist
 '(
   (vertical-scroll-bars . nil)
   (width . 90)
   (height . 35)
  ))

;;(set-frame-font "Inconsolata 16" nil t)
(set-frame-font "JetBrainsMono 14" nil t)

(add-hook 'text-mode-hook #'visual-line-mode)

(setq scroll-margin 4)

(use-package olivetti
 :ensure olivetti
 :config
 (progn
  (add-hook 'text-mode-hook (lambda()
                             (interactive)
                             (message "Olivetti text-mode-hook")
                             (setq olivetti-body-width 81)
                             ;(hide-mode-line-mode)
                             (olivetti-mode 1)))
  (add-hook 'prog-mode-hook (lambda()
                             (interactive)
                             (message "Olivetti prog-mode-hook")
                             (setq olivetti-body-width 81)
                             ;(hide-mode-line-mode)
                             (olivetti-mode 1)))))

(use-package spacemacs-theme
 :defer t
 :init (load-theme 'spacemacs-light t)
)

(setq-default mode-line-format '("%e" mode-line-front-space buffer-file-name))

(use-package bind-key
)

(use-package evil
 :init (progn
   (use-package evil-leader
    :init 
    ; I had to load these things first for evil collection
    (setq evil-want-integration nil)
    (setq evil-want-keybinding nil)
    ; I have to load evil-leader before evil
    (global-evil-leader-mode)
    :config (progn
      (setq evil-leader/in-all-states t)
      )
   )
   (evil-mode 1)
   )
)

(use-package evil-collection
 :ensure 
 :after evil
 :config (evil-collection-init))

(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
 ;; simple shortcuts from my vimrc
 ;; need to add the other-window part to make the splitting act the way I am used to
 "v" (lambda() (interactive) (evil-window-vsplit) (other-window 1))
 "s" (lambda() (interactive) (evil-window-split) (other-window 1))
 ;;"w" 'save-buffer
 ; change this to helm?
 "b" 'buffer-menu
 "n" 'previous-buffer
 ;"t" (lambda() (interactive) (select-frame (make-frame)) (sane-term-create))
 "t" 'my/shell-create
 ;"T" (lambda() (interactive) (sane-term-create) (make-frame) (previous-buffer))
 ;; edit emacs config
 "1" (lambda() (interactive)(find-file "~/dotfiles/dotemacs.org"))
 ; org-mode
 "p" 'org-toggle-latex-fragment
 "P" (lambda() (interactive) (setq current-prefix-arg '(16)) (call-interactively 'org-toggle-latex-fragment))
 ;;"r" (lambda () (interactive) (org-edit-src-exit) (org-ctrl-c-ctrl-c))
 "e" 'org-edit-src-exit
 "c" 'evil-close-folds
 "o" 'evil-open-folds
"l" 'LaTeX-environment
;;"m" 'my-compile
)

;; (eval-after-load "evil"
    ;;   '(progn
      ;;      (define-key evil-normal-state-map (kbd "C-h") #'evil-window-left)
      ;;      (define-key evil-normal-state-map (kbd "C-j") #'evil-window-down)
      ;;      (define-key evil-normal-state-map (kbd "C-k") #'evil-window-up)
      ;;      (define-key evil-normal-state-map (kbd "C-l") #'evil-window-right)
      ;;      (bind-key* (kbd "C-h") #'evil-window-left)
      ;;      (bind-key* (kbd "C-j") #'evil-window-down)
      ;;      (bind-key* (kbd "C-k") #'evil-window-up)
      ;;      (bind-key* (kbd "C-l") #'evil-window-right)
      ;;      )
    ;;   )

(eval-after-load "evil"
 '(progn
   (define-key evil-normal-state-map (kbd "C-h") #'evil-window-left)
   (define-key evil-normal-state-map (kbd "C-j") #'evil-window-down)
   (define-key evil-normal-state-map (kbd "C-k") #'evil-window-up)
   (define-key evil-normal-state-map (kbd "C-l") #'evil-window-right)
   (with-eval-after-load 'evil-maps
    '(progn
      (define-key evil-window-map (kbd "C-h") #'evil-window-left)
      (define-key evil-window-map (kbd "C-j") #'evil-window-down)
      (define-key evil-window-map (kbd "C-k") #'evil-window-up)
      (define-key evil-window-map (kbd "C-l") #'evil-window-right)
     )
   )
  )
)

(define-key evil-motion-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "k") 'evil-previous-visual-line)
(define-key evil-visual-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-visual-state-map (kbd "k") 'evil-previous-visual-line)

(use-package evil-surround
 :ensure t
 :config
 (global-evil-surround-mode 1))

(with-eval-after-load 'evil
 (defadvice forward-evil-paragraph (around default-values activate)
  (let ((paragraph-start (default-value 'paragraph-start))
        (paragraph-separate (default-value 'paragraph-separate)))
   ad-do-it)))
