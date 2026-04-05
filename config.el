;; syntax highlighting
(setq font-lock-maximum-decoration t)
(global-font-lock-mode t)

;; line numbers
(setq-default line-number-mode t)
(global-display-line-numbers-mode 1)

;; line numbers relative to current cursor position
(setq-default display-line-numbers-type 'relative)
(setq-default column-number-mode t)

;; c style
(setq-default
 c-default-style "k&r"
 c-basic-offset 4)

;; 4-space indents
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default tab-stop-list 4)
(setq-default electric-indent-inhibit t)
;;(setq-default indent-line-function 'insert-tab)

;; automatically complete brackets/quotes
(setq-default electric-pair-pairs '(
                                    (?\( . ?\))
                                    (?\[ . ?\])
                                    (?\{ . ?\})
                                    (?\" . ?\")
                                    (?\' . ?\')
                                    ))
(electric-pair-mode t)

;; prettify symbols
(global-prettify-symbols-mode t)

;; don't make a new window whenever you open a new directory in dired
(setq dired-kill-when-opening-new-dired-buffer t)

;; if you have multiple dired buffers, have the last dired buffer's directory be the default target
(setq dired-dwim-target t)

(setq-default inhibit-splash-screen t)
(setq-default initial-scratch-message nil)
(setq-default inhibit-startup-message t)
(setq-default ring-bell-function 'ignore)
(setq-default backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq-default auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(when window-system
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1))

;; from stackexchange user "Ole"
;; Makes *scratch* empty.
(setq initial-scratch-message "")

;; Removes *scratch* from buffer after the mode has been set.
;;(defun remove-scratch-buffer ()
;;  (if (get-buffer "*scratch*")
;;      (kill-buffer "*scratch*")))
;;(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

;; Removes *messages* from the buffer.
(setq-default message-log-max nil)
;;(kill-buffer "*Messages*")

;; Removes *Completions* from buffer after you've opened a file.
(add-hook 'minibuffer-exit-hook
          '(lambda ()
             (let ((buffer "*Completions*"))
               (and (get-buffer buffer)
                    (kill-buffer buffer)))))

;; Don't show *Buffer list* when opening multiple files at the same time.
(setq inhibit-startup-buffer-menu t)

;; allow y and n for yes or no questions
(defalias 'yes-or-no-p 'y-or-n-p)

;; highlight current line
(global-hl-line-mode t)

;; interactively do things in minibuffers
(ido-mode t)

;; open org files with everything collapsed
(setq-default org-startup-folded t)

;; automatically display embedded images
(add-hook 'org-mode-hook 'org-display-inline-images)

;; automatically start an emacs server with emacs, since we use emacsclient in the terminal
(server-start)

;; change this to whatever shell you use
(defvar my-term-shell "/bin/zsh")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

;; larger modeline
(add-hook 'find-file-hook (lambda () (set-face-attribute 'mode-line nil  :height 175)))

;; custom font
(custom-set-faces
 '(default ((t (:inherit nil :extend nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 145 :width normal :foundry "outline" :family "azukifontB")))))

;; modeline stuff
(size-indication-mode)
(display-time-mode)

;; from github user snackon's witchmacs repo
;; (go look at that config, it inspired this one)
(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

;;  (use-package aggressive-indent
;;    :ensure t
;;    :init
;;    (add-hook 'prog-mode-hook 'aggressive-indent-mode))

(use-package beacon
  :ensure t
  :diminish beacon-mode
  :init
  (beacon-mode 1))

(use-package company
  :ensure t
  :diminish company-mode
  :init
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.0)
  (add-hook 'after-init-hook 'global-company-mode))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 10)))
  ;;    (setq dashboard-banner-logo-title )
  (setq dashboard-center-content t)
  (setq dashboard-startup-banner "~/.emacs.d/images/patchouli.png"))

(use-package diminish
  ;; we'll diminish some modes that don't have their own section here,
  ;; most modes we diminish within their use-package scope
  ;; if you add to this config and wish to diminish your own minor modes,
  ;; C-h v local-minor-modes will show you all of the active ones
  :diminish auto-revert-mode
  :ensure t)

(use-package dimmer
  :ensure t
  :config
  (progn
    (setq dimmer-fraction 0.75)
    (setq dimmer-adjustment-mode :foreground)
    (dimmer-configure-which-key)
    (dimmer-configure-magit))
  :init
  (dimmer-mode t))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package elcord
  :ensure t
  :init
  (elcord-mode 1))

