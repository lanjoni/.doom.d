;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(setq user-full-name "João Augusto Lissoni Lanjoni"
      user-mail-address "joaoaugustolanjoni@gmail.com")

;;
;;; UI

(setq doom-theme 'acme
      doom-font (font-spec :family "Monaco" :size 14)
      ;; I'm using the same font for variable-pitch but I need to change this
      doom-variable-pitch-font (font-spec :family "Monaco" :size 15))

;; Line numbers are slow. Maybe I will disable it in the future
(setq display-line-numbers-type 'relative)

;; Org-mode directory
(setq org-directory "~/org/")

;; Awesome-tab setup
(add-to-list 'load-path (expand-file-name "~/.emacs.d.backup/plugins/awesome-tab"))
(require 'awesome-tab)

;; Motion keybindings
(define-key global-map (kbd "C-k") 'previous-line)
(define-key global-map (kbd "C-h") 'backward-char)
(define-key global-map (kbd "C-j") 'next-line)
(define-key global-map (kbd "C-l") 'forward-char)

;; Treemacs keybindings
(define-key global-map (kbd "M-t") 'treemacs)
(define-key global-map (kbd "M-f") 'treemacs-project-follow-mode)

;; Zoom
(define-key global-map (kbd "C-=") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; CTRL + Z and CTRL + Shift + Z
(define-key global-map (kbd "C-z") 'undo-only)
(define-key global-map (kbd "C-S-z") 'undo-redo)

;; Shell
(define-key global-map (kbd "C-t") 'eshell)

;; Awesome tabs bindings
(global-set-key (kbd "M-1") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-2") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-3") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-4") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-5") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-6") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-7") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-8") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-9") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-0") 'awesome-tab-select-visible-tab)

;; Ctrl-c Ctrl-v
(cua-mode)

;; Evil mode (VI layer)
(evil-mode 1)

;; Removing C-k binding for correction
(eval-after-load "evil-maps"
  (dolist (map '(evil-motion-state-map
                 evil-insert-state-map
                 evil-emacs-state-map))
    (define-key (eval map) "\C-k" nil)))

;; Awesome tab mode (start)
(awesome-tab-mode t)

;; Code completion
(global-flycheck-mode)
(global-company-mode t)
(auto-complete-mode t)

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration
               '(crystal-mode . "crystal"))
  (lsp-register-client
  (make-lsp-client :new-connection (lsp-stdio-connection '("crystalline"))
                   :activation-fn (lsp-activate-on "crystal")
                   :priority '1
                   :server-id 'crystalline)))

;;; :tools lsp
;; Disable invasive lsp-mode features
(after! lsp-mode
  (setq lsp-enable-symbol-highlighting nil
        ;; If an LSP server isn't present when I start a prog-mode buffer, you
        ;; don't need to tell me. I know. On some machines I don't care to have
        ;; a whole development environment for some ecosystems.
        lsp-enable-suggest-server-download nil))
(after! lsp-ui
  (setq lsp-ui-sideline-enable nil  ; no more useful than flycheck
        lsp-ui-doc-enable nil))     ; redundant with K

;; (lsp-register-custom-settings
;;  '(("gopls.completeUnimported" t t)
;;    ("gopls.staticcheck" t t)))
