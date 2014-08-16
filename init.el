;;; emacs Lisp関係

;; auto-installによってインストールされるEmacs Lispをロードパスに加える
(add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install"))
;; (install-elisp-from-emcswiki "auto-install.el")
(require 'auto-install)
;; 起動時にEmacsWikiのページ名を補間候補に加える
(auto-install-update-emacswiki-package-name t)
;; install-elisp.el互換モードにする
(auto-install-compatibility-setup)
;; ediff関連のバッファを１つのフレームにまとめる
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; (install-elisp-from-emcswiki "tempbuf.el")
(require 'tempbuf)
;; ファイルを開いたら自動的にtempbufを有効にする
(add-hook 'find-file-hooks 'turn-on-tempbuf-mode)
;; diredバッファに対してtempbufを有効にする
(add-hook 'dired-mode-hook 'turn-on-tempbuf-mode)

;; Original http://0xcc.net/misc/auto-save-buffers.el
(require 'auto-save-buffers)
;; アイドル２秒で保存
(run-with-idle-timer 2 t 'auto-save-buffers)

;; 略語展開・補完を行うコマンドをまとめる
(setq hippie-expand-try-functions-list
      '(try-complete-file-name-partially   ; ファイル名の一部
        try-complete-file-name             ; ファイル名全体
        try-expand-all-abbrevs              ; 静的略語展開
        try-expand-dabbrev                 ; 動的略語展開(カレントバッファ)
        try-expand-dabbrev-all-buffers     ; 動的略語展開(全バッファ)
        try-expand-dabbrev-from-kill       ; 動的略語展開(キルリング:M-w/C-wの履歴)
        try-complete-lisp-symbol-partially ; Lispシンボル名の一部
        try-complete-lisp-symbol           ; Lispシンボル名全部
        ))

;;; 独自設定

;; python-mode
(add-hook 'python-mode-hook
          '(lambda()
             (setq indent-tabs-mode t)
             (setq indent-level 4)
             (setq python-indent 4)
             (setq tab-width 4)
             (define-key python-mode-map "\"" 'electric-pair)
             (define-key python-mode-map "\'" 'electric-pair)
             (define-key python-mode-map "(" 'electric-pair)
             (define-key python-mode-map "[" 'electric-pair)
             (define-key python-mode-map "{" 'electric-pair)))
(defun electric-pair()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))

;; 文字の書式とサイズ設定
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  ;; height 110 width 110
 '(default ((t :family "Consolas"))))
;(setq my-font "Consolas")
;; Ctrl-hをBackspaceに変更
(global-set-key "\C-h" 'delete-backward-char)
;; 点滅を止める
(blink-cursor-mode 0)
;; 現在の関数名をモードラインに表示
(which-function-mode 1)
;; モードラインに時刻表示
(display-time-mode 1)
;; 対応する括弧を光らせる
(show-paren-mode 1)
;; バックアップファイルを作らない
(setq backup-inhibited t)
;; 終了時オートファイルセーブファイルを消す
(setq delete-auto-save-files t)
(put 'set-goal-column 'disabled nil)
;; タブ幅を2にする
(setq-default tab-width 2)
;; タブではなくスペースを使う
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)
;; 現在行に色をつける
;;(global-hl-line-mode 1)
;; 行・列番号の表示
(line-number-mode 1)
(column-number-mode 1)
;; リージョンに色
(setq transient-mark-mode t)
;; 行番号表示
(global-linum-mode t)
;; ツールバー、スクロールバー、メニューバーを消す
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
;; 透過設定
(add-to-list 'default-frame-alist '(alpha . (0.75 0.75)))
;; 起動時のフレームサイズ
(setq initial-frame-alist
      (append (list
        '(width  . 80)
        '(height . 30)
        )
        initial-frame-alist))
(setq default-frame-alist initial-frame-alist)
;; 下のウザイのを消す
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))

;; color-theme
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(require 'color-theme)
(eval-after-load "color-theme"
 '(progn
	 (color-theme-initialize)
	 (color-theme-euphoria)))

;; 補完機能の設定
(add-to-list 'load-path "~/.emacs.d/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)
;; すべてのモードで補完を有効にする
(global-auto-complete-mode t)
;; 補完関連設定
(setq ac-auto-start 2)        ; 2文字以上で起動する
(setq ac-auto-show-menu 0.5)  ; 0.5秒でメニュー表示
(setq ac-use-comphist t)      ; 補完候補をソート
(setq ac-candidate-limit nil) ; 補完候補表示を無制限に
(setq ac-use-menu-map t)      ; キーバインド
(define-key ac-completing-map (kbd "RET") nil) ; returnでの補完禁止

;; ac-python.elの設定
(require 'ac-python)

;; anythig.el
(require 'cl)
(defvar anything-version "1.3.9")

;; anything-math-plugin.el
(require 'anything)
(require 'cl)

;; auto-insert
(require 'autoinsert)
;; Template directory
(setq auto-insert-directory "~/.emacs.d/template/")
;; File
(setq auto-insert-alist
 (append '(
           ("\\.c$"  . ["template.c"])
           ("\\.sh"  . ["template.sh"])
           ("\\.py"  . ["template.py"])
	   ("\\.nasm". ["template.nasm"])
          ) auto-insert-alist))
(add-hook 'find-file-hooks 'auto-insert)

;; Souce mode settings
; NASM
(autoload 'nasm-mode "~/.emacs.d/mode/nasm-mode.el" "" t)
(add-to-list 'auto-mode-alist '("\\.\\(asm\\|s\\|nasm\\)$" . nasm-mode))
; PHP
(autoload 'php-mode "~/.emacs.d/mode/php-mode.el" "" t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-hook 'php-mode-hook
         (lambda ()
             (require 'php-completion)
             (php-completion-mode t)
             (define-key php-mode-map (kbd "C-o") 'phpcmp-complete)
             (when (require 'auto-complete nil t)
             (make-variable-buffer-local 'ac-sources)
             (add-to-list 'ac-sources 'ac-source-php-completion)
             (auto-complete-mode t))))