;; irc client stuffs
(use-package erc
  :custom
  ;;(erc-autojoin-channels-alist '(("freenode.net" "#archlinux" "#bash" "#bitcoin"
  ;;                                "#emacs" "#gentoo" "#i3" "#latex" "#org-mode" "#python")))
  (erc-autojoin-timing 'ident)
  (erc-fill-function 'erc-fill-static)
  (erc-fill-static-center 22)
  (erc-hide-list '("JOIN" "PART" "QUIT"))
  (erc-lurker-hide-list '("JOIN" "PART" "QUIT"))
  (erc-lurker-threshold-time 43200)
  (erc-prompt-for-nickserv-password nil)
  (erc-server-reconnect-attempts 5)
  (erc-server-reconnect-timeout 3)


  (erc-track-exclude-types '("JOIN" "MODE" "NICK" "PART" "QUIT"
                             "324" "329" "332" "333" "353" "477"))                                
  :config
  (add-to-list 'erc-modules 'notifications)
  (add-to-list 'erc-modules 'spelling)
  (erc-services-mode 1)
  (erc-log-mode)
  ;; this directory needs to be manually created
  ;; http://www.nihamkin.com/2013/12/04/how-to-enable-logging-of-chat-sessions-in-erc/
  (setq erc-log-channels-directory "~/.emacs.d/erc/logs/")
  (setq erc-generate-log-file-name-function (quote erc-generate-log-file-name-with-date))
  (setq erc-save-buffer-on-part nil)
  (setq erc-save-queries-on-quit nil)
  (setq erc-log-write-after-insert t)
  (setq erc-log-write-after-send t)
  ;; moar width
  (setq erc-fill-column 135)
  ;; Protect me from accidentally sending excess lines.
  (setq erc-inhibit-multiline-input t)
  (setq erc-send-whitespace-lines t)
  (setq erc-ask-about-multiline-input t)
  ;; Scroll all windows to prompt when submitting input.
  (setq erc-scrolltobottom-all t)
  (erc-update-modules))

(use-package ewal
  :ensure t
  :init (setq ewal-use-built-in-always-p nil
              ewal-use-built-in-on-failure-p t
              ewal-json-file "~/.emacs.d/colors.json"
              ewal-built-in-palette "sexy-material"))

(use-package ewal-spacemacs-themes
  :ensure t
  :init (progn
          (show-paren-mode +1)
          (global-hl-line-mode))
  :config (progn
            (load-theme 'ewal-spacemacs-modern t)
            (enable-theme 'ewal-spacemacs-modern)))

(use-package lua-mode
  :ensure t
  :init)

(use-package protobuf-mode
  :ensure t
  :init)

(use-package sourcepawn-mode
  :ensure t
  :init)

(use-package typescript-mode
  :ensure t
  :init)

(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :init
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package good-scroll
  :ensure t
  :init
  (good-scroll-mode 1))

(use-package goto-line-preview
  :ensure t
  :init)

(global-set-key [remap goto-line] 'goto-line-preview)

(use-package lsp-mode
  :ensure t
  :diminish lsp-mode
  :diminish lsp-modeline-code-actions-mode
  :init
  (setq lsp-keymap-prefix "C-c l"
        lsp-idle-delay 0.1)
  ;;:hook ((c++-mode . clangd)
  ;;       (python-mode . lsp)
  ;;       (c-mode . clangd)
  ;;       (csharp-mode . omnisharp))
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :init
  (lsp-ui-mode t))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-x C-g" . magit-status)))

;;  (use-package multiple-cursors
;;    :ensure t)

(use-package pc-bufsw
  :ensure t
  :config
  (pc-bufsw t))

(use-package rainbow-delimiters
  :ensure t
  :init
  (rainbow-delimiters-mode 1))

(use-package swiper
  :ensure t
  :bind ("C-s" . 'swiper))

(use-package treemacs
  :ensure t)

(use-package lsp-treemacs
  :ensure t)

;; put (setq wakatime-pass "waka_yourapikeyhere") in ~/.emacs.d/pass.el to use
(when (load-file "~/.emacs.d/pass.el") 
  (use-package wakatime-mode
    :ensure t
    :diminish wakatime-mode
    :config
    (setq-default wakatime-cli-path "~/.wakatime/wakatime-cli"
                  wakatime-api-key wakatime-pass)
    :init
    (global-wakatime-mode)))

(use-package which-key
  :ensure t
  :diminish whick-key-mode
  :init
  (which-key-mode))

(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :init
  (yas-global-mode 1))
