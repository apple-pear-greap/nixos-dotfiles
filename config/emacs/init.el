;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
(setq confirm-kill-emacs #'y-or-n-p)
(electric-pair-mode t)
(add-hook 'prog-mode-hook #'show-paren-mode)
(column-number-mode t)
(global-auto-revert-mode t)
(delete-selection-mode t)
(setq make-backup-files nil)

;; inhibit some useless surface
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
;; disable annoying bell ring
(setq ring-bell-function #'ignore)
;; line number and relative line number
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(add-to-list 'default-frame-alist
	     '(font . "Maple Mono NF CN-16"))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; plugins
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package tokyo-night
  :ensure t
  :config
  (load-theme 'tokyo-night t))

(provide 'init)
;;; init.el ends here
