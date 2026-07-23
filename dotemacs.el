;;; dotemacs.el --- entry point -*- lexical-binding: t; -*-
;;
;; Emacs configuration mirroring the Neovim config (init.lua / packages.lua /
;; telescope_bindings.lua / ftplugin/*).  Vim emulation via Evil.  Loaded from
;; ~/.emacs.d/init.el (a symlink to this file).
;;
;;   dotemacs.el       -- this file: options, core keymaps, leader maps
;;   emacs-packages.el -- package declarations (mirrors packages.lua)
;;   emacs-lang/*.el   -- per-mode setup (mirrors ftplugin/*)
;;   emacs-machine.el  -- machine-specific, loaded if present (mirrors machine.lua)

;; ============================================================================
;; CONFIG DIRECTORY
;; ============================================================================

;; Resolve the real dotfiles directory through the init.el symlink so the
;; sibling files load regardless of where this is invoked from.
(defvar my/config-dir
  (file-name-directory (file-truename (or load-file-name buffer-file-name)))
  "Directory holding the Emacs config sources (the dotfiles repo).")

;; ============================================================================
;; PACKAGES  (installs + configures Evil, telescope-equivalents, etc.)
;; ============================================================================

(load (expand-file-name "emacs-packages.el" my/config-dir))

;; ============================================================================
;; UI  (mirrors dotemacs-style chrome + gvimrc font)
;; ============================================================================

(setq inhibit-startup-screen t
      ring-bell-function 'ignore)          ; errorbells = false

(when (display-graphic-p)
  (blink-cursor-mode 0)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (set-frame-font "JetBrains Mono 14" nil t))

(setq default-frame-alist '((width . 90) (height . 35))
      initial-frame-alist '((width . 90) (height . 35)))

;; Built-in dark theme (mirrors background=dark, native like colorscheme vim).
(load-theme 'modus-vivendi t)

;; Statusline: full file path only (mirrors opt.statusline = %{expand('%:p')}).
(setq-default mode-line-format
              '("%e" mode-line-front-space
                (:eval (or buffer-file-name "%b"))))

;; ============================================================================
;; OPTIONS  (mirrors init.lua option block)
;; ============================================================================

(setq-default indent-tabs-mode nil     ; expandtab
              tab-width 4               ; tabstop / shiftwidth
              truncate-lines nil)       ; wrap

(setq case-fold-search t                ; ignorecase (+ evil smartcase in pkgs)
      scroll-margin 5                   ; scrolloff
      hscroll-margin 5                  ; sidescrolloff
      scroll-conservatively 101
      select-enable-clipboard t         ; clipboard = unnamedplus
      history-length 1000               ; history
      shell-file-name "/usr/bin/zsh")

(global-visual-line-mode 1)            ; wrap + linebreak (word wrap)
(show-paren-mode 1)                    ; showmatch
(setq show-paren-delay 0.3)            ; matchtime ~ 3
(save-place-mode 1)                    ; return to last edit position (LineReturn)
(global-auto-revert-mode 1)            ; autoread
(setq global-auto-revert-non-file-buffers t)

;; autochdir: follow the current file's directory.
(add-hook 'find-file-hook
          (lambda ()
            (when buffer-file-name
              (setq default-directory (file-name-directory buffer-file-name)))))

;; ============================================================================
;; BACKUP / UNDO DIRECTORIES  (mirrors state dir setup; swapfile = false)
;; ============================================================================

(let ((backup (expand-file-name "backup/" user-emacs-directory))
      (swap   (expand-file-name "swap/"   user-emacs-directory)))
  (dolist (d (list backup swap))
    (unless (file-directory-p d) (make-directory d t)))
  (setq backup-directory-alist        `(("." . ,backup))
        auto-save-file-name-transforms `((".*" ,swap t))
        backup-by-copying t
        create-lockfiles nil))          ; swapfile = false

;; ============================================================================
;; TRAILING WHITESPACE  (mirrors EndOfLineSpace, hidden while inserting)
;; ============================================================================

(setq-default show-trailing-whitespace t)
(add-hook 'evil-insert-state-entry-hook
          (lambda () (setq show-trailing-whitespace nil)))
(add-hook 'evil-insert-state-exit-hook
          (lambda () (setq show-trailing-whitespace t)))
;; Don't nag in read-only/special buffers.
(dolist (h '(minibuffer-setup-hook special-mode-hook term-mode-hook))
  (add-hook h (lambda () (setq show-trailing-whitespace nil))))

;; ============================================================================
;; COMMANDS  (helpers behind the keymaps)
;; ============================================================================

(defun my/save-and-make ()
  "Save and run make (mirrors `m')."
  (interactive) (save-buffer) (compile "make"))

(defun my/paste-and-indent (paste-fn)
  "Run PASTE-FN then reindent the pasted region (mirrors p=`])."
  (funcall paste-fn 1)
  (let ((beg (evil-get-marker ?\[)) (end (evil-get-marker ?\])))
    (when (and beg end) (indent-region beg end))))

(defun my/paste-after-indent ()  (interactive) (my/paste-and-indent #'evil-paste-after))
(defun my/paste-before-indent () (interactive) (my/paste-and-indent #'evil-paste-before))

(defun my/scroll-down-3 () (interactive) (scroll-up 3))    ; C-e
(defun my/scroll-up-3   () (interactive) (scroll-down 3))  ; C-y

(defun my/strip-trailing-whitespace ()
  "Strip trailing whitespace, keeping point (mirrors <leader>r)."
  (interactive)
  (save-excursion (delete-trailing-whitespace)))

(defun my/upcase-word-insert ()
  "Uppercase the word at point, staying in insert (mirrors insert <C-u>)."
  (interactive)
  (let ((bounds (bounds-of-thing-at-point 'word)))
    (when bounds
      (upcase-region (car bounds) (cdr bounds))
      (goto-char (cdr bounds)))))

(defun my/split-below () (interactive) (split-window-below) (other-window 1)) ; _
(defun my/split-right () (interactive) (split-window-right) (other-window 1)) ; |

(defun my/frame-wide ()
  "Widen frame to 160 columns and split (mirrors <leader>+)."
  (interactive) (set-frame-width nil 160) (my/split-right))
(defun my/frame-narrow ()
  "Narrow frame to 80 columns (mirrors <leader>-)."
  (interactive) (set-frame-width nil 80))

(defun my/toggle-line-numbers ()
  (interactive) (display-line-numbers-mode 'toggle))

(defun my/refontify ()
  "Resync highlighting from buffer start (mirrors <leader>x)."
  (interactive) (font-lock-flush) (font-lock-ensure))

(defun my/inspect-face ()
  "Report the face at point (mirrors <F10> syntax inspect)."
  (interactive)
  (message "face<%s>" (or (get-text-property (point) 'face) 'default)))

(defun my/align-equals ()
  "Align `=' across the region or current paragraph (mirrors <leader>a=)."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (save-excursion
        (backward-paragraph) (setq beg (point))
        (forward-paragraph)  (setq end (point))))
    (align-regexp beg end "\\(\\s-*\\)=" 1 1 nil)))

(defun my/underline-headline (char)
  "Duplicate the current line as a rule of CHAR (mirrors <leader>h<c>)."
  (let* ((text (string-trim-right (thing-at-point 'line t)))
         (rule (make-string (max 1 (length text)) char)))
    (end-of-line)
    (insert "\n" rule)))

(defun my/frame-headline (char)
  "Surround the current line with rules of CHAR (mirrors <leader>H<c>)."
  (let* ((text (string-trim-right (thing-at-point 'line t)))
         (rule (make-string (max 1 (length text)) char)))
    (beginning-of-line) (insert rule "\n")
    (end-of-line)       (insert "\n" rule)))

(defun my/format-buffer ()
  "Format via apheleia (black/stylua), else eglot (mirrors <leader>cf)."
  (interactive)
  (if (and (fboundp 'apheleia-format-buffer)
           (assq major-mode apheleia-mode-alist))
      (call-interactively 'apheleia-format-buffer)
    (when (fboundp 'eglot-format) (eglot-format))))

(defun my/time-log ()
  "Pick a tag and log time (mirrors <leader>l fzf pipeline)."
  (interactive)
  (let* ((tags (split-string
                (shell-command-to-string "$HOME/Documents/time_logger/get_tags.py")
                "\n" t))
         (choice (completing-read "Tag: " tags)))
    (call-process-shell-command
     (format "printf %%s %s | $HOME/Documents/time_logger/log_time.py"
             (shell-quote-argument choice)))))

;; ============================================================================
;; BOOKMARKS  (mirrors <leader>0-5 config files + M append)
;; ============================================================================

(defvar my/bookmarks-file (expand-file-name "emacs-bookmarks.el" my/config-dir))
(when (file-exists-p my/bookmarks-file) (load my/bookmarks-file t))

(defun my/bookmark-add ()
  "Append a leader-9 binding for the current file to the bookmarks file (mirrors M)."
  (interactive)
  (let ((path (buffer-file-name)))
    (find-file my/bookmarks-file)
    (goto-char (point-max))
    (insert (format
             "\n(evil-leader/set-key \"9\" (lambda () (interactive) (find-file \"%s\")))\n"
             path))
    (goto-char (point-max))))

;; ============================================================================
;; CORE KEYMAPS  (evil global states -- mirrors init.lua non-leader maps)
;; ============================================================================

(with-eval-after-load 'evil
  (let ((n evil-normal-state-map)
        (i evil-insert-state-map)
        (v evil-visual-state-map))

    ;; save / make
    (define-key n (kbd "m") #'my/save-and-make)
    (define-key n (kbd "Q") #'save-buffer)
    (define-key n (kbd "Y") "y$")

    ;; insert-mode uppercase-word
    (define-key i (kbd "C-u") #'my/upcase-word-insert)

    ;; scroll 3 lines
    (define-key n (kbd "C-e") #'my/scroll-down-3)
    (define-key n (kbd "C-y") #'my/scroll-up-3)

    ;; splits
    (define-key n (kbd "_") #'my/split-below)
    (define-key n (kbd "|") #'my/split-right)

    ;; window navigation (normal + insert)
    (define-key n (kbd "C-h") #'evil-window-left)
    (define-key n (kbd "C-j") #'evil-window-down)
    (define-key n (kbd "C-k") #'evil-window-up)
    (define-key n (kbd "C-l") #'evil-window-right)
    (define-key i (kbd "C-h") (lambda () (interactive) (evil-normal-state) (evil-window-left 1)))
    (define-key i (kbd "C-j") (lambda () (interactive) (evil-normal-state) (evil-window-down 1)))
    (define-key i (kbd "C-k") (lambda () (interactive) (evil-normal-state) (evil-window-up 1)))
    (define-key i (kbd "C-l") (lambda () (interactive) (evil-normal-state) (evil-window-right 1)))

    ;; paste with auto-indent; C- variants bypass it
    (define-key n (kbd "p")   #'my/paste-after-indent)
    (define-key n (kbd "P")   #'my/paste-before-indent)
    (define-key n (kbd "C-p") #'evil-paste-after)
    (define-key n (kbd "C-S-p") #'evil-paste-before)

    ;; window resize (arrows)
    (define-key n (kbd "<up>")    (lambda () (interactive) (enlarge-window 5)))
    (define-key n (kbd "<down>")  (lambda () (interactive) (enlarge-window -5)))
    (define-key n (kbd "<left>")  (lambda () (interactive) (enlarge-window-horizontally 5)))
    (define-key n (kbd "<right>") (lambda () (interactive) (enlarge-window-horizontally -5)))

    ;; tabs (tab-bar) + buffers
    (define-key n (kbd "<tab>")     #'tab-bar-switch-to-next-tab)
    (define-key n (kbd "<backtab>") #'tab-bar-switch-to-prev-tab)
    (define-key n (kbd "-") #'previous-buffer)
    (define-key n (kbd "+") #'next-buffer)

    ;; inline path completion in insert (mirrors <C-x><C-f> telescope path)
    (define-key i (kbd "C-x C-f") #'cape-file)))

;; TAB in insert: indent at leading whitespace, else complete (mirrors init.lua).
(with-eval-after-load 'evil
  (define-key evil-insert-state-map (kbd "TAB")
              (lambda ()
                (interactive)
                (if (or (bolp) (looking-back "^[ \t]*" (line-beginning-position)))
                    (indent-for-tab-command)
                  (completion-at-point)))))

(tab-bar-mode 1)

;; ============================================================================
;; LEADER MAPS  (evil-leader -- mirrors <leader> maps)
;; ============================================================================

(with-eval-after-load 'evil-leader
  (evil-leader/set-key
    ;; misc
    "SPC" #'evil-ex-nohighlight                 ; <leader><space> noh
    "n"   #'my/toggle-line-numbers              ; toggle numbers
    "r"   #'my/strip-trailing-whitespace        ; strip trailing ws
    "x"   #'my/refontify                        ; syntax sync fromstart
    "l"   #'my/time-log                         ; time logger

    ;; columns
    "+"   #'my/frame-wide
    "-"   #'my/frame-narrow

    ;; tabs
    "t"   #'tab-new

    ;; format
    "cf"  #'my/format-buffer

    ;; telescope -> consult
    "b"   #'consult-buffer                       ; buffers
    "f"   #'consult-find                          ; find_files
    "/"   #'consult-ripgrep                       ; live_grep (rg)

    ;; git -> magit
    "gg"  #'magit-status
    "gc"  #'magit-commit
    "gp"  #'magit-push

    ;; align (tabularize)
    "a="  #'my/align-equals
    "A="  #'my/align-equals

    ;; bookmarks
    "0"   (lambda () (interactive) (find-file my/bookmarks-file))
    "1"   (lambda () (interactive) (find-file (expand-file-name "dotemacs.el" my/config-dir)))
    "2"   (lambda () (interactive) (find-file (expand-file-name "emacs-machine.el" my/config-dir)))
    "3"   (lambda () (interactive) (find-file (expand-file-name "emacs-packages.el" my/config-dir)))
    "4"   (lambda () (interactive) (find-file (expand-file-name "tmux.conf" my/config-dir)))
    "5"   (lambda () (interactive) (find-file (expand-file-name "zshrc" my/config-dir))))

  ;; headline underline / surround (mirrors <leader>h<c> / <leader>H<c>)
  (dolist (ch '(?= ?- ?# ?*))
    (evil-leader/set-key (concat "h" (char-to-string ch))
      (lambda () (interactive) (my/underline-headline ch)))
    (evil-leader/set-key (concat "H" (char-to-string ch))
      (lambda () (interactive) (my/frame-headline ch)))))

;; M in normal state appends a bookmark.
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "M") #'my/bookmark-add))

;; ============================================================================
;; TEMPLATES  (mirrors BufNewFile template() -> auto-insert)
;; ============================================================================

(require 'autoinsert)
(setq auto-insert-directory (expand-file-name "templates/" my/config-dir)
      auto-insert-query nil)                     ; insert without prompting
(auto-insert-mode 1)
(dolist (pair '(("\\.py\\'"          . "python.py")
                ("\\.sage\\'"        . "sage.sage")
                ("\\.spyx\\'"        . "sage.sage")
                ("\\.c\\'"           . "c.c")
                ("\\.\\(cpp\\|cc\\)\\'" . "cpp.cpp")
                ("\\.jl\\'"          . "julia.jl")
                ("\\.tex\\'"         . "latex.tex")
                ("\\.rs\\'"          . "rust.rs")
                ("\\.go\\'"          . "go.go")
                ("\\.pl\\'"          . "perl.pl")))
  (define-auto-insert (car pair) (cdr pair)))

;; ============================================================================
;; FILETYPE DETECTION  (mirrors vim.filetype.add)
;; ============================================================================

(add-to-list 'auto-mode-alist '("\\.sage\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.spyx\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.jl\\'"   . julia-mode))
(add-to-list 'auto-mode-alist '("\\.twiki\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.pl\\'"   . cperl-mode))
(add-to-list 'auto-mode-alist '("time_log.*\\.ya?ml\\'" . conf-mode))

;; ============================================================================
;; ABBREVIATIONS  (mirrors iabbrev reutrn -> return)
;; ============================================================================

(define-abbrev-table 'global-abbrev-table '(("reutrn" "return" nil 0)))
(setq-default abbrev-mode t)
(setq save-abbrevs nil)

;; ============================================================================
;; PER-MODE SETUP  (mirrors ftplugin/*)
;; ============================================================================

(let ((lang-dir (expand-file-name "emacs-lang/" my/config-dir)))
  (when (file-directory-p lang-dir)
    (dolist (f (directory-files lang-dir t "\\.el\\'"))
      (load f t))))

;; ============================================================================
;; MACHINE-SPECIFIC  (mirrors pcall(require, "machine"))
;; ============================================================================

(let ((machine (expand-file-name "emacs-machine.el" my/config-dir)))
  (when (file-exists-p machine)
    (condition-case err
        (load machine)
      (error (message "emacs-machine.el: %s" (error-message-string err))))))

;;; dotemacs.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
