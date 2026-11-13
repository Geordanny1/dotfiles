
(setq custom-file (concat user-emacs-directory "/custom.el"))

(load-file custom-file)

(push '(fullscreen . maximized) default-frame-alist)

(setq warning-suppress-types '((files))
      warning-suppress-log-types '((files)))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq make-backup-files nil) ; stop creating ~ files

(set-face-attribute 'default nil :height 120)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(blink-cursor-mode 0)
(electric-pair-mode 1)
(global-display-line-numbers-mode 1)

(global-visual-line-mode 1)
(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook))
  (add-hook mode(lambda () (display-line-numbers-mode 1))))


;; packages

(use-package htmlize
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

(use-package undo-tree
  :ensure t)

(use-package undo-fu
  :ensure t)

(unless (package-installed-p 'undo-fu)
  (package-install 'undo-fu))

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

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

;; Vertico things
(use-package vertico
  :custom
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :ensure t
  :init
  (vertico-mode))

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

