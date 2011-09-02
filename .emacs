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
 '(js2-allow-keywords-as-property-names nil)
 '(js2-auto-indent-p nil)
 '(js2-bounce-indent-p nil)
 '(js2-cleanup-whitespace t)
 '(js2-enter-indents-newline t)
 '(js2-highlight-level 2)
 '(js2-include-gears-externs nil)
 '(js2-include-rhino-externs nil)
 '(js2-indent-on-enter-key nil)
 '(js2-mode-escape-quotes nil)
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t)
 '(x-select-enable-clipboard t))
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

;; using whitespace instead of tabs
(setq-default indent-tabs-mode nil)
;; I hate tabs!
;;(require 'whitespace)

;;autoreload files when they changed on disk


;;Sessions
(desktop-save-mode t)
(setq-default desktop-path '("~/emacs/desktop/"))
(setq history-length 250)
(add-to-list 'desktop-globals-to-save 'file-name-history)
(setq-default desktop-save t)
(setq-default save-place t)
(setq-default desktop-missing-file-warning nil)

;; TABS
(setq EmacsPortable-global-tabbar 't)
;; (setq EmacsPortable-global-ruler 't)
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
(define-key global-map (kbd "C-1") 'comment-region)
(define-key global-map (kbd "C-2") 'uncomment-region)

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
;;x(global-set-key [(ctrl x)] 'clipboard-kill-region)
;;(global-set-key "\C-c" 'clipboard-kill-ring-save)
;;(global-set-key "\C-v" 'clipboard-yank)



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


;; open file with GTK dialog
(defun my-find-file ()
  (interactive)
  (let (last-nonmenu-event)
    (call-interactively 'find-file)))
 (global-set-key (kbd "C-o") 'my-find-file)

;; tramp (ftp/ssh)
(add-to-list 'load-path "~/emacs/tramp/lisp/")
;; for Emacs
(add-to-list 'Info-default-directory-list "~/emacs/tramp/info/")


(require 'tramp)
;;(setq tramp-default-method "scp")
;;  (setq tramp-default-method "ssh")

(setq tramp-default-user "jodaka"
      tramp-default-host "ololo")

;; TODO
(require 'fic-mode)
(defun add-something-to-mode-hooks (mode-list something)
  "helper function to add a callback to multiple hooks"
  (dolist (mode mode-list)
    (add-hook (intern (concat (symbol-name mode) "-mode-hook")) something)))

(add-something-to-mode-hooks '(c++ javascript js2 emacs-lisp) 'turn-on-fic-mode)

;; delete trailing whitespaces on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Now you are approaching the pure awesomeness
;; DELETEs all whitespaces from current word till next non-whitespace char (including \n)
(load "cc-mode")
(global-set-key [C-delete] 'c-hungry-delete-forward)
(global-set-key [C-backspace] 'c-hungry-delete-backwards)

;; JShint with Node server. yeah
(add-to-list 'load-path "emacs/jshint")
(require 'flymake-jshint)
(add-hook 'javascript-mode-hook
    (lambda () (flymake-mode t)))

;; Turns on flymake for all files which have a flymake mode
;;(add-hook 'find-file-hook 'flymake-find-file-hook)
