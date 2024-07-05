(setq gc-cons-threshold most-positive-fixnum ; 2^61 bytes
      gc-cons-percentage 0.6)

(setq package-enable-at-startup nil)

(setq load-prefer-newer t)

(defvar file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)

(setq-default
 default-frame-alist
 '((horizontal-scroll-bars . nil)       ;; No horizontal scroll-bars
   (left-fringe . 10)                    ;; Thin left fringe
   ;;(menu-bar-lines . 0)                 ;; No menu bar
   (right-divider-width . 1)            ;; Thin vertical window divider
   (right-fringe . 10)                   ;; Thin right fringe
   ;;(tool-bar-lines . 0)                 ;; No tool bar
   (vertical-scroll-bars . nil)))       ;; No vertical scroll-bars

(defvar better-gc-cons-threshold (* 100 1024 1024)) ; 100MB

(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setq gc-cons-threshold better-gc-cons-threshold
		  gc-cons-percentage 0.1)
	    (setq file-name-handler-alist file-name-handler-alist-original)
	    (makunbound 'file-name-handler-alist-original)
	    (message "Emacs ready in %s with %d garbage collections."
		     (format "%.2f seconds"
			     (float-time
			      (time-subtract after-init-time before-init-time)))
		     gcs-done)))
