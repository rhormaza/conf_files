(setq tramp-default-method "ssh")

(add-to-list 'load-path "/Applications/Emacs.app/Contents/Resources/site-lisp")
(setenv "PATH" (concat "/usr/texbin:/usr/local/bin:" (getenv "PATH")))
(setq exec-path (append '("/usr/texbin" "/usr/local/bin") exec-path))
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

;; PHP MODE ;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

(require 'flymake)

(defun flymake-php-init ()
  "Use php to check the syntax of the current file."
    (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
         (local (file-relative-name temp (file-name-directory buffer-file-name))))
        (list "php" (list "-f" local "-l"))))

(add-to-list 'flymake-err-line-patterns
  '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))

(add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))

;; Drupal-type extensions
(add-to-list 'flymake-allowed-file-name-masks '("\\.module$" flymake-php-init))
(add-to-list 'flymake-allowed-file-name-masks '("\\.install$" flymake-php-init))
(add-to-list 'flymake-allowed-file-name-masks '("\\.inc$" flymake-php-init))
(add-to-list 'flymake-allowed-file-name-masks '("\\.engine$" flymake-php-init))

(add-hook 'php-mode-hook (lambda () (flymake-mode 1)))
(;;define-key php-mode-map '[M-S-up] 'flymake-goto-prev-error)
;;(define-key php-mode-map '[M-S-down] 'flymake-goto-next-error)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(add-hook 'emacs-lisp-mode-hook '(lambda () (highlight-lines-matching-regexp ".\{81\}" "hi-green-b")))
;; whitespace-mode
;; free of trailing whitespace and to use 80-column width, standard indentation
(setq whitespace-style '(trailing lines space-before-tab
                                  indentation space-after-tab)
      whitespace-line-column 80)
(setq-default fill-column 66)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

(setq TeX-PDF-mode t)
(setq tex-dvi-view-command "xdvi")
(setq tex-view-command "Applications/Preview.app/Contents/MacOS/Preview")
(setq tex-pdf-view-command "Applications/Preview.app/Contents/MacOS/Preview")
(setq TeX-view-style '(("." "Applications/Preview.app/Contents/MacOS/Preview %d")))
 '(TeX-command-Show "open -a /Applications/Preview %r")
 (setq TeX-output-view-style '("^pdf$" "." "/Applications/Preview.app/Contents/MacOS/Preview  %o "))
(add-hook 'LaTeX-mode-hook
   (lambda()
        (setq TeX-auto-save t)
        (setq LaTeX-command-style
        (quote (("\\`fontspec\\'" "xelatex ")
        ("" "%(PDF)%(latex) %S%(PDFout)"))))
                  (custom-set-variables
                        '(preview-fast-dvips-command "pdftops -origpagesizes %s.pdf %m/preview.ps"))
                       (setq TeX-save-query nil)
                            (setq TeX-parse-self t)
                                 (setq-default TeX-master nil)
                                      (setq TeX-output-view-style
                                          (cons '("^pdf$" "." "/Applications/Preview.app/Contents/MacOS/Preview  %o ") TeX-output-view-style))
                                           (set-default 'preview-default-document-pt 12)
                                                (set-default 'preview-scale-function 1.2)
                                                     (setq preview-required-option-list
                                                         (quote ("active" "tightpage" "auctex" "pdftex" (preview-preserve-counters "counters"))))
                                                          (setq preview-default-option-list
                                                              (quote ("displaymath" "floats" "graphics" "textmath" "showlabels" "sections" )))
                                                               (TeX-global-PDF-mode t)))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(TeX-command-list (quote (("TeX" "%(PDF)%(tex) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (plain-tex-mode texinfo-mode ams-tex-mode) :help "Run plain TeX") ("LaTeX" "%`%l%(mode)%' %t" TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX") ("Makeinfo" "makeinfo %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with Info output") ("Makeinfo HTML" "makeinfo --html %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with HTML output") ("AmSTeX" "%(PDF)amstex %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (ams-tex-mode) :help "Run AMSTeX") ("ConTeXt" "texexec --once --texutil %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt once") ("ConTeXt Full" "texexec %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt until completion") ("BibTeX" "bibtex %s" TeX-run-BibTeX nil t :help "Run BibTeX") ("View" "open %o" TeX-run-discard-or-function t t :help "Run Viewer") ("Print" "%p" TeX-run-command t t :help "Print the file") ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command) ("File" "%(o?)dvips %d -o %f " TeX-run-command t t :help "Generate PostScript file") ("Index" "makeindex %s" TeX-run-command nil t :help "Create index file") ("Check" "lacheck %s" TeX-run-compile nil (latex-mode) :help "Check LaTeX file for correctness") ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document") ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files") ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files") ("Other" "" TeX-run-command t t :help "Run an arbitrary command"))))
 '(preview-fast-dvips-command "pdftops -origpagesizes %s.pdf %m/preview.ps"))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
(setq ispell-program-name "aspell")
(add-to-list 'exec-path "/usr/local/bin")
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(setq ispell-program-name "aspell"
      ispell-dictionary "english"
            ispell-dictionary-alist
                  (let ((default '("[A-Za-z]" "[^A-Za-z]" "[']" nil
                                         ("-B" "-d" "english" "--dict-dir"
                                                                 "/Library/Application Support/cocoAspell/aspell6-en-6.0-0")
                                                                nil iso-8859-1)))
                          `((nil ,@default)
                                    ("english" ,@default))))
