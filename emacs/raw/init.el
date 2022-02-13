(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))
(package-install-selected-packages)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package diminish)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(global-hl-line-mode +1)

(set-face-attribute 'default nil :font "Source Code Pro" :height 120)

(column-number-mode)
(global-display-line-numbers-mode t)
(show-paren-mode 1)

(add-hook 'prog-mode-hook
	  (lambda ()
	    (add-hook 'before-save-hook 'delete-trailing-whitespace)))

(dolist (mode '(term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq backup-by-copying t
      backup-directory-alist
      '(("." . "~/.emacs-backups/"))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(use-package avy
  :bind (("C-'" . avy-goto-char-timer)))

(use-package counsel
  :demand
  :config (counsel-mode 1)
  (ivy-mode 1)
  :bind (("C-f" . swiper)
	 ("C-S-p" . counsel-M-x)
	 :map ivy-minibuffer-map
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package gruvbox-theme
	     :config (load-theme 'gruvbox-dark-medium t))


(use-package all-the-icons
  :if (display-graphic-p))

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package which-key
  :diminish
  :config (setq which-key-idle-delay 0.3)
  (which-key-mode))

(use-package general
  :demand
  :config
  (general-create-definer personal/leader-keys
    :states '(normal visual insert motion)
    :prefix "C-SPC")
  (general-create-definer personal/major-mode-leader-keys
    :states '(normal visual insert motion)
    :prefix "C-,")
  )

(use-package treemacs)

(use-package evil
  :init (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :init (setq evil-want-keybinding nil)
  :config (evil-collection-init))

(use-package treemacs-evil)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package paredit
  :hook (prog-mode . enable-paredit-mode))

(use-package company
  :demand
  :config (global-company-mode))

(use-package flycheck)

(use-package projectile
  :demand
  :bind-keymap ("C-c p" . projectile-command-map)
  :init (when (file-directory-p "~/D/I")
	  (setq projectile-project-search-path '("~/D/I")))
  :config
  (projectile-mode +1))

(use-package ripgrep
  :demand)

(use-package projectile-ripgrep
  :after projectile)

(use-package counsel-projectile
  :config (counsel-projectile-mode t))

(use-package treemacs-projectile)

(use-package magit
  :config (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1))

(use-package treemacs-magit)

(use-package forge
  :after magit)

(use-package magit-gitflow
  :hook 'magit-mode-hook (turn-on-magit-gitflow))

(use-package magit-todos
  :after magit
  :config (magit-todos-mode t))

(use-package git-timemachine
  :commands (git-timemachine-toggle))

(use-package git-messenger
  :commands (git-messenger:popup-message))

(use-package smeargle)

(use-package org
  :custom (org-ellipsis " ➤")
  (org-log-done 'time)
  (org-agenda-start-with-log-mode t)
  (org-agenda-files
	   '("~/Documents/org-mode/agenda/birthdays.org")))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))

(use-package lsp-mode
  :hook ((clojure-mode . lsp)
	 (clojurec-mode . lsp)
	 (clojurescript-mode . lsp)
	 (lsp-mode . lsp-enable-which-key-integration))
  :init (setq auto-add-ns-to-new-files? 0) ;; We'll get this from clj-refactor
  :config
  (setq lsp-lens-enable t
	company-minimum-prefix-length 1))

(use-package lsp-treemacs)

(use-package lsp-ui
  :commands ls-ui-mode)

(use-package lsp-ivy
  :after (lsp-mode ivy))

(use-package dap-mode
  :after (lsp-mode))

(use-package yasnippet
  :config (yas-global-mode 1))

(use-package dash
    :after yasnippet)

(use-package ivy-yasnippet
  :after yasnippet dash
  :config 'ivy-yasnippet)

(use-package clojure-mode
  :config (general-define-key
	   :states '(normal visual insert motion)
	   "M-RET" 'clojure-refactor-map
	   "M-RET n" '(:ignore t :which-key "namespace")
	   "M-RET s" '(:ignore t :which-key "slurp-let"))
  (personal/leader-keys
    "a" 'clojure-align
    ))

(defun setup-clj-refactor-keys ()
  (general-define-key
   :states '(normal visual insert motion)
   "M-RET ra" '(:ignore t :which-key "add")
   "M-RET rc" '(:ignore t :which-key "cycle")
   "M-RET rd" '(:ignore t :which-key "destructure")
   "M-RET re" '(:ignore t :which-key "extract/expand")
   "M-RET rf" '(:ignore t :which-key "function")
   "M-RET rh" '(:ignore t :which-key "hydra/hotload")
   "M-RET ri" '(:ignore t :which-key "introduce/inline")
   "M-RET rm" '(:ignore t :which-key "move")
   "M-RET rp" '(:ignore t :which-key "project/promote")
   "M-RET rr" '(:ignore t :which-key "rename/remove")
   "M-RET rs" '(:ignore t :which-key "sort/stop deps")
   "M-RET rt" '(:ignore t :which-key "thread")
   "M-RET ru" '(:ignore t :which-key "unwind"))
  )

(use-package clj-refactor
  :hook ((clojure-mode . clj-refactor-mode)
	 (clojurec-mode . clj-refactor-mode)
	 (clojurescript-mode . clj-refactor-mode)
	 )
  :config
  (cljr-add-keybindings-with-prefix "M-RET r")
  (setup-clj-refactor-keys))

(use-package clojure-snippets
  :after (clojure-mode yassnippet)
  :config (personal/leader-keys
	    "i" 'ivy-yasnippet))

(use-package cider
  :commands (cider cider-connect cider-jack-in)
  :custom
  (cider-eval-toplevel-inside-comment-form t)
  (clojure-eval-toplevel-inside-comment-form t)
  :config
  (personal/leader-keys
    "'" '(:ignore t :which-key "cider")
    "'jj" 'cider-jack-in-clj
    "'js" 'cider-jack-in-cljs
    "'jc" 'cider-jack-in-clj&cljs
    "s" 'sesman-map
    "h" '(:ignore t :which-key "doc")
    "hd" 'cider-doc
    "hj" 'cider-javadoc
    "hc" 'cider-clojure-docs
    "ha" 'cider-apropos
    "hA" 'cider-apropos-documentation
    "hw" 'cider-clojuredocs-web
    "hn" 'cider-browse-ns
    "e" '(:ignore t :which-key "eval")
    "ee" 'cider-eval-defun-at-point
    "eE" 'cider-eval-defun-to-comment
    "ef" 'cider-eval-last-sexp
    "eb" 'cider-eval-buffer
    "ec" 'cider-eval-commands-map
    "d" '(:ignore t :which-key "debug")
    "dd" 'cider-debug-defun-at-point
    "f" '(:ignore t :which-key "format")
    "ff" 'cider-format-defun
    "fr" 'cider-format-region
    "fb" 'cider-format-buffer)
  (add-hook 'before-save-hook 'cider-format-buffer t t)
  (general-define-key
   :states '(normal visual insert motion)
   "C-RET" 'cider-eval-defun-at-point))

(use-package hydra
  :config
  (defhydra hydra-text-scale (:timeout 15)
    "scale text"
    ("k" text-scale-increase "Scale [+]")
    ("j" text-scale-decrease "Scale [-]")
    ("f" nil "finish" :exit t))

  (defhydra hydra-smeargle ()
    "Show age"
    ("c" smeargle-commits "by commit")
    ("t" smeargle "by time")
    ("z" smeargle-clear "clear")
    ("f" (smeargle-clear) "finish and clear" :exit t)
    ("F" nil "finish" :exit t))

  ; This function courtesy of https://emacsredux.com/blog/2013/04/02/move-current-line-up-or-down/
  (defun move-line-up ()
    "Move up the current line."
    (interactive)
    (transpose-lines 1)
    (forward-line -2)
    (indent-according-to-mode))

  (defun move-line-down ()
    "Move down the current line."
    (interactive)
    (forward-line 1)
    (transpose-lines 1)
    (forward-line -1)
    (indent-according-to-mode))

  (defhydra hydra-move-lines ()
    "Move lines"
    ("j" (move-line-down) "Move down")
    ("k" (move-line-up) "Move up")
    ("f" nil "finish" :exit t)))

(general-unbind "C-SPC") ; This is normally mark, but we're evil now
(general-define-key
   :states '(motion normal insert visual)
   "C-z" 'undo
   "C-S-z" 'undo-redo
   "C-S-c" 'clipbaord-kill-ring-save
   "C-S-v" 'clipboard-yank
   "C-S-x" 'clipboard-kill-region
   "C-s" 'save-buffer
   "C-f" 'swiper
   "C-S-f" 'projectile-ripgrep
   "C-<tab>" 'switch-to-buffer)


(personal/leader-keys
  :states '(motion normal insert visual)
  "A" '(:ignore t :which-key "appearance")
  "Az" '(hydra-text-scale/body :which-key "zoom")

  "p" 'projectile-command-map
  "ps" '(:ignore t :which-key "search")
  "ps" '(:ignore t :which-key "execute")
  "pO" '(:ignore t :which-key "org-mode")

  "f" '(:ignore t :which-key "files")
  "fr" 'counsel-buffer-or-recentf

  "g" '(:ignore t :which-key "git")
  "gs" 'magit-status
  "gt" 'git-timemachine
  "gm" 'git-messenger:popup-message
  "ga" '(hydra-smeargle/body :which-key "show-age")

  "b" '(:ignore t :which-key "buffer")
  "bm" '(hydra-move-lines/body :which-key "move-lines")

  "d" '(:ignore t :which-key "dir-locals")
  "de" '(projectile-edit-dir-locals)
  "dl" '(hack-dir-local-variables)
  )

(defun cwchriswilliams/org-babel-auto-tangle()
  (when (string-equal (buffer-file-name)
		      (expand-file-name "~/D/I/linux_config/emacs/raw/init.org"))
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'cwchriswilliams/org-babel-auto-tangle)))
