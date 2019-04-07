(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (tango-dark)))
 '(package-selected-packages (quote (helm nyan-mode)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Determine the host OS.
(setq ia-win32 (eq system-type 'windows-nt))
(setq ia-linux (eq system-type 'gnu/linux))
(setq ia-macos (eq system-type 'darwin))

;; Deprecate splash screen.
(setq inhibit-startup-screen t)
;; Maximize window.
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Stop Emacs from loosing undo information by setting very high limits for undo buffers.
(setq undo-limit 20000000)
(setq undo-strong-limit 40000000)

(setq backup-directory-alist '(("." . "~/.emacs_saves")))

;; Font, codepage and colortable configuration.
(add-to-list 'default-frame-alist '(font . "Liberation Mono-10"))
(set-face-attribute 'default t :font "Liberation Mono-10")
(when ia-win32
  (set-language-environment 'Cyrillic-KOI8)
  (setq default-buffer-file-coding-system 'koi8-r)
  (prefer-coding-system 'koi8-r)
  (setq-default coding-system-for-read 'windows-1251)
  (define-coding-system-alias 'windows-1251 'cp1251))

(setq make-backup-files nil) ; Stop creating backup~ files
(setq auto-save-default nil) ; Stop creating #autosave# files

;; Treat .h files as C++ files, not pure C.
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode)) ; open .h files in C++ mode

;; HELM configruation.
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x r b") 'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x b") 'helm-mini)

;; NYAN configuration.
(require 'nyan-mode)
(nyan-mode 1)

(setq-default indent-tabs-mode t) ; Tabs instead of spaces (works only in C mode right now)
(setq-default tab-width 4) ; For VS compatibility
(defvaralias 'c-basic-offset 'tab-width)
