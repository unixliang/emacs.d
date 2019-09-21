;; start coding
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'gb18030)
(prefer-coding-system 'utf-8)
;; end coding


;; start indent
(defun my-setup-indent (n)
  ;; java/c/c++
  (setq c-basic-offset n)
  ;; web development
  (setq coffee-tab-width n) ; coffeescript
  (setq javascript-indent-level n) ; javascript-mode
  (setq js-indent-level n) ; js-mode
  (setq js2-basic-offset n) ; js2-mode, in latest js2-mode, it's alias of js-indent-level
  (setq web-mode-markup-indent-offset n) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset n) ; web-mode, css in html file
  (setq web-mode-code-indent-offset n) ; web-mode, js code in html file
  (setq css-indent-offset n) ; css-mode
  )
(my-setup-indent 2)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)
;; end indent




(require-package 'ggtags)
(require-package 'helm)
(require-package 'helm-gtags)
(require-package 'protobuf-mode)




;; start helm-gtags
(global-set-key (kbd "C-]") 'helm-gtags-find-tag-from-here)
(global-set-key (kbd "C-t") 'helm-gtags-pop-stack)
(global-set-key (kbd "C-c r") 'helm-gtags-find-rtag)
(global-set-key (kbd "C-c f") 'helm-gtags-find-files)
(global-set-key (kbd "C-c e") 'helm-gtags-find-pattern)
(global-set-key (kbd "C-c s") 'helm-gtags-find-symbol)
(global-set-key (kbd "C-c t") 'helm-gtags-find-tag)
(global-set-key (kbd "C-c g") 'helm-do-grep-ag)


                                        ;(require 'helm-gtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              ;(linum-mode 1)
              ;(setq linum-format "%d ")
              (helm-gtags-mode 1)
              )))

;; end helm-gtags


;; start gnu global



;;;; 开启ggtags-mode
                                        ; (ggtags-mode) ; 不要全局打开ggtags-mode，否则其他类型文件的保存会触发 (add-hook 'after-save-hook #'gtags-update-hook)，导致gtags在后台吃cpu
(add-hook 'c-mode-hook 'ggtags-mode)
(add-hook 'c++-mode-hook 'ggtags-mode)


;; somthing wrong in gtags-update-single result in high cpu usage
;; ;;;;; 全量更新
;; (defun gtags-root-dir ()
;;   "Returns GTAGS root directory or nil if doesn't exist."
;;   (with-temp-buffer
;;     (if (zerop (call-process "global" nil t nil "-pr"))
;;         (buffer-substring (point-min) (1- (point-max)))
;;       nil)))

;; (defun gtags-update ()
;;   "Make GTAGS incremental update"
;;   (call-process "global" nil nil nil "-u"))

;; (defun gtags-update-hook-all ()
;;   (when (gtags-root-dir)
;;     (gtags-update)))
;; ;;;;;;; 全量更新结束

;; ;;;;;;; 单文件更新
;; (defun gtags-update-single(filename)
;;   "Update Gtags database for changes in a single file"
;;   (interactive)
;;   (start-process
;;    "update-gtags"
;;    "update-gtags"
;;    "bash" "-c"
;;    (concat "cd " (gtags-root-dir)
;;            " ; gtags --single-update "
;;            filename )))

;; (defun gtags-update-current-file()
;;   (interactive)
;;   (defvar filename)
;;   (setq filename (replace-regexp-in-string (gtags-root-dir) "." (buffer-file-name (current-buffer))))
;;   (gtags-update-single filename)
;;   (message "Gtags updated for %s" filename))

;; (defun gtags-update-hook()
;;   "Update GTAGS file incrementally upon saving a file"
;;   (when ggtags-mode
;;     (when (gtags-root-dir)
;;       (gtags-update-current-file))))
;; ;;;;;; 单文件更新结束

;; (add-hook 'after-save-hook #'gtags-update-hook)
;; ;;;;;;; 更新tags


(add-hook 'c-mode-common-hook
          (lambda ()
            (derived-mode-p 'c-mode 'c++-mode 'java-mode)
            (ggtags-mode 1)))

;; end gnu global













;; start Indenting C/C++
(setq c-default-style "linux"
      c-basic-offset 4)
;; end Indenting C/C++

;; start forbidon old find file
(global-set-key (kbd "C-x f") 'ido-find-file)
(setq ido-use-filename-at-point nil) ;ignore file-at-point when invoking `ido-find-file` (`C-x C-f` in Ido mode)
;; end forbidon old find file

;; start .cpp/.h change
(global-set-key (kbd "C-h") 'ff-find-other-file)
;; end .cpp/.h change


;; start undo key binding
(global-set-key (kbd "C-z") 'undo)
;; end undo key binding

;; start find file
(global-set-key (kbd "C-x l") 'helm-locate)
                                        ;(global-set-key (kbd "C-x g") 'helm-regexp)
;; end find file

;; start for update buffer while git branch change
(global-auto-revert-mode 1)
;; end for update buffer while git branch change

;; start replace system default M-x, support fuzzy match
(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t)
;; end replace system default M-x, support fuzzy match

;; start show kill ring
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;; end show kill ring

;; replace system default C-x b, support fuzzy match
(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t
      helm-buffer-max-length nil)
;; replace system default C-x b, support fuzzy match





;; start markdown
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'". markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'". markdown-mode))


(setq scroll-preserve-screen-position t
      scroll-conservatively 0)

(add-hook 'markdown-mode-hook (lambda () (auto-fill-mode 0)))
(add-hook 'markdown-mode-hook 'symbol-overlay-mode)
;; end markdown


;; start 2 spaces indent
(custom-set-variables
 '(c-basic-offset 2))
;; end 2 spaces indent

;; start better word search
(global-set-key (kbd "C-s") 'helm-occur)
;; end better word search

;; start symbol
(global-set-key (kbd "M-I") 'symbol-overlay-remove-all)
;; end symbol

;; start open .h with c++ mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
;; end open .h with c++ mode

;; start overwrite indent in namespace
(defun my-c-setup ()
  (c-set-offset 'innamespace [0]))
(add-hook 'c++-mode-hook 'my-c-setup)
;; end overwrite indent in namespace

(provide 'init-local)


;; start set-exec-path-from-shell-PATH
(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)
;; end set-exec-path-from-shell-PATH


;; start protobuf-mode
(setq auto-mode-alist  (cons '(".proto$" . protobuf-mode) auto-mode-alist))
(add-hook 'protobuf-mode-hook 'symbol-overlay-mode)
;; end protobuf-mode



                                        (set-default-font "Monaco 13")


(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)


(global-set-key (kbd "C-r") 'revert-buffer)



(load-theme 'sanityinc-tomorrow-bright t)

;; start switch to last buffer
(global-set-key (kbd "C-l") 'mode-line-other-buffer)
;; end switch to last buffer


;; start tabnine
(require 'company-tabnine)
(add-to-list 'company-backends #'company-tabnine)
;; Trigger completion immediately.
(setq company-idle-delay 0)

;; Number the candidates (use M-1, M-2 etc to select completions).
(setq company-show-numbers t)

;; Use the tab-and-go frontend.
;; Allows TAB to select and complete at the same time.
(company-tng-configure-default)
(setq company-frontends
      '(company-tng-frontend
        company-pseudo-tooltip-frontend
        company-echo-metadata-frontend))

(add-hook 'c-mode-hook 'company-mode)
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'protobuf-mode-hook 'company-mode)


;; end tabnine

;; start close debug
(setq toggle-debug-on-error 0)
;; end close debug
