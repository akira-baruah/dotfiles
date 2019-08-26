;; Akira Baruah's emacs config

;; Keep track of load time
(defconst emacs-start-time (current-time))

;; Avoid garbage collection during init
(let ((gc-cons-threshold most-positive-fixnum))
(defun avoid-garbage-collection()
  (setq gc-cons-threshold most-positive-fixnum))
(defun reset-garbage-collection()
  (setq gc-cons-threshold 800000))
(add-hook 'minibuffer-setup-hook #'avoid-garbage-collection)
(add-hook 'minibuffer-exit-hook #'reset-garbage-collection)

;; TODO(https://debbugs.gnu.org/34341): Remove this workaround once fix lands.
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; Package archives
(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")))
(package-initialize)
;; Avoid calling (package-initialize) again after init. For explanation, see
;; https://www.reddit.com/r/emacs/comments/1rdstn/set_packageenableatstartup_to_nil_for_slightly/
(setq package-enable-at-startup nil)

;; Install use-package if needed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Enable use-package
(eval-when-compile
  (require 'use-package))

;; Enable Org
(use-package org :ensure org-plus-contrib)

;; Load Org-based init file
(defvar user-config-file (expand-file-name "README.org" user-emacs-directory))
(org-babel-load-file user-config-file)

;; Message how long it took to load everything (minus packages)
(let ((elapsed (float-time (time-subtract (current-time)
                                          emacs-start-time))))
  (message "Loaded settings in %.3fs" elapsed))

)  ;; end gc-cons-threshold let
