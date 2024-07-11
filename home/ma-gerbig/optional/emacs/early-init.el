;;; early-init.el -*- lexical-binding: t -*-
;; DO NOT EDIT THIS FILE DIRECTLY
;; This is a file generated from a literate programing source file located at
;; https://github.com/Deathlord89/nixos-config/blob/main/home/ma-gerbig/optional/emacs/README.org
;; You should make any changes there and regenerate it from Emacs org-mode
;; using org-babel-tangle (C-c C-v t)

(setq gc-cons-threshold most-positive-fixnum ; 2^61 bytes
      gc-cons-percentage 0.6)

(defvar total-memory (string-to-number (shell-command-to-string "awk '/MemTotal/ {print$2}' /proc/meminfo")))

(setq package-enable-at-startup nil)

(setq load-prefer-newer t)

(defvar file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)

(setq-default
 default-frame-alist
 '((horizontal-scroll-bars . nil)       ; No horizontal scroll-bars
   (left-fringe . 10)                   ; Thin left fringe
   (menu-bar-lines . 0)                 ; No menu bar
   (right-divider-width . 1)            ; Thin vertical window divider
   (right-fringe . 10)                  ; Thin right fringe
   (tool-bar-lines . 0)                 ; No tool bar
   (vertical-scroll-bars . nil)))       ; No vertical scroll-bars

(setq user-emacs-directory (expand-file-name "~/.cache/emacs/")
      url-history-file (expand-file-name "url/history" user-emacs-directory))

(when (fboundp 'startup-redirect-eln-cache)
  (startup-redirect-eln-cache
   (convert-standard-filename
    (expand-file-name  "var/eln-cache/" user-emacs-directory))))
