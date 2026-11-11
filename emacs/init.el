
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(push '(fullscreen . maximized) default-frame-alist)

(when (file-exists-p custom-file)
  (load custom-file))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(setq make-backup-files nil) ; stop creating ~ files

(set-face-attribute 'default nil :height 120)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(blink-cursor-mode 0)
(global-visual-line-mode 1)

(global-display-line-numbers-mode 1)

(electric-pair-mode 1)
(use-package vterm
  :ensure t)

;; Org relate things 
(use-package magit
  :ensure t)
(use-package org-roam
  :ensure t)

(unless (file-directory-p "~/notes")
			  (make-directory "~/notes" t))

(unless (package-installed-p 'elcord)
  (package-install 'elcord))

(require 'elcord)
(elcord-mode)

(setq org-roam-directory (file-truename "~/notes"))
(setq find-file-visit-truename t)
(org-roam-db-autosync-mode)

;; Evil relate things

(unless (package-installed-p 'undo-tree)
  (package-install 'undo-tree))

(unless (package-installed-p 'undo-fu)
  (package-install 'undo-fu))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package general
  :ensure t)

(general-create-definer leader
  ;; :prefix my-leader
  :prefix "SPC")

(leader
  :keymaps 'normal
  ;; bind "SPC a"
  "o f" 'org-roam-node-find
  "o i" 'org-roam-node-insert
  "f"   'load-file)

(setq evil-insert-state-cursor '(box "black"))

;; Vertico things

(use-package vertico
  :custom
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :ensure t
  :init
  (vertico-mode))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; Emacs minibuffer configurations.
(use-package emacs
  :custom
  ;; Enable context menu. `vertico-multiform-mode' adds a menu in the minibuffer
  ;; to switch display modes.
  (context-menu-mode t)
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Do not allow the cursor in the minibuffer prompt
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))


(use-package rainbow-delimiters
  :ensure t)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(add-hook 'vterm-mode-hook #'(lambda () (display-line-numbers-mode -1)))

;; Auto completation

(use-package corfu
  :ensure t
  :init
  (global-corfu-mode))

;; Use Dabbrev with Corfu!
(use-package dabbrev
  ;; Swap M-/ and C-M-/
  :bind (("C-/" . dabbrev-completion)
         ("C-M-/" . dabbrev-expand))
  :config
  (add-to-list 'dabbrev-ignored-buffer-regexps "\\` ")
  (add-to-list 'dabbrev-ignored-buffer-modes 'authinfo-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'doc-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'pdf-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'tags-table-mode))

(use-package doom-themes
  :ensure t
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic nil) ; if nil, italics is universally disabled
  ;; for treemacs users
  :config
  (load-theme 'doom-acario-light)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))
