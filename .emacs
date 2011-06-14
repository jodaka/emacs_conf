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

;; COLOR THEME (so it looks a little bit less ugly then default)
(require 'color-theme)
(color-theme-initialize)
(load-file "~/.emacs.d/themes/color-theme-blackboard.el")
(color-theme-blackboard)

;; autoloading JS2 mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; LINE NUMBERS (yes, they ARE ugly)
(require 'linum)
(setq linum-format "%d ")
(global-linum-mode 1)

;; Whitespace
(require 'whitespace)



;; TABS
(setq EmacsPortable-global-tabbar 't)
(setq EmacsPortable-global-ruler 't) 
;; (setq EmacsPortable-popup-menu 't) ; If you want a popup menu.
;; (setq EmacsPortable-popup-toolbar 't) ; If you want a popup toolbar

(require 'tabbar-ruler)

;; KEYS
;; ctrl+g works but need to rebing it before
(global-set-key "\C-j" 'goto-line)
(global-set-key "\C-s" 'save-buffer)

;; Below doesn't work
;;(global-set-key "\C-c\C-c" 'comment-region)
;;(global-set-key "\C-c\C-v" 'uncomment-region)

(global-set-key "\C-f" 'search-forward)
(global-set-key "\C-h" 'replace-string)

(global-set-key "\C-cis" 'switch-indent-spaces)
(global-set-key "\C-cit" 'switch-indent-tabs)