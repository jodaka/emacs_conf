;; paths:
(add-to-list 'load-path "~/emacs")

(setq initial-frame-alist (append
                           '((width . 160) (height . 36) (top . 0)
                             (left . 0))
                           initial-frame-alist))


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(fringe-mode 0 nil (fringe))
 '(js2-auto-indent-p t)
 '(js2-cleanup-whitespace t)
 '(js2-highlight-level 2)
 '(js2-include-gears-externs nil)
 '(js2-include-rhino-externs nil)
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#0C1021" :foreground "#F8F8F8" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "microsoft" :family "Consolas"))))
 '(linum ((t (:inherit (shadow default) :background "#4B4B4B" :foreground "#FBF286")))))


;; ============

;;;;Change backup behavior to save in a directory, not in a miscellany
;;;;of files all over the place.
(setq
    backup-by-copying t      ; don't clobber symlinks
    backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
    delete-old-versions t
    kept-new-versions 6
    kept-old-versions 2
    version-control t)       ; use versioned backups

;; COLOR THEME (so it looks a little bit less ugly then default)
(require 'color-theme)
(color-theme-initialize)
(load-file "~/emacs/themes/color-theme-blackboard.el")
(load-file "~/emacs/themes/zenburn.el")
;;(color-theme-blackboard)
(color-theme-zenburn)

;; autoloading JS2 mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; LINE NUMBERS (yes, they ARE ugly)
(require 'linum)
(setq linum-format "%d ")
(global-linum-mode 1)

;; Whitespace
;;(require 'whitespace)

;; I hate tabs!
(setq-default indent-tabs-mode nil) 


;; TABS
(setq EmacsPortable-global-tabbar 't)
(setq EmacsPortable-global-ruler 't) 
;; (setq EmacsPortable-popup-menu 't) ; If you want a popup menu.
;; (setq EmacsPortable-popup-toolbar 't) ; If you want a popup toolbar

(require 'tabbar-ruler)


;; KEYS
;; ctrl+g works but need to rebing it before
(global-set-key "\C-j" 'goto-line)
;;(global-set-key "\C-s" 'save-buffer)


;; close tab
(defun kill-current-buffer ()
  (interactive)
  (kill-buffer nil))
(global-set-key "\C-w" 'kill-current-buffer)

;; Below doesn't work
;;(global-set-key "\C-c\C-c" 'comment-region)
;;(global-set-key "\C-c\C-v" 'uncomment-region)

;;(global-set-key "\C-f" 'search-forward)
;;(global-set-key "\C-h" 'replace-string)

;; I don't really need this since tabify/untabify exists
;;(global-set-key "\C-cis" 'switch-indent-spaces)
;;(global-set-key "\C-cit" 'switch-indent-tabs)

;; Font size +/-
(define-key global-map (kbd "C-=") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)


;; Window switching. (C-x o goes to the next window)
(global-set-key (kbd "<C-tab>") 'bury-buffer)
;;(global-set-key (kbd "<C-S-tab>") 'raise-buffer) ;; forward) ;; back


;; this works but not very useful
;;(global-set-key [(ctrl right)] 'next-buffer)
;;(global-set-key [(ctrl left)] 'previous-buffer)


;; scrolling 1 line up/down. Awesome
(defun scroll-down-one-line ()
  "Scroll down one line."
  (interactive)
  (scroll-down 1))

(defun scroll-up-one-line ()
  "Scroll up one line."
  (interactive)
  (scroll-up 1))

(global-set-key [(ctrl up)] 'scroll-down-one-line)
(global-set-key [(ctrl down)] 'scroll-up-one-line)

;; use global copy/paste buffer
;;(global-set-key "\C-x" 'clipboard-kill-region)
;;(global-set-key "\C-c" 'clipboard-kill-ring-save)
;;(global-set-key "\C-v" 'clipboard-yank)

(custom-set-variables '(x-select-enable-clipboard t))

;; don't display scratch buffer
(setq initial-scratch-message nil)

;; f10 toggle menu and bar and disable them on startup
(menu-bar-mode -1)
(tool-bar-mode -1)
(defun toggle-menu-toolbar-modes ()
  (interactive)
  (tool-bar-mode (menu-bar-mode)))
(global-set-key (kbd "<f10>")          'toggle-menu-toolbar-modes)


;; open file dialog
(global-set-key [(control o)]          'menu-find-file-existing)


;; bookmarks 
(require 'breadcrumb)
(global-set-key [(control f2)]          'bc-set)
(global-set-key [(f2)]                  'bc-next)
(global-set-key [(shift f2)]            'bc-previous)
(global-set-key [(meta f2)]             'bc-list)

;;;;"I always compile my .emacs, saves me about two seconds
;;;;startuptime. But that only helps if the .emacs.elc is newer
;;;;than the .emacs. So compile .emacs if it's not."
(defun autocompile nil
  "compile itself if ~/.emacs"
  (interactive)
  (require 'bytecomp)
  (if (string= (buffer-file-name) (expand-file-name (concat
default-directory ".emacs")))
      (byte-compile-file (buffer-file-name))))
(add-hook 'after-save-hook 'autocompile)