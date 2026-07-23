;;; emacs-packages.el --- package declarations -*- lexical-binding: t; -*-
;;
;; Mirrors packages.lua.  Uses the built-in package.el + use-package (the
;; native packager, matching the nvim vim.pack choice).  Every package is
;; :ensure t so a fresh machine installs them on first launch.

;; ============================================================================
;; PACKAGE.EL BOOTSTRAP
;; ============================================================================

(require 'package)
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Fetch archive contents so :ensure can install.  Refresh when the cache is
;; missing OR stale (>7 days): a stale index lists package versions MELPA has
;; already replaced, which 404s on install.
(let ((archive (expand-file-name "elpa/archives/melpa/archive-contents"
                                 user-emacs-directory)))
  (when (or (not package-archive-contents)
            (not (file-exists-p archive))
            (> (float-time (time-since (file-attribute-modification-time
                                        (file-attributes archive))))
               (* 7 24 3600)))
    (package-refresh-contents)))

;; use-package ships with Emacs 29+; install it only if somehow absent.
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; ----------------------------------------------------------------------------
;; Evil load-time settings.  These must be set BEFORE anything pulls in Evil --
;; and `evil-leader' requires Evil when it loads -- so plain setq up front,
;; ahead of every use-package form below.
;; ----------------------------------------------------------------------------
(setq evil-want-integration t
      evil-want-keybinding nil        ; required before evil-collection
      evil-want-C-u-scroll nil        ; we rebind C-u ourselves
      evil-search-module 'evil-search
      evil-undo-system 'undo-fu
      evil-split-window-below t       ; splitbelow
      evil-vsplit-window-right t      ; splitright
      evil-shift-width 4)

;; ============================================================================
;; EVIL  (mirrors the vim-emulation core)
;; ============================================================================

;; Persistent undo (mirrors undofile / undoreload) + clean evil undo/redo.
;; Declared before evil so `evil-undo-system' resolves.
(use-package undo-fu)
(use-package undo-fu-session
  :config
  (undo-fu-session-global-mode 1))

;; evil-leader must load before evil (it requires evil on load; the load-time
;; evil-want-* vars are already set at the top of this file).
(use-package evil-leader
  :config
  (global-evil-leader-mode)
  (setq evil-leader/in-all-states t)
  (evil-leader/set-leader "<SPC>"))

(use-package evil
  :after evil-leader
  :init
  ;; runtime search/substitute behaviour (smartcase, gdefault, cross-line)
  (setq evil-ex-search-case 'smart
        evil-ex-substitute-global t   ; gdefault
        evil-cross-lines t)           ; whichwrap h/l/etc
  :config
  (evil-mode 1)
  ;; j/k move by visual line (mirrors map n j gj / k gk)
  (define-key evil-motion-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-motion-state-map (kbd "k") 'evil-previous-visual-line)
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

;; ============================================================================
;; MINIBUFFER / FUZZY FINDER  (mirrors telescope)
;; ============================================================================

(use-package vertico
  :init (vertico-mode))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-overrides '((file (styles partial-completion)))))

(use-package marginalia
  :init (marginalia-mode))

(use-package consult
  ;; <leader> b / f / / are bound in dotemacs.el via evil-leader.
  :config
  ;; Use ripgrep for live-grep (mirrors telescope live_grep).
  (setq consult-narrow-key "<"))

;; ============================================================================
;; IN-BUFFER COMPLETION  (mirrors the <Tab> popup)
;; ============================================================================

(use-package corfu
  :init
  (setq corfu-auto t
        corfu-auto-prefix 2
        corfu-cycle t
        corfu-preselect 'prompt)
  (global-corfu-mode)
  :config
  ;; TAB cycles the popup, matching pum navigation.
  (define-key corfu-map (kbd "TAB") 'corfu-next)
  (define-key corfu-map (kbd "<tab>") 'corfu-next)
  (define-key corfu-map (kbd "S-TAB") 'corfu-previous)
  (define-key corfu-map (kbd "<backtab>") 'corfu-previous))

(use-package cape
  :init
  ;; buffer-keyword completion (mirrors <C-p> dabbrev) + file completion
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

;; ============================================================================
;; LSP  (mirrors vim.lsp -> eglot, built-in)
;; ============================================================================

;; eglot ships with Emacs 29+.  Servers must be installed per-machine:
;;   clangd, gopls, lua-language-server, pyright, rust-analyzer
(use-package eglot
  :ensure nil
  :hook ((python-mode      . eglot-ensure)
         (python-ts-mode   . eglot-ensure)
         (c-mode           . eglot-ensure)
         (c-ts-mode        . eglot-ensure)
         (c++-mode         . eglot-ensure)
         (c++-ts-mode      . eglot-ensure)
         (go-mode          . eglot-ensure)
         (go-ts-mode       . eglot-ensure)
         (rust-mode        . eglot-ensure)
         (rust-ts-mode     . eglot-ensure)
         (lua-mode         . eglot-ensure)))

;; ============================================================================
;; FORMATTING  (mirrors conform.nvim -> apheleia, manual)
;; ============================================================================

(use-package apheleia
  ;; No format-on-save; invoked manually via <leader>cf (see dotemacs.el).
  :config
  (setf (alist-get 'python-mode    apheleia-mode-alist) 'black)
  (setf (alist-get 'python-ts-mode apheleia-mode-alist) 'black)
  (setf (alist-get 'lua-mode       apheleia-mode-alist) 'stylua)
  (setf (alist-get 'lua-ts-mode    apheleia-mode-alist) 'stylua))

;; ============================================================================
;; GIT  (mirrors vim-fugitive -> magit)
;; ============================================================================

(use-package magit
  :commands (magit-status magit-commit magit-push))

;; ============================================================================
;; RAINBOW DELIMITERS  (direct mirror; whitelist code langs)
;; ============================================================================

(use-package rainbow-delimiters
  :hook ((prog-mode . rainbow-delimiters-mode)))

;; ============================================================================
;; ZEN / DISTRACTION-FREE  (mirrors zen-mode -> olivetti, toggled)
;; ============================================================================

(use-package olivetti
  :commands (olivetti-mode)
  :init (setq olivetti-body-width 81))

;; ============================================================================
;; LATEX  (mirrors vimtex -> full AUCTeX + reftex + SyncTeX)
;; ============================================================================

;; AUCTeX doesn't (provide 'auctex), so config hangs off `tex'/LaTeX-mode-hook
;; rather than use-package's :config, which would never fire.
(use-package auctex
  :defer t
  :mode ("\\.tex\\'" . LaTeX-mode)
  :init
  (setq TeX-auto-save t
        TeX-parse-self t
        TeX-command-default "LatexMk"
        TeX-source-correlate-mode t
        TeX-source-correlate-start-server t
        reftex-plug-into-AUCTeX t)
  (add-hook 'LaTeX-mode-hook #'reftex-mode)
  (with-eval-after-load 'tex
    ;; latexmk as the compile command; pdf-tools for SyncTeX if available.
    (when (require 'auctex-latexmk nil t)
      (auctex-latexmk-setup))
    (when (fboundp 'pdf-tools-install)
      (setq TeX-view-program-selection '((output-pdf "PDF Tools"))))
    (add-hook 'TeX-after-compilation-finished-functions
              #'TeX-revert-document-buffer)))

(use-package auctex-latexmk :defer t)

(use-package pdf-tools
  :defer t
  :magic ("%PDF" . pdf-view-mode)
  :config (pdf-tools-install :no-query))

;; ============================================================================
;; LANGUAGE MODES  (non-core-builtin)
;; ============================================================================

(use-package markdown-mode
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.twiki\\'" . markdown-mode)))

(use-package lua-mode)
(use-package go-mode)
(use-package rust-mode)
(use-package julia-mode)
(use-package julia-repl
  :hook (julia-mode . julia-repl-mode))

;; Sage: sage-shell-mode gives a Sage inferior REPL; .sage/.spyx edit as
;; python-mode (see dotemacs.el auto-mode-alist).  Optional -- guarded so a
;; failed install doesn't break startup.
(use-package sage-shell-mode
  :defer t)

(provide 'emacs-packages)
;;; emacs-packages.el ends here
