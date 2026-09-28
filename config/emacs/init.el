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
(pixel-scroll-precision-mode nil)

(add-to-list 'default-frame-alist
	     '(font . "Maple Mono NF CN-16"))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;;keybindings
(global-set-key (kbd "C-c '") 'comment-or-uncomment-region) ;; add comment

;; plugins
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; theme
;; (use-package tokyo-night
;;   :ensure t
;;   :config
;;   (load-theme 'tokyo-night t))
;; (load-theme 'dracula t)

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold nil    ; if nil, bold is universally disabled
	doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-monokai-octagon t)
  (doom-themes-treemacs-config))

;; ivy for search
(use-package counsel
  :ensure t)

(use-package ivy
  :ensure t
  :init
  (ivy-mode 1)
  (counsel-mode 1)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq search-default-mode #'char-fold-to-regexp)
  (setq ivy-count-format "(%d/%d) ")
  :bind
  (("C-s" . 'swiper)
   ("C-x b" . 'ivy-switch-buffer)
   ("C-c v" . 'ivy-push-view)
   ("C-c s" . 'ivy-switch-view)
   ("C-c V" . 'ivy-pop-view)
   ("C-x C-SPC" . 'counsel-mark-ring)
   :map minibuffer-local-map
   ("C-r" . counsel-minibuffer-history)))

;; amx for M-x command history
(use-package amx
  :ensure t
  :init (amx-mode))

;; ace-window for move in mutiple windows
(use-package ace-window
  :ensure t
  :bind (("C-x o" . 'ace-window)))

(use-package mwim
  :ensure t
  :bind
  (("C-a" . mwim-beginning-of-code-or-line)
   ("C-e" . mwim-end-of-code-or-line)))

(use-package multiple-cursors
  :ensure t
  :bind
  (("C-S-<mouse-1>" . mc/toggle-cursor-on-click)
   ("C-x Q l" . mc/edit-lines)
   ("C-x Q n" . mc/edit-next-like-this)))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; company config
(use-package company
  :ensure t
  :init (global-company-mode)
  :config
  (setq company-minimum-prefix-length 1) ; 只需敲 1 个字母就开始进行自动补全
  (setq company-tooltip-align-annotations t)
  (setq company-idle-delay 0.0)
  (setq company-show-numbers t) ;; 给选项编号 (按快捷键 M-1、M-2 等等来进行选择).
  (setq company-selection-wrap-around t)
  (setq company-transformers '(company-sort-by-occurrence))) ; 根据选择的频率进行排序，读者如果不喜欢可以去掉

(use-package company-box
  :ensure t
  :if window-system
  :hook (company-mode . company-box-mode))

(provide 'init)
;;; init.el ends here
