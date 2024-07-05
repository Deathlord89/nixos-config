(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(require 'straight-x)

(if (and (executable-find "watchexec")
         (executable-find "python3"))
    (setq straight-check-for-modifications '(watch-files find-when-checking))
  (setq straight-check-for-modifications
        '(find-at-startup find-when-checking)))

(straight-use-package 'use-package)

(setq straight-use-package-by-default t)

(defmacro use-feature (name &rest args)
  (declare (indent defun))
  `(use-package ,name
     :straight nil
     ,@args))

;; Silence compiler warnings as they can be pretty disruptive
(setq native-comp-async-report-warnings-errors nil)

;; Set the right directory to store the native comp cache
(add-to-list 'native-comp-eln-load-path (expand-file-name "eln-cache/" user-emacs-directory))

(setq-default
 ad-redefinition-action 'accept         ; Silence warnings for redefinition
 auto-save-list-file-prefix nil         ; Prevent tracking for auto-saves
 cursor-in-non-selected-windows nil     ; Hide the cursor in inactive windows
 cursor-type '(hbar . 2)                ; Underline-shaped cursor
 custom-unlispify-menu-entries nil      ; Prefer kebab-case for titles
 custom-unlispify-tag-names nil         ; Prefer kebab-case for symbols
 delete-by-moving-to-trash t            ; Delete files to trash
 ;; fill-column 80                         ; Set width for automatic line breaks
 help-window-select t                   ; Focus new help windows when opened
 indent-tabs-mode nil                   ; Stop using tabs to indent
 inhibit-startup-screen t               ; Disable start-up screen
 ;; initial-scratch-message ""             ; Empty the initial *scratch* buffer
 mouse-yank-at-point t                  ; Yank at point rather than pointer
 recenter-positions '(5 top bottom)     ; Set re-centering positions
 scroll-conservatively 101              ; Avoid recentering when scrolling far
 scroll-margin 2                        ; Add a margin when scrolling vertically
 select-enable-clipboard t              ; Merge system's and Emacs' clipboard
 sentence-end-double-space nil          ; Use a single space after dots
 ;; show-help-function nil                 ; Disable help text everywhere
 tab-always-indent 'complete            ; Tab indents first then tries completions
 tab-width 4                            ; Smaller width for tab characters
 uniquify-buffer-name-style 'forward    ; Uniquify buffer names
 warning-minimum-level :error           ; Skip warning buffers
 window-combination-resize t            ; Resize windows proportionally
 x-stretch-cursor t)                    ; Stretch cursor to the glyph width
(delete-selection-mode 1)               ; Replace region when inserting text
(fset 'yes-or-no-p 'y-or-n-p)           ; Replace yes/no prompts with y/n
(global-subword-mode 1)                 ; Iterate through CamelCase words
(mouse-avoidance-mode 'exile)           ; Avoid collision of mouse with point
(put 'downcase-region 'disabled nil)    ; Enable downcase-region
(put 'upcase-region 'disabled nil)      ; Enable upcase-region
(set-default-coding-systems 'utf-8)     ; Default to utf-8 encoding

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
;;(tooltip-mode -1)         ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
;;(menu-bar-mode -1)        ; Disable the menu bar
(save-place-mode 1)         ; Save the last cursor position

;; Set up the visible bell
(setq visible-bell t)

;; Show line numbers
(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode'(org-mode-hook
               term-mode-hook
               shell-mode-hook
               eshell-mode-hook
               mu4e-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers 1)

;; Change the user-emacs-directory to keep unwanted things out of ~/.emacs.d
(setq user-emacs-directory (expand-file-name "~/.cache/emacs/")
      url-history-file (expand-file-name "url/history" user-emacs-directory))

;; Use no-littering to automatically set common paths to the new user-emacs-directory
(use-package no-littering)

;; Keep customization settings in a temporary file (thanks Ambrevar!)
(setq custom-file
      (if (boundp 'server-socket-dir)
          (expand-file-name "custom.el" server-socket-dir)
        (expand-file-name (format "emacs-custom-%s.el" (user-uid)) temporary-file-directory)))
(load custom-file t)

(setq-default custom-file null-device)

(use-package nerd-icons)
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))
  ;; :custom ((setq doom-modeline-height 15)))
  )
