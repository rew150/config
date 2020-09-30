(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
  ;; and `package-pinned-packages`. Most users will not need or want to do this.
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  )

(package-initialize)

;; Please do M-x package-refresh-contents to update repo
;; ===END OF BOILERPLATE===


(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.
   Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (unless (package-installed-p package)
       (package-install package)))
     packages))

(ensure-package-installed
  'helm
  'company
  'rainbow-delimiters
  'nyan-mode
  ;; theme
  'gruvbox-theme)

;; ===END OF PACKAGES INSTALLATION===

;; helm
(require 'helm-config)
(helm-mode 1)

;; company
(add-hook 'after-init-hook 'global-company-mode)
;; set Shift-Tab to fire Intellisense
(global-set-key (quote [backtab]) (quote company-complete))
;; set company autocomplete to behave correctly
(setq company-dabbrev-downcase 0)
;; set delay to fire to 0
(setq company-idle-delay 0)

;; rainbow-delimiters
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; nyan mode
(nyan-mode 1)
(setq nyan-wavy-trail t)
(add-hook 'after-init-hook 'nyan-start-animation)

;; gruvbox-theme
(load-theme 'gruvbox-dark-hard t)

;; add line number in text editor
(add-hook 'after-init-hook 'global-display-line-numbers-mode)

;; boilerplate
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (gruvbox-theme rainbow-delimiters company company-mode helm))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ===END OF INIT.EL===
(message "FINISH init.el")

