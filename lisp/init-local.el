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
(my-setup-indent 4)
;; end indent











;; start helm-gtags
(require-package 'helm-gtags)

(global-set-key (kbd "C-]") 'helm-gtags-find-tag-from-here)
(global-set-key (kbd "C-t") 'helm-gtags-pop-stack)
(global-set-key (kbd "C-c r") 'helm-gtags-find-rtag)
(global-set-key (kbd "C-c f") 'helm-gtags-find-files)
(global-set-key (kbd "C-c e") 'helm-gtags-find-pattern)
(global-set-key (kbd "C-c s") 'helm-gtags-find-symbol)
(global-set-key (kbd "C-c t") 'helm-gtags-find-tag)

(defun helm-do-grep-recursive (&optional non-recursive)
  "Like `helm-do-grep', but greps recursively by default."
  (interactive "P")
  (let* ((current-prefix-arg (not non-recursive))
         (helm-current-prefix-arg non-recursive))
    (call-interactively 'helm-do-grep)))
(global-set-key (kbd "C-c g") 'helm-do-grep-recursive)

                                        ;(require 'helm-gtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (linum-mode 1)
              (setq linum-format "%d ")
              (helm-gtags-mode 1)
              )))

;; end helm-gtags


;; start gnu global
(require-package 'ggtags)


;;;; 开启ggtags-mode
(ggtags-mode)

;;;;; 全量更新
(defun gtags-root-dir ()
  "Returns GTAGS root directory or nil if doesn't exist."
  (with-temp-buffer
    (if (zerop (call-process "global" nil t nil "-pr"))
        (buffer-substring (point-min) (1- (point-max)))
      nil)))

(defun gtags-update ()
  "Make GTAGS incremental update"
  (call-process "global" nil nil nil "-u"))

(defun gtags-update-hook-all ()
  (when (gtags-root-dir)
    (gtags-update)))
;;;;;;; 全量更新结束

;;;;;;; 单文件更新
(defun gtags-update-single(filename)
  "Update Gtags database for changes in a single file"
  (interactive)
  (start-process
   "update-gtags"
   "update-gtags"
   "bash" "-c"
   (concat "cd " (gtags-root-dir)
           " ; gtags --single-update "
           filename )))

(defun gtags-update-current-file()
  (interactive)
  (defvar filename)
  (setq filename (replace-regexp-in-string (gtags-root-dir) "." (buffer-file-name (current-buffer))))
  (gtags-update-single filename)
  (message "Gtags updated for %s" filename))

(defun gtags-update-hook()
  "Update GTAGS file incrementally upon saving a file"
  (when ggtags-mode
    (when (gtags-root-dir)
      (gtags-update-current-file))))
;;;;;; 单文件更新结束

(add-hook 'after-save-hook #'gtags-update-hook)
;;;;;;; 更新tags

(add-hook 'c-mode-common-hook
          (lambda ()
            (derived-mode-p 'c-mode 'c++-mode 'java-mode)
            (ggtags-mode 1)))

;; start gnu global













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
(global-set-key (kbd "C-x g") 'helm-regexp)
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
;; end markdown




;; start C-SPC select text
(require-package 'helm)
(global-set-key (kbd "C-]") 'helm-toggle-visible-mark)
;; end C-SPC select text

;; start better word search
(global-set-key (kbd "C-s") 'helm-occur)
;; end better word search



(provide 'init-local)
