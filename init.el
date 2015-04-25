(require 'package)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))

;;; from purcell/emacs.d
(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(package-initialize)

(require-package 'evil)
(global-evil-leader-mode)
(evil-mode t)
(load-theme 'solarized t)

(require-package 'neotree)
(add-hook 'neotree-mode-hook
          (lambda ()
            (define-key evil-normal-state-local-map (kbd "o") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
            (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))
(require-package 'evil-leader)
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

;; Indent to the proper place after a return
(global-set-key (kbd "RET") 'newline-and-indent)

;; Makes soft-tabs (spaces sans tabs)
(setq-default indent-tabs-mode nil)

(show-paren-mode 1)

(setq tab-width 2) ; or any other preferred value
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;; Use relative line numbering
(require-package 'linum)
(require-package 'linum-relative)
(linum-mode 1)
(setq linum-format "%d ")

(require 'evil-search-highlight-persist)
(global-evil-search-highlight-persist t)

(require-package 'powerline)
(powerline-evil-vim-color-theme)
(display-time-mode t)
(global-auto-complete-mode t)
