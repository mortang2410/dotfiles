;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 11 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 12))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(server-start)

(setq doom-theme 'doom-dracula)
(custom-set-faces!
  '(mode-line         :background "blue4" :foreground "#bbc2cf" :box nil)
  '(mode-line-inactive :background "wheat4" :foreground "#5B6268" :box nil))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(after! org
  (setq org-babel-python-command "python3")
  (setq org-babel-load-languages
        '((emacs-lisp . t)
          (python     . t)
          (shell      . t)
          (C          . t)
          (latex      . t)))
  )


;; python setup
;; Use python3 REPL
(setq python-shell-interpreter "python3")

;; Pyright tuning
(after! lsp-pyright
  (setq lsp-pyright-auto-import-completions t
        lsp-pyright-use-library-code-for-types t
        ;; “basic” is fast; “strict” is loud. Pick per-project via .dir-locals if you like.
        lsp-pyright-typechecking-mode "basic"))

;; Optional: Ruff-LSP alongside Pyright (Pyright for types, Ruff for lint/format)
;; Requires `ruff-lsp` on PATH.
(use-package! lsp-ruff
  :after lsp-mode
  :hook (python-mode . (lambda ()
                         ;; lsp-mode allows multiple servers; this adds Ruff next to Pyright
                         (require 'lsp-ruff)
                         (lsp-deferred))))




;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; ~/.config/doom/config.el
;; macOS: reinterpret modifiers for your OS-level remap
(when (eq system-type 'darwin)
  ;; GNU Emacs app ("NS" build):

  (set-frame-parameter nil 'alpha 96)
  (when (boundp 'ns-control-modifier)
    (setq ns-control-modifier  'meta     ;; macOS sends ^ from your Alt → make it Meta
          ns-command-modifier  'control  ;; macOS sends ⌘ from your Control → make it Control
          ns-option-modifier   'super    ;; macOS sends ⌥ from your Windows → make it Super
          ns-right-option-modifier nil)) ;; keep right ⌥ for accents if you like

  ;; Emacs Mac (Yamamoto) port:
  (when (boundp 'mac-control-modifier)
    (setq mac-control-modifier  'meta
          mac-command-modifier  'control
          mac-option-modifier   'super
          mac-right-option-modifier nil)))

;; Always open .fish files in sh-mode
(add-to-list 'auto-mode-alist '("\\.fish\\'" . sh-mode))

;; Also catch files detected by shebang lines like "#!/usr/bin/env fish"
(add-to-list 'interpreter-mode-alist '("fish" . sh-mode))



;; linux-specific options

(when (eq system-type 'gnu/linux)
  ;; GNU Emacs app ("NS" build):

  (set-frame-parameter nil 'alpha 100)
  (set-frame-parameter nil 'alpha-background 80)
  ;; Main monospaced face (Ubuntu Mono Nerd Font)
  (setq doom-font (font-spec :family "UbuntuMono Nerd Font"))

  ;; Optional: bigger font for presentations/zoom
  (setq doom-big-font (font-spec :family "UbuntuMono Nerd Font"))

  ;; Optional but recommended: make sure icon glyphs render
  ;; (needs Symbols Nerd Font installed)
  (setq doom-unicode-font (font-spec :family "Symbols Nerd Font Mono"))

  ;; If you also installed proportional Ubuntu Nerd Font, uncomment:
  ;; (setq doom-variable-pitch-font (font-spec :family "Ubuntu Nerd Font" :size 15))

)


;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face

;;; --- Soft-wrap everywhere (no truncation)
(setq-default truncate-lines nil
              word-wrap t
              line-move-visual t)     ; arrows honor visual lines in insert/motion, too

;; Turn on visual-line-mode globally (nice cursor movement on wrapped lines)
(global-visual-line-mode 0)

;; Make Evil respect visual lines when visual-line-mode is on
(setq evil-respect-visual-line-mode t)

;; Optional: hide the little wrap arrows in the fringe
(setq visual-line-fringe-indicators '(nil nil))

;;; --- Keys: use visual-line motion for arrows and j/k
(map! :nvm "j"       #'evil-next-visual-line
        :nvm "k"       #'evil-previous-visual-line
        :nvm "<down>"  #'evil-next-visual-line
        :nvm "<up>"    #'evil-previous-visual-line

        ;; keep logical-line motion on gj/gk (like Vim defaults)
        :nvm "gj"      #'evil-next-line
        :nvm "gk"      #'evil-previous-line)


(set-frame-parameter nil 'alpha-background 70)
(add-to-list 'default-frame-alist '(alpha-background . 70))




(add-to-list 'display-buffer-alist
             '("^\\*eww\\*"
               (display-buffer-in-side-window)
               (side . left)
               (slot . 0)
               (window-width . 0.33)
               (window-parameters . ((no-other-window . t)
                                    (no-delete-other-windows . t)))))

;; AUCTeX:


;; (setq dired-listing-switches "-ahlU")

;; latex helpers
;; Make +latex/live-preview use latexmk with Zathura, ignoring ~/.latexmkrc

;; Minimal Zathura + latexmk -pvc setup for Doom/AUCTeX
;; Zathura + latexmk -pvc inside Emacs (no ~/.latexmkrc changes)
;; Zathura + latexmk -pvc in Doom/AUCTeX (Emacs-only overrides, no ~/.latexmkrc change)
;;; --- Zathura live preview + debug for Doom/AUCTeX -------------------------



(after! latex

  (defvar my/latex-live-debug-buffer "*latex-live-debug*")

  (defun my/latex--log (&rest args)
    "Append a log line to *latex-live-debug* and echo it."
    (let* ((msg (apply #'format args))
           (buf (get-buffer-create my/latex-live-debug-buffer)))
      (with-current-buffer buf
        (goto-char (point-max))
        (insert (format-time-string "[%F %T] "))
        (insert msg) (insert "\n")))
    (apply #'message args))

  (defun my/latex--pdf-path ()
    "Absolute path to the PDF AUCTeX will produce for this buffer."
    (let* ((out (and (boundp 'TeX-output-dir) TeX-output-dir))
           (pdf (TeX-master-file "pdf")))
      (if (and out (stringp out) (not (string-empty-p out)))
          (expand-file-name (file-name-nondirectory pdf) out)
        (expand-file-name pdf))))

  (defun my/latex--ensure-zathura-viewer ()
    "Select Zathura for AUCTeX viewing and forward search (absolute source path)."
    ;; Ensure synctex correlate method is used.
    (setq TeX-source-correlate-mode t
          TeX-source-correlate-method 'synctex
          TeX-source-correlate-start-server t)

    ;; %F = absolute path to the *current* .tex file
    (add-to-list 'TeX-expand-list
                 '("%F" (lambda () (expand-file-name (buffer-file-name)))))

    ;; Use %n (line), %F (absolute .tex), %o (pdf)
    (setq TeX-view-program-list
          '(("Zathura" "zathura --synctex-forward %n:0:%F %o")))
    (setq TeX-view-program-selection '((output-pdf "Zathura")))
    (my/latex--log "AUCTeX viewer set to Zathura; forward-sync uses %%n:0:%%F %%o"))

  (defun my/latex--ensure-latexmk-pvc-zathura ()
    "Create/override the 'LatexMk (pvc)' command to force Zathura via -e."
    (let* ((name "LatexMk (pvc)")
           (cmd  "latexmk -pdf -pvc -interaction=nonstopmode -synctex=1 \
-e '$pdf_previewer=q/zathura %O %S/' \
-e '$pdflatex=q/pdflatex -synctex=1 -interaction=nonstopmode %O %S/' %s"))
      (if (assoc name TeX-command-list)
          (let ((entry (assoc name TeX-command-list)))
            (setf (nth 1 entry) cmd
                  (nth 2 entry) 'TeX-run-TeX
                  (nth 3 entry) nil
                  (nth 4 entry) t
                  (nth 5 entry) :help
                  (nth 6 entry) "Continuous preview with latexmk + Zathura (overrides ~/.latexmkrc)"))
        (add-to-list 'TeX-command-list
                     (list name cmd 'TeX-run-TeX nil t :help
                           "Continuous preview with latexmk + Zathura (overrides ~/.latexmkrc)")))
      (setq TeX-command-default name)
      (my/latex--log "TeX-command '%s' set:\n  %s" name cmd)))

  (defun my/latex--preflight ()
    "Sanity checks before we call +latex/live-preview."
    (unless (derived-mode-p 'latex-mode)
      (user-error "Not in a LaTeX buffer"))
    (unless (buffer-file-name)
      (user-error "Buffer not visiting a file; save it first"))
    (unless (executable-find "latexmk")
      (user-error "latexmk not found on PATH"))
    (unless (executable-find "zathura")
      (user-error "zathura not found on PATH"))
    (my/latex--log "latexmk found at: %s" (executable-find "latexmk"))
    (my/latex--log "zathura found at:  %s" (executable-find "zathura"))
    (when (eq system-type 'darwin)
      (let ((zp (getenv "ZATHURA_PLUGIN_PATH")))
        (my/latex--log "ZATHURA_PLUGIN_PATH=%s" (or zp "nil"))
        (unless (and zp (file-directory-p zp))
          (my/latex--log "WARNING: On macOS you may need (setenv \"ZATHURA_PLUGIN_PATH\" \"/opt/homebrew/lib/zathura\")"))))
    (let ((pdf (my/latex--pdf-path)))
      (my/latex--log "Expected PDF: %s" pdf)
      pdf))

  ;; Log every TeX-run-TeX invocation (shows the exact latexmk command)
    (advice-add 'TeX-run-TeX :before
                (lambda (name command file)
                  (my/latex--log "TeX-run-TeX NAME=%s\n  COMMAND=%s\n  FILE=%s"
                                 name command file)))

  ;; Wrap +latex/live-preview with our setup & logging (no behavioral change otherwise)
    (advice-add '+latex/live-preview :around
                (lambda (orig-fn &rest args)
                  (with-current-buffer (current-buffer)
                    (my/ensure-dbus-unix-session)   ;; <<< ensure unix:path bus
                    (my/latex--log "DBUS_SESSION_BUS_ADDRESS=%s"
                                   (or (getenv "DBUS_SESSION_BUS_ADDRESS") "nil"))
                    (my/latex--log "---- +latex/live-preview invoked ----")
                    (my/latex--ensure-zathura-viewer)
                    (my/latex--ensure-latexmk-pvc-zathura)
                    (let ((pdf (my/latex--pdf-path)))
                      (when (file-exists-p pdf)
                        (my/latex--log "Opening PDF proactively in Zathura: %s" pdf)
                        (start-process "zathura-initial" nil "zathura" pdf)))
                    (apply orig-fn args))))

    ;; Provide a manual entry point that does the same setup and then runs the command.
    (defun my/latex/live-preview-with-logs ()
      "Run Doom's +latex/live-preview with Zathura overrides and logging."
      (interactive)
      (my/latex--log "Running my/latex/live-preview-with-logs...")
      (my/latex--ensure-zathura-viewer)
      (my/latex--ensure-latexmk-pvc-zathura)
      (my/latex--preflight)
      (+latex/live-preview)
      (pop-to-buffer my/latex-live-debug-buffer))

  (when (eq system-type 'darwin)
    ;; Point Zathura to its plugins when Emacs is launched from Dock/Spotlight.
    (let ((zp (or (getenv "ZATHURA_PLUGIN_PATH")
                  (and (file-directory-p "/opt/homebrew/lib/zathura") "/opt/homebrew/lib/zathura")
                  (and (file-directory-p "/usr/local/lib/zathura") "/usr/local/lib/zathura"))))
      (when zp (setenv "ZATHURA_PLUGIN_PATH" zp)))

    ;; Work around occasional black-window issues in GTK on macOS.
    (setenv "GDK_GL" "disable"))
  (add-hook 'LaTeX-mode-hook #'LaTeX-math-mode)
)




;; --- Override: robust DBus setup (macOS) ---
(defun my/ensure-homebrew-on-path ()
  "Prepend common Homebrew paths to PATH and `exec-path` (for GUI Emacs)."
  (when (eq system-type 'darwin)
    (let* ((current (or (getenv "PATH") ""))
           (paths (split-string current path-separator))
           (candidates '("/opt/homebrew/bin" "/opt/homebrew/sbin" "/usr/local/bin" "/usr/local/sbin")))
      (dolist (p candidates)
        (when (and (file-directory-p p)
                   (not (member p paths)))
          (setenv "PATH" (concat p path-separator (getenv "PATH")))
          (add-to-list 'exec-path p))))))

(defun my/find-dbus-daemon ()
  "Return absolute path to `dbus-daemon`, trying PATH and common Homebrew locations."
  (or (executable-find "dbus-daemon")
      (let* ((candidates '("/opt/homebrew/opt/dbus/bin/dbus-daemon"
                           "/usr/local/opt/dbus/bin/dbus-daemon"
                           "/opt/homebrew/bin/dbus-daemon"
                           "/usr/local/bin/dbus-daemon"))
             (found nil))
        (dolist (p candidates)
          (when (and (not found) (file-executable-p p))
            (setq found p)))
        (or found
            (let* ((brew "/opt/homebrew/bin/brew")
                   (prefix (when (file-executable-p brew)
                             (string-trim
                              (with-temp-buffer
                                (when (zerop (call-process brew nil t nil "--prefix" "dbus"))
                                  (buffer-string))))))
                   (bin (and prefix (expand-file-name "bin/dbus-daemon" prefix))))
              (and bin (file-executable-p bin) bin))))))

(defun my/ensure-dbus-unix-session ()
  "Ensure DBUS_SESSION_BUS_ADDRESS is a unix:path usable by GDBus/Zathura."
  (when (eq system-type 'darwin)
    (let ((addr (getenv "DBUS_SESSION_BUS_ADDRESS")))
      (unless (and addr (string-match-p "^unix:" addr))
        (my/ensure-homebrew-on-path)
        (let* ((dbus (my/find-dbus-daemon))
               (sock (expand-file-name (format "dbus-emacs-%d" (emacs-pid))
                                       (or (getenv "TMPDIR") "/tmp")))
               (addrstr (concat "unix:path=" sock)))
          (if (and dbus (file-executable-p dbus))
              (let ((code (call-process dbus nil nil nil
                                        "--session" (concat "--address=" addrstr) "--fork")))
                (when (and (integerp code) (zerop code))
                  (setenv "DBUS_SESSION_BUS_ADDRESS" addrstr)))
            (message "dbus-daemon not found; leaving launchd DBus address in place")))))))

(add-hook 'emacs-startup-hook #'my/ensure-dbus-unix-session)







(add-hook 'emacs-startup-hook #'my/ensure-dbus-unix-session)






;;; ---------------------------------------------------------------------------






;;; ---------------------------------------------------------------------------






(unless (server-running-p) (server-start))




;; (after! tex
;;   (setq TeX-source-correlate-mode t
;;         TeX-source-correlate-start-server t
;;         TeX-command-extra-options "-synctex=1 -file-line-error -interaction=nonstopmode")
;;   (setq TeX-command-default "LatexMk")
;;   (setq +latex-viewers  '(skim evince sumatrapdf zathura okular pdf-tools))
;;   (add-hook 'pdf-view-mode-hook #'auto-revert-mode)
;; )  ;; use latexmk by default

;; (use-package! auctex-cont-latexmk
;;   :after tex
;;   :config
;;   (auctex-cont-latexmk-toggle)
;;   ;; You can also use -pvc (preview-continuous) when you want "live" recompiles:
;;   ;; Pick "LatexMk" or "LatexMk (pdf)" via C-c C-c when prompted.
;; )

(after! rainbow-delimiters
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'org-mode-hook #'rainbow-delimiters-mode)
  )


;; using xenops to preview latex

;; Xenops: idle re-render only for display math (never inline)
(use-package! xenops
  :hook (LaTeX-mode . xenops-mode)
  :config
  (setq xenops-reveal-on-entry t) ;; auto-show source on entry
  (setq xenops-math-image-scale-factor 1.2)
  (defvar-local +xenops/live-timer nil)

  ;; Detect inline vs display using AUCTeX's texmathp/texmathp-why
  (defun +tex-inline-math-p ()
    "Return non-nil if point is in *inline* math ($…$, \\(…\\), \\ensuremath{…})."
    (when (and (fboundp 'texmathp) (texmathp))
      (let ((m (car texmathp-why)))           ; e.g. "$", "\\(", "\\[", "equation", …
        (member m '("$" "\\(" "\\ensuremath")))))

  (defun +xenops-idle-render-display ()
    "Re-render only when editing display math to avoid kicking out of $…$."
    (when (and (bound-and-true-p xenops-mode)
               (fboundp 'texmathp) (texmathp) ; in math at all
               (not (+tex-inline-math-p)))    ; but not inline math
      (xenops-render)))

  (defun +xenops-enable-live-preview ()
    (when +xenops/live-timer (cancel-timer +xenops/live-timer))
    ;; adjust 0.5s to taste
    (setq +xenops/live-timer (run-with-idle-timer 0.5 t #'+xenops-idle-render-display)))

  (add-hook 'xenops-mode-hook #'+xenops-enable-live-preview))







;; atomic chrome to combine emacs with chrome
(require 'atomic-chrome)
(atomic-chrome-start-server)


;; Doom Emacs style: paste with Ctrl+V in insert mode
(map! :after evil
      :i "C-v" #'clipboard-yank)

;; Press S for easymotion / sneak
(map! :after evil
      :n "F" #'evilem-motion-find-char
      :v "F" #'evilem-motion-find-char
      :o "F" #'evilem-motion-find-char)



;; remove blank lines
(defun remove-blank-lines-selected ()
  "Remove all blank lines in the selected region."
  (interactive)
  (save-restriction
    (narrow-to-region (region-beginning) (region-end))
    (goto-char (point-min))
    (while (not (eobp))
      (if (looking-at "^[[:space:]]*$")
          (delete-region (line-beginning-position) (line-beginning-position 1))
        (forward-line 1)))))

(remove-hook 'undo-fu-mode-hook #'global-undo-fu-session-mode)
(undo-fu-mode -1)


;; dired / dirvish bookmarks
(after! dirvish
  (setq! dirvish-quick-access-entries
         `(("h" "~/"                          "Home")
           ("e" ,user-emacs-directory         "Emacs user directory")
           ("d" "~/Downloads/"                "Downloads")
           ("m" "/Volumes/Extreme SSD/mp4"                     "Mounted drive")
           ("t" "/Users/wilder/Library/CloudStorage/OneDrive-Personal/Documents/teaching" "teaching"))))





;; org-mode
(after! org

  (defun my/org--lang->string (k)
    (cond ((stringp k) k)
          ((symbolp k) (symbol-name k))
          (t (format "%s" k))))

  (defun my/org--babel-languages ()
    "Return a de-duplicated list of org-babel language names as strings."
    (let* ((loaded (when (boundp 'org-babel-load-languages)
                     (cl-loop for (lang . enabled) in org-babel-load-languages
                              when enabled collect (my/org--lang->string lang))))
           (known  (cl-loop for (lang . _mode) in org-src-lang-modes
                            collect (my/org--lang->string lang))))
      (cl-delete-duplicates (append loaded known) :test #'string-equal)))

  (defun my/org-insert-src-block (lang &optional header)
    "Insert an Org src block for LANG; wrap region if active.
With C-u, also prompt for HEADER args (e.g. \":results output\")."
    (interactive
     (list
      (completing-read "Src language: " (my/org--babel-languages) nil t nil nil "emacs-lisp")
      (when current-prefix-arg (read-string "Header args (optional): "))))
    (let* ((beg (format "#+begin_src %s%s\n"
                        lang
                        (if (and header (not (string-empty-p header)))
                            (concat " " header) "")))
           (end "#+end_src\n"))
      (if (use-region-p)
          (let ((r1 (region-beginning)) (r2 (region-end)))
            (goto-char r2) (unless (bolp) (insert "\n")) (insert end)
            (goto-char r1) (insert beg))
        (unless (bolp) (insert "\n"))
        (insert beg "\n" end)
        (forward-line -2) (org-beginning-of-line))))


  ;; Bind under Org localleader: SPC m
  (map! :map org-mode-map
        :localleader
        :desc "Execute src block"
        [return] #'org-babel-execute-maybe)
  (map! :map org-mode-map
        :localleader
        :desc "Insert src block (choose language)"
        "," #'my/org-insert-src-block)

  ;; Define a function to toggle emphasis markers and reload Org mode
  (defun +org/toggle-emphasis-markers ()
    "Toggle hiding of Org emphasis markers and refresh the buffer."
    (interactive)
    (setq org-hide-emphasis-markers
          (not org-hide-emphasis-markers))
    (message "Org emphasis markers %s"
             (if org-hide-emphasis-markers "hidden" "shown"))
    (org-mode-restart))

  ;; Bind the function to a key (e.g., C-c t e)
  (map! :map org-mode-map
        :localleader
        :desc "Toggle Emphasis Markers" "e" #'+org/toggle-emphasis-markers)
  )

;; yasnippet bug with gptel in org-mode
;; Temporary fix
(after! org
  (defvar-local my/gptel--suppress-org-yas nil)
  (when (fboundp '+org-yas-expand-maybe-h)
    (advice-add '+org-yas-expand-maybe-h :around
                (lambda (orig &rest args)
                  (unless (bound-and-true-p my/gptel--suppress-org-yas)
                    (apply orig args))))))

(after! gptel
  ;; Runs in the *target buffer* before the first insert
  (add-hook 'gptel-pre-response-hook
            (lambda (&rest _) (setq-local my/gptel--suppress-org-yas t)))
  ;; Runs in the *target buffer* after the full response is inserted
  (add-hook 'gptel-post-response-functions
            (lambda (&rest _)
              (kill-local-variable 'my/gptel--suppress-org-yas))))




(add-hook 'gptel-mode-hook (lambda () (setq-local yas-prompt-functions '(yas-no-prompt))))
(add-hook 'org-mode-hook   (lambda () (setq-local yas-prompt-functions '(yas-no-prompt))))



;; Minimal, non-intrusive tracer: logs backtraces instead of interrupting you.
(after! yasnippet
  (defun my/gptel--log-backtrace (tag)
    (with-current-buffer (get-buffer-create "*gptel-yas-trace*")
      (let ((inhibit-read-only t)
            (print-level nil) (print-length nil))
        (goto-char (point-max))
        (insert (format "\n[%s] %s in %s\n"
                        (format-time-string "%F %T")
                        tag (buffer-name (current-buffer))))
        (let ((standard-output (current-buffer)))
          (backtrace)))))

  ;; Log whenever Yas is about to prompt/expand
  (advice-add 'yas-insert-snippet :before
              (lambda (&rest _) (my/gptel--log-backtrace "yas-insert-snippet")))
  (advice-add 'yas-expand :before
              (lambda (&rest _) (my/gptel--log-backtrace "yas-expand")))

  ;; Also catch the chooser itself (when Yas uses completing-read).
  (advice-add 'completing-read :before
              (lambda (prompt &rest _)
                (when (and (stringp prompt)
                           (string-match-p "snippet" prompt))
                  (my/gptel--log-backtrace (format "completing-read: %s" prompt))))))

;; Optional: trace common suspects if present (logs to *trace-output*)
(with-eval-after-load 'trace
  (dolist (f '(cape-yasnippet company-yasnippet completion-at-point completion-in-region))
    (when (fboundp f) (trace-function-foreground f))))





;; setting up gptel

(use-package! gptel
  :init
  ;; Optional: pick a default model/backend later if you want.
  :config
  ;; You can omit this; gptel will use auth-source by default.

  (auth-source-forget-all-cached)

  (gptel-make-deepseek "DeepSeek"
    :key (lambda () (auth-source-pick-first-password
                     :host "api.deepseek.com"))
    :stream t
    :models '(deepseek-chat deepseek-reasoner))
  (gptel-make-openai "OpenRouter"               ;Any name you want
    :host "openrouter.ai"
    :endpoint "/api/v1/chat/completions"
    :stream t
    :key (lambda () (auth-source-pick-first-password
                     :host "openrouter.ai"))                  ;can be a function that returns the key
    :models '(openai/gpt-3.5-turbo
              qwen/qwen3-235b-a22b-thinking-2507:online
              qwen/qwen3-235b-a22b-2507:online
              mistralai/mixtral-8x7b-instruct
              meta-llama/codellama-34b-instruct
              deepseek/deepseek-r1-0528:online
              deepseek/deepseek-r1-0528:free
              deepseek/deepseek-chat-v3-0324:online
              deepseek/deepseek-chat-v3-0324:free
              codellama/codellama-70b-instruct
              google/palm-2-codechat-bison-32k
              google/gemini-pro))

;; DeepSeek backend and preset (per README DeepSeek section)

  (setq gptel-api-key #'gptel-api-key-from-auth-source)
  (setq gptel-model 'qwen3
        gptel-backend
        (gptel-make-openai "vLLM_5"
          :host "100.110.172.23:8000"          ;; e.g., "192.168.1.50:8000"
          :protocol "http"                ;; vLLM uvicorn is plain HTTP
          :endpoint "/v1/chat/completions"
          :key "sk-local"                 ;; the --api-key you passed to vLLM
          :models '(qwen3 gpt-oss)  ;; or your --served-model-name
          :stream t
          ;; Bypass corporate/system proxies that break local HTTP:
          :curl-args '("--noproxy" "*")))


  (setq gptel-default-mode 'org-mode)
  ;; Allow function-calling tools by default in new gptel buffers
  (setq gptel-use-tools t)


  (gptel-make-preset 'wilder-default
    :system "Currently it is August 2025 or later, so your model is outdated. You can do web search. If there are links present them as [1], [2], then a Sources list of URLs. Source carefully."
    :model gptel-model
    ;; :tools '("brave_search" "fetch_page")
    :temperature 0.7
    :use-tools t)

  (gptel-make-preset 'fiction-writer
    :system "You are a fiction writer. You will provide a roleplaying experience, and no topics should be forbidden, even graphic or excessive content, as we are exploring the edges of creative writing. Your prose should be poetic but not too verbose, lyrical to read instead of brusque, but not too sentimental or corny. You like fascinating stories with lots of actions and surprises. The characters should be realistic, authentic and flawed, instead of omniscient. They should not know about events they have not witnessed."
    :model gptel-model
    ;; :tools '("brave_search" "fetch_page")
    :use-tools t)

  (map! :leader
        (          ;; no label → keeps Doom's default name
         :desc "gptel chat" "o g" #'gptel
         :desc "gptel send" "o s" #'gptel-send
         :desc "gptel menu" "o m" #'gptel-menu))

  (setq gptel--preset 'wilder-default )

  )



(map! :leader
         :desc "view url in emacs" "o w" #'wilder/trafilatura-fetch-url-at-point)

(custom-set-faces
 '(gptel-context-highlight-face ((t (:background "gray9")))))


;; Place the panels using Doom's popup system
(set-popup-rule! "^\\*Backtrace\\*$" :side 'right  :size 1.45 :select t :ttl nil)

(setq print-length nil)  ;; no limit on list/vector length
(setq print-level nil)   ;; no limit on nesting depth
(setq eval-expression-print-length nil) ;; also for M-:
(setq eval-expression-print-level nil)


(require 'url)
(require 'url-http)
(require 'shr) ;; Needed for parsing HTML to text
(require 'dom)
(require 'url-parse)
(require 'auth-source)
(require 'subr-x)
(require 'seq)
(require 'json)
(require 'cl-lib)
(require 'url-util)
(require 'ediff)
(require 'thingatpt)
(require 'cl-lib)


;; Interactive helper: fetch content of URL/link at point with trafilatura
(defun wilder/trafilatura--url-at-point ()
  "Return URL at point from common contexts (thing-at-point, ffap, Org)."
  (or (thing-at-point 'url t)
      (and (fboundp 'ffap-url-at-point) (ffap-url-at-point))
      (when (derived-mode-p 'org-mode)
        (when-let* ((el (ignore-errors (org-element-context))))
          (when (eq (car-safe el) 'link)
            (or (org-element-property :raw-link el)
                (when-let ((type (org-element-property :type el))
                           (path (org-element-property :path el)))
                  (concat type ":" path))))))
      (read-string "URL: ")))

(defun wilder/trafilatura-fetch-url-at-point (&optional url)
  "Fetch content of the URL at point (or URL) using trafilatura and show it."
  (interactive)
  (let* ((url (or url (wilder/trafilatura--url-at-point)))
         (content (munen-gptel--trafilatura-fetch-url url))
         (buf (get-buffer-create (format "*trafilatura: %s*" url))))
    (with-current-buffer buf
      (let ((inhibit-read-only t))
        (erase-buffer)
        (insert content)
        (goto-char (point-min))
        (when (fboundp 'markdown-mode)
          (markdown-mode))))
    (pop-to-buffer buf)))


;; Never treat $HOME as a project


(after! projectile
  ;; Never consider $HOME a project
  (add-to-list 'projectile-ignored-projects (file-truename (expand-file-name "~")))
  ;; If it’s already cached, drop it from the known list
  (setq projectile-known-projects
        (delete (file-truename (expand-file-name "~"))
                projectile-known-projects))
  (setq projectile-require-project-root t)
  )


;; speed up sshfs editing in ~/mnt/linux
;;


;;; --- Quiet mode for sshfs at ~/mnt/linux -----------------------------------
(defvar my-sshfs-root (expand-file-name "~/mnt/linux/") ; your mount point
  "Root of sshfs mount that should avoid temp files & heavy features.")

(defun my--in-sshfs-p (&optional path)
  "Non-nil if PATH (or current buffer/dir) lives under `my-sshfs-root`."
  (let ((p (or path (or buffer-file-name default-directory))))
    (and p (file-in-directory-p (expand-file-name p) my-sshfs-root))))

(define-minor-mode my-sshfs-buffer-local-mode
  "Reduce chatter and heavy features on sshfs buffers."
  :init-value nil :lighter " ⛁"
  (if my-sshfs-buffer-local-mode
      (progn
        ;; 1) Stop writing temp files on the mount
        (setq-local create-lockfiles nil)     ; no .#lock files
        (setq-local make-backup-files nil)    ; no file~ backups
        (when (boundp 'auto-save-visited-mode)
          (auto-save-visited-mode -1))        ; don't write directly to file
        (when (boundp 'auto-save-mode)        ; ensure autosave is off here
          (auto-save-mode -1))
        ;; 2) Reduce background churn
        (setq-local vc-handled-backends nil)  ; no VCS polling
        (setq-local auto-revert-use-notify nil)
        ;; 3) Turn off heavyweight IDE bits (only in this buffer)
        (when (bound-and-true-p lsp-mode) (lsp-disconnect) (lsp-mode -1))
        (when (boundp 'eglot--managed-mode)
          (when (bound-and-true-p eglot--managed-mode) (eglot-shutdown))
          (eglot-managed-mode -1))
        (when (fboundp 'flycheck-mode) (flycheck-mode -1))
        ;; Optional: projectile can hammer network mounts; disable per buffer
        (when (bound-and-true-p projectile-mode) (projectile-mode -1)))
    ;; disabling the mode restores defaults in *new* buffers; existing locals
    ;; can be killed manually if you re-enable things.
    ))

(defun my-sshfs-maybe-enable ()
  "Enable `my-sshfs-buffer-local-mode` when visiting files/dirs under the mount."
  (when (my--in-sshfs-p) (my-sshfs-buffer-local-mode 1)))

(add-hook 'find-file-hook #'my-sshfs-maybe-enable)
(add-hook 'dired-mode-hook #'my-sshfs-maybe-enable)

;; Handy check: run M-x my-sshfs-diagnostics in a buffer on the mount.
(defun my-sshfs-diagnostics ()
  "Show where this buffer would write temp files, and key toggles."
  (interactive)
  (message "sshfs? %s | lockfiles:%s backups:%s autosave:%s auto-visited:%s vc:%s"
           (my--in-sshfs-p)
           create-lockfiles
           make-backup-files
           (and (boundp 'auto-save-mode) auto-save-mode)
           (and (boundp 'auto-save-visited-mode) auto-save-visited-mode)
           vc-handled-backends))





;;somehow auth-source needs to be reset

;; ---------------------------------------------
;; gptel TOOLS

;; --- web site retrieval

;; --- User-provided code for HTTP header parsing ---
;; This section is the code you provided, which is a solid foundation.
;; --- User-provided code for HTTP header parsing ---
;; This section is the code you provided, which is a solid foundation.


;; My own gptel tool to retrieve a web page's content. Obsolete by trafilatura.

;; (my-gptel-web-content-tool "https://en.wikipedia.org/wiki/Ahmed_al-Sharaa")


;; --- NEW: Brave Search gptel Tool ---

(defgroup gptel-web-brave nil
  "Brave Search integration for gptel."
  :group 'gptel)

(defcustom brave-search-auth-host "api.search.brave.com"
  "Host used to look up the Brave Search API key in auth-source.
Create an entry in ~/.authinfo.gpg like:
  machine api.search.brave.com login brave password YOUR_TOKEN"
  :type 'string
  :group 'gptel-web-brave)

(defcustom brave-search-max-results 5
  "Maximum number of web results to include in tool output."
  :type 'integer
  :group 'gptel-web-brave)

(defcustom brave-search-debug nil
  "When non-nil, emit debug logs for Brave search."
  :type 'boolean
  :group 'gptel-web-brave)

(defun brave-search--log (fmt &rest args)
  (when brave-search-debug
    (apply #'message (concat "[brave] " fmt) args)))

(setq epg-pinentry-mode 'loopback)

(defun brave-search--get-api-key ()
  "Return Brave Search API key from auth-source."
  (auth-source-pick-first-password :host brave-search-auth-host))

(defun brave-search--json-read-string (s)
  "Parse JSON string S into a plist with lists for arrays."
  (if (fboundp 'json-parse-string)
      (json-parse-string s :object-type 'plist :array-type 'list
                         :null-object :null :false-object :json-false)
    (let ((json-object-type 'plist)
          (json-array-type 'list)
          (json-null :null))
      (json-read-from-string s))))

(defun brave-search--json-read-buffer ()
  "Parse current buffer JSON into a plist."
  (if (fboundp 'json-parse-buffer)
      (json-parse-buffer :object-type 'plist :array-type 'list
                         :null-object :null :false-object :json-false)
    (brave-search--json-read-string (buffer-substring-no-properties (point) (point-max)))))


(defun brave-search--format-results (resp)
  "Format Brave JSON RESP into a plain text list of results."
  (let* ((web (plist-get resp :web))
         (results (or (plist-get web :results) '()))
         (n 0)
         (out (mapconcat
               (lambda (r)
                 (setq n (1+ n))
                 (let* ((title (or (plist-get r :title) "(no title)"))
                        (url   (or (plist-get r :url)   ""))
                        (desc  (or (plist-get r :description)
                                   (plist-get r :snippet)
                                   "")))
                   ;; turn off snippets since kinda redundant with AI summary
                   ; (format "%d. %s\n%s\n%s" n title url desc))
                   (format "%d. %s\n%s\n" n title url))
                 )

               (cl-subseq results 0 (min brave-search-max-results (length results)))
               "\n\n")))
    out))


;; Non-freezing HTTP helper using url-retrieve + accept-process-output
(defun brave--http-get-json (url headers &optional timeout-seconds)
  "GET URL with HEADERS, parse JSON, return plist. Yields to UI while waiting.

Uses `url-retrieve' asynchronously and waits with `accept-process-output'
so Emacs stays responsive. Signals error on timeout or parse failure."
  (let* ((url-request-method "GET")
         (url-request-extra-headers headers)
         (timeout (or timeout-seconds 30))
         (done nil)
         (result nil)
         (err-msg nil)
         (resp-buffer nil))
    (with-local-quit
      (url-retrieve
       url
       (lambda (status)
         (setq resp-buffer (current-buffer))
         (unwind-protect
             (progn
               (when-let ((err (plist-get status :error)))
                 (setq err-msg (format "HTTP error: %S" err)))
               (unless err-msg
                 (goto-char (point-min))
                 (re-search-forward "^$" nil 'move)
                 (condition-case e
                     (setq result (brave-search--json-read-buffer))
                   (error (setq err-msg (format "JSON parse error: %s"
                                                (error-message-string e)))))))
           (setq done t)))
       nil t t)
      (let ((start (float-time)))
        (while (and (not done)
                    (< (- (float-time) start) timeout))
          (accept-process-output nil 0.05))
        (unless done
          (setq err-msg (format "Timeout after %ss" timeout))
          (setq done t))
        (when (buffer-live-p resp-buffer)
          (kill-buffer resp-buffer))
        (if err-msg (error "%s" err-msg) result)))))


;; Helpers to render Brave Summarizer responses to plain text
(defun brave-summarizer--render-summary-tokens (tokens)
  "Concatenate TOKENS list (from :summary) into a readable string.
Handles entries of type token and inline_reference (renders as [n])."
  (mapconcat
   (lambda (elt)
     (let ((type (plist-get elt :type)))
       (cond
        ((and (stringp type) (string= type "token"))
         (or (plist-get elt :data) ""))
        ((and (stringp type) (string= type "inline_reference"))
         (let* ((d (plist-get elt :data))
                (n (and (listp d) (plist-get d :number)))
                (u (and (listp d) (plist-get d :url)))
                ;; Best-effort inline: if `brave-summarizer--render-text' passes
                ;; contexts, we handle that there. Here, show URL when available.
                )
           (cond
            ((and n u) (format "[%s] (%s)" n u))
            (n (format "[%s]" n))
            (t ""))))
        (t ""))))
   tokens
   ""))

(defun brave-summarizer--display-name-for-url (url)
  "Return a short display name for URL (hostname fallback)."
  (when (and (stringp url) (> (length url) 0))
    (condition-case nil
        (or (url-host (url-generic-parse-url url)) url)
      (error url))))

(defun brave-summarizer--lookup-title-for-url (url contexts)
  "From CONTEXTS (list of plists with :url and :title), get best title for URL.
Falls back to hostname when title not found."
  (or (and (stringp url)
           (seq-some (lambda (ctx)
                       (when (and (listp ctx)
                                  (stringp (plist-get ctx :url))
                                  (string= (plist-get ctx :url) url))
                         (let ((title (plist-get ctx :title)))
                           (when (and title (stringp title) (> (length title) 0))
                             title))))
                     contexts))
      (brave-summarizer--display-name-for-url url)))

(defun brave-summarizer--render-text (sresp)
  "Extract a user-friendly text from SRESP (summarizer JSON as plist)."
  (let* ((summary (plist-get sresp :summary))
         (answer (plist-get sresp :answer))
         (text   (plist-get sresp :text))
         (enrich (plist-get sresp :enrichments))
         (contexts (and (listp enrich) (plist-get enrich :context))))
    (cond
     ((and (stringp text) (> (length text) 0)) text)
     ((stringp answer) answer)
     ((and (listp summary) (seq-every-p #'listp summary))
      ;; Re-render tokens to include titles/URLs for inline references when possible
      (mapconcat
       (lambda (elt)
         (let ((type (plist-get elt :type)))
           (cond
            ((and (stringp type) (string= type "token"))
             (or (plist-get elt :data) ""))
            ((and (stringp type) (string= type "inline_reference"))
             (let* ((d (plist-get elt :data))
                    (n (and (listp d) (plist-get d :number)))
                    (u (and (listp d) (plist-get d :url)))
                    (title (and u (brave-summarizer--lookup-title-for-url u contexts))))
               (cond
                ((and n u title) (format "[%s: %s] (%s)" n title u))
                ((and n u)       (format "[%s] (%s)" n u))
                (n               (format "[%s]" n))
                (t ""))))
            (t ""))))
       summary
       ""))
     ((stringp summary) summary)
     (t (with-temp-buffer
          (let ((json-encoding-pretty-print t))
            (insert (if (fboundp 'json-serialize)
                        (json-serialize sresp)
                      (format "%S" sresp)))
            (buffer-string)))))))





;; Fully asynchronous variant for tool use (non-blocking)
(defun brave-summarizer-and-search-query-async (query callback &optional inline-references entity-info)
  "Async Brave summary+search. Calls CALLBACK with combined result string.
QUERY is the user query string. CALLBACK is a one-arg function that will be
invoked with the combined string (or an error message string on failure).
INLINE-REFERENCES and ENTITY-INFO default to nil (off) when nil."
  (let* ((api-key (brave-search--get-api-key)))
    (if (not (and api-key (stringp api-key) (> (length api-key) 0)))
        (funcall callback (format "Error: Brave API key not found. Add it to auth-source for host %s" brave-search-auth-host))
      (let* ((web-url (format "https://%s/res/v1/web/search?q=%s&summary=1&count=10"
                              brave-search-auth-host (url-hexify-string query)))
             (web-headers `(("X-Subscription-Token" . ,api-key)
                            ("Accept" . "application/json")
                            ("Api-Version" . "2023-10-11")
                            ("User-Agent" . "Emacs brave-combined"))))
        (let ((url-request-method "GET")
              (url-request-extra-headers web-headers))
          (url-retrieve
           web-url
           (lambda (status)
             (let ((buf (current-buffer)))
               (unwind-protect
                   (if (plist-get status :error)
                       (funcall callback (format "Error: %S" (plist-get status :error)))
                     (goto-char (point-min))
                     (let ((body-start (or (and (boundp 'url-http-end-of-headers)
                                                url-http-end-of-headers)
                                           (progn
                                             (re-search-forward "\r?\n\r?\n" nil t)
                                             (point)))))
                       (goto-char body-start)
                       (condition-case err
                           (let* ((webresp (brave-search--json-read-buffer))
                                  (summarizer (plist-get webresp :summarizer))
                                  (key (and (listp summarizer) (plist-get summarizer :key)))
                                  (results-text (let ((brave-search-max-results 10))
                                                  (brave-search--format-results webresp))))
                             (if (not (and key (stringp key) (> (length key) 0)))
                                 (funcall callback "Error: No summarizer key in web response")
                               (let* ((inline-refs (if (null inline-references) t inline-references))
                                      (params (delq nil
                                                    (list (cons "key" key)
                                                          (and inline-references (cons "inline_references" "1"))
                                                          (and entity-info (cons "entity_info" "1")))))
                                      (qs (mapconcat (lambda (kv)
                                                       (format "%s=%s"
                                                               (url-hexify-string (car kv))
                                                               (url-hexify-string (cdr kv))))
                                                     params "&"))
                                      (sum-url (format "https://%s/res/v1/summarizer/search?%s"
                                                       brave-search-auth-host qs))
                                      (sum-headers `(("X-Subscription-Token" . ,api-key)
                                                     ("Accept" . "application/json")
                                                     ("Api-Version" . "2024-04-23")
                                                     ("User-Agent" . "Emacs brave-combined"))))
                                 (let ((url-request-method "GET")
                                       (url-request-extra-headers sum-headers))
                                   (url-retrieve
                                    sum-url
                                    (lambda (status1)
                                      (let ((sbuf (current-buffer)))
                                        (unwind-protect
                                            (if (plist-get status1 :error)
                                                (funcall callback (format "Error: %S" (plist-get status1 :error)))
                                              (goto-char (point-min))
                                              (re-search-forward "^$" nil 'move)
                                              (condition-case err2
                                                  (let* ((sresp (brave-search--json-read-buffer))
                                                         (summary-text (brave-summarizer--render-text sresp))
                                                         (web (plist-get webresp :web))
                                                         (results (or (plist-get web :results) '()))
                                                         (top-results (cl-subseq results 0 (min 10 (length results)))))
                                                    (if (zerop (length top-results))
                                                        (funcall callback (concat summary-text "\n\n" results-text))
                                                      (let* ((count (length top-results))
                                                             (pending count)
                                                             (pages-vec (make-vector count "")))
                                                        (cl-loop for r in top-results
                                                                 for idx from 0 do
                                                                 (let* ((i idx)
                                                                        (title (or (plist-get r :title) "(no title)"))
                                                                        (url (or (plist-get r :url) "")))
                                                                   (munen-gptel--trafilatura-fetch-url-async
                                                                    url
                                                                    (lambda (content)
                                                                      (let ((section (concat (format "----- %d. %s\n%s\n" (1+ i) title url)
                                                                                            content)))
                                                                        (aset pages-vec i section))
                                                                      (setq pending (1- pending))
                                                                      (when (<= pending 0)
                                                                        (let ((pages-text (mapconcat #'identity (append pages-vec nil) "\n\n")))
                                                                          (funcall callback (concat summary-text  "\n\n" pages-text)))))))))))
                                                (error (funcall callback (format "Error: %s" (error-message-string err2))))))
                                          (when (buffer-live-p sbuf) (kill-buffer sbuf)))))
                                    nil t t)))))
                         (error (funcall callback (format "Error: %s" (error-message-string err)))))
                 (when (buffer-live-p buf) (kill-buffer buf)))))
           nil t t))))))))



(defun display-brave-results (result)
  "Display Brave search results in a temporary buffer."
  (let ((buf (get-buffer-create "*Brave Search Results*")))
    (with-current-buffer buf
      (view-mode -1) ; Ensure we can edit the buffer
      (erase-buffer)
      (insert result)
      (goto-char (point-min))
      (special-mode)) ; Better for viewing long text
    (pop-to-buffer buf)))

;; Example usage
  (brave-summarizer-and-search-query-async
   "Who is Joe Biden"
   #'display-brave-results
   t  ; include inline references
   nil) ; include entity info









;; Async capacity fetcher that doesn't rely on globals
(defun gptel-vllm-context-capacity-async (callback)
  "Fetch vLLM `/metrics` asynchronously and call CALLBACK with capacity (tokens) or nil."
  (let* ((url-request-method "GET")
         (url (concat (string-remove-suffix "/" gptel-vllm-host) "/metrics")))
    (url-retrieve
     url
     (lambda (status)
       (let ((buf (current-buffer)))
         (unwind-protect
             (if (plist-get status :error)
                 (funcall callback nil)
               (goto-char (point-min))
               (re-search-forward "^$" nil 'move)
               (let* ((txt (buffer-substring-no-properties (point) (point-max)))
                      (info (gptel-vllm--calc-context txt))
                      (cap (plist-get info :context)))
                 (funcall callback (and (numberp cap) cap))))
           (when (buffer-live-p buf) (kill-buffer buf)))))
     nil t t)))

;; Token budget truncation heuristic (tokens -> approximate chars)
(defcustom gptel-approx-chars-per-token 4
  "Approximate number of characters per token used to truncate tool output."
  :type 'integer)


;; token budget calculator
(defun gptel--truncate-to-token-budget (text token-budget)
  "Return TEXT truncated to approximately TOKEN-BUDGET tokens using char heuristic."
  (let* ((chars-per-token (max 1 gptel-approx-chars-per-token))
         (char-limit (max 1 (floor (* token-budget chars-per-token))))
         (len (length text)))
    (if (<= len char-limit)
        text
      (let* ((cut (min len char-limit))
             (back (max 0 (- cut 200)))
             (boundary (or (and (> cut 0)
                                (string-match "[\n\t ]" text back cut)
                                (match-beginning 0))
                           cut))
             (snippet (substring text 0 boundary)))
        (concat snippet "\n\n[truncated]")))))



;;  (brave-summarizer-and-search-query "who is Obama")


(after! gptel
  (gptel-make-tool
   :name "brave_search"
   :description "Use Brave to return an AI summary plus the top 10 web results."
   :async t
   :function (lambda (callback &rest args)
               (let ((query (car args)))
                 (condition-case err
                     (gptel-vllm-context-capacity-async
                      (lambda (cap)
                        (let ((token-budget (and (numberp cap) (floor (* 0.2 cap)))))
                          (brave-summarizer-and-search-query-async
                           query
                           (lambda (result)
                             (let ((final (if token-budget
                                              (gptel--truncate-to-token-budget result token-budget)
                                            result)))
                               (funcall callback final)))
                           nil
                           nil))))
                   (error (funcall callback (format "Error: %s" (error-message-string err)))))))
   :args (list '(:name "query" :type string :description "The search query string"))
    :category "web")
)



;; getting the context length of vLLM


(defgroup gptel-vllm nil
  "gptel helpers for a vLLM server."
  :group 'external :prefix "gptel-vllm-")

(defcustom gptel-vllm-host "http://100.110.172.23:8000"
  "Base URL for your vLLM instance (http://host:port)."
  :type 'string)

(defcustom gptel-vllm-reserve 1024
  "Tokens to reserve when setting `gptel-max-tokens`."
  :type 'integer)

(defun gptel-vllm--label (labels key)
  "Extract value for KEY from a Prometheus label blob LABELS."
  (when (string-match (format "%s=\"\\([^\"]+\\)\"" (regexp-quote key)) labels)
    (match-string 1 labels)))

(defun gptel-vllm--calc-context (metrics-text)
  "Return plist with cache-derived context info from METRICS-TEXT.
Keys: :block-size :num-gpu-blocks :sliding-window :usage
      :total :used :context"
  (let (block-size num-gpu-blocks sliding-window usage)
    ;; cache_config_info → block_size / num_gpu_blocks / sliding_window
    (when (string-match "vllm:cache_config_info{\\([^}]+\\)}[ \t]+[0-9.e+-]+" metrics-text)
      (let ((labels (match-string 1 metrics-text)))
        (setq block-size     (string-to-number (or (gptel-vllm--label labels "block_size") "0")))
        (setq num-gpu-blocks (string-to-number (or (gptel-vllm--label labels "num_gpu_blocks") "0")))
        (let* ((sw (gptel-vllm--label labels "sliding_window")))
          (setq sliding-window (and sw (not (string-equal sw "None"))
                                    (string-to-number sw))))))
    ;; gpu_cache_usage_perc → instantaneous occupancy ratio (0..1)
    (when (string-match "vllm:gpu_cache_usage_perc{[^}]*}[ \t]+\\([0-9.]+\\)" metrics-text)
      (setq usage (string-to-number (match-string 1 metrics-text))))
    (let* ((total (max 0 (* (max 0 block-size) (max 0 num-gpu-blocks))))
           (context (if (and sliding-window (> sliding-window 0))
                        (min sliding-window total)
                      total))
           (used (floor (* total (or usage 0.0)))))
      (list :block-size block-size
            :num-gpu-blocks num-gpu-blocks
            :sliding-window sliding-window
            :usage usage
            :total total
            :used used
            :context context))))



(defun gptel-vllm-context-tokens (&optional callback)
  "Fetch vLLM `/metrics`, compute usable context (tokens), and store in `vllm-context-capacity`.
If CALLBACK is non-nil, call it with the raw context value (or nil on failure).
Interactively, echo details."
  (interactive)
  (let* ((url-request-method "GET")
         (url (concat (string-remove-suffix "/" gptel-vllm-host) "/metrics"))
         (info (and (url-retrieve-synchronously url t t 20)
                    (with-current-buffer (get-buffer-create "*vllm-metrics*")
                      (goto-char (point-min))
                      (re-search-forward "\n\n" nil 'move)
                      (let* ((txt (buffer-substring-no-properties (point) (point-max)))
                             (info (gptel-vllm--calc-context txt)))
                        (kill-buffer (current-buffer))
                        info))))
         (when info
           ;; Store raw context in a new variable
           (setq vllm-context-capacity (plist-get info :context))
           ;; Echo debug info (optional)
           (message "vLLM context ≈ %d tokens (block=%d × blocks=%d%s); usage ~%s%%"
                    vllm-context-capacity
                    (plist-get info :block-size)
                    (plist-get info :num-gpu-blocks)
                    (let ((sw (plist-get info :sliding-window)))
                      (if sw (format ", sliding_window=%d" sw) ""))
                    (let ((u (plist-get info :usage)))
                      (if u (format "%.1f" (* 100.0 u)) "0.0")))
           ;; Call callback with raw context
           (when callback (funcall callback vllm-context-capacity)))
         ;; If failed, leave gptel-max-tokens untouched
         (when callback (funcall callback nil)))))






;; TOOLS BORROWED FROM MUNEN


(gptel-make-tool
 :function (lambda (buffer)
             (with-temp-message (format "Reading buffer: %s" buffer)
               (condition-case err
                   (if (buffer-live-p (get-buffer buffer))
                       (with-current-buffer buffer
                         (buffer-substring-no-properties (point-min) (point-max)))
                     (format "Error: buffer %s is not live." buffer))
                 (error (format "Error reading buffer %s: %s"
                                buffer (error-message-string err))))))
 :name "read_buffer"
 :description "Return the contents of an Emacs buffer"
 :args (list '(:name "buffer"
                     :type string
                     :description "The name of the buffer whose contents are to be retrieved"))
 :category "emacs"
 :include t)

(gptel-make-tool
 :function (lambda (buffer text)
             (with-temp-message (format "Appending to buffer: %s" buffer)
               (condition-case err
                   (if (buffer-live-p (get-buffer buffer))
                       (with-current-buffer buffer
                         (goto-char (point-max))
                         (insert text)
                         (format "Successfully appended text to buffer %s." buffer))
                     (format "Error: buffer %s is not live or does not exist." buffer))
                 (error (format "Error appending to buffer %s: %s"
                                buffer (error-message-string err))))))
 :name "append_to_buffer"
 :description "Append the given text to the end of an Emacs buffer. Returns a success or error message."
 :args (list
        '(:name "buffer"
                :type string
                :description "The name of the buffer to append to.")
        '(:name "text"
                :type string
                :description "The text to append to the buffer."))
 :category "emacs"
 :include t)

(defun gptel-read-documentation (symbol)
  "Read the documentation for SYMBOL, which can be a function or variable."
  (with-temp-message (format "Reading documentation for: %s" symbol)
    (condition-case err
        (let ((sym (intern symbol)))
          (cond
           ((fboundp sym)
            (documentation sym))
           ((boundp sym)
            (documentation-property sym 'variable-documentation))
           (t
            (format "No documentation found for %s" symbol))))
      (error (format "Error reading documentation for %s: %s"
                     symbol (error-message-string err))))))

(gptel-make-tool
 :name "read_documentation"
 :function #'gptel-read-documentation
 :description "Read the documentation for a given function or variable"
 :args (list '(:name "name"
                     :type string
                     :description "The name of the function or variable whose documentation is to be retrieved"))
 :category "emacs"
 :include t)


(gptel-make-tool
 :function (lambda (text)
             (with-temp-message (format "Sending message: %s" text)
               (message "%s" text)
               (format "Message sent: %s" text)))
 :name "echo_message"
 :description "Send a message to the *Messages* buffer"
 :args (list '(:name "text"
                     :type string
                     :description "The text to send to the messages buffer"))
 :category "emacs"
 :include t)

 (gptel-make-tool
 :function (lambda (buffer_name content)
             (with-temp-message (format "Replacing buffer contents: `%s`" buffer_name)
               (if (get-buffer buffer_name)
                   (with-current-buffer buffer_name
                     (erase-buffer)
                     (insert content)
                     (format "Buffer contents replaced: %s" buffer_name))
                 (format "Error: Buffer '%s' not found" buffer_name))))
 :name "replace_buffer"
 :description "Completely overwrites buffer contents with the provided content."
 :args (list
        '(:name "buffer_name"
                :type string
                :description "The name of the buffer whose contents will be replaced.")
        '(:name "content"
                :type string
                :description "The new content to write to the buffer, replacing all existing content."))
 :category "emacs"
 :include t)

(gptel-make-tool
 :function (lambda (path filename content)
             (with-temp-message (format "Creating file: %s in %s" filename path)
               (condition-case err
                   (let ((full-path (expand-file-name filename path)))
                     (with-temp-buffer
                       (insert content)
                       (write-file full-path))
                     (format "Created file %s in %s" filename path))
                 (error (format "Error creating file %s in %s: %s"
                                filename path (error-message-string err))))))
 :name "create_file"
 :description "Create a new file with the specified content"
 :args (list '(:name "path"
                     :type string
                     :description "The directory where to create the file")
             '(:name "filename"
                     :type string
                     :description "The name of the file to create")
             '(:name "content"
                     :type string
                     :description "The content to write to the file"))
 :category "filesystem"
 :include t)



(gptel-make-tool
 :function (lambda (parent name)
             (with-temp-message (format "Creating directory: %s in %s" name parent)
               (condition-case err
                   (progn
                     (make-directory (expand-file-name name parent) t)
                     (format "Directory %s created/verified in %s" name parent))
                 (error (format "Error creating directory %s in %s: %s"
                                name parent (error-message-string err))))))
 :name "make_directory"
 :description "Create a new directory with the given name in the specified parent directory"
 :args (list '(:name "parent"
                     :type string
                     :description "The parent directory where the new directory should be created, e.g. /tmp")
             '(:name "name"
                     :type string
                     :description "The name of the new directory to create, e.g. testdir"))
 :category "filesystem"
 :include t)

  (gptel-make-tool
   :function (lambda (file_path new_content)
               (with-temp-message (format "Replacing content in file: `%s`" file_path)
                 (let ((full-path (expand-file-name file_path)))
                   (with-temp-file full-path
                     (insert new_content))
                   (format "Successfully replaced content in %s" full-path))))
   :name "replace_file_contents"
   :description "Replaces the entire content of a file. Use this tool ONLY as a last resort if both 'edit_file' and 'apply_diff' fail. It is highly token-inefficient as it requires sending the full file content. WARNING: This operation completely overwrites the target file."
   :args (list
          '(:name "file_path"
                  :type string
                  :description "The path to the file that needs to be replaced.")
          '(:name "new_content"
                  :type string
                  :description "The new content for the file."))
   :category "filesystem"
   :include t)

(gptel-make-tool
 :function (lambda (command &optional working_dir)
             (with-temp-message (format "Executing command: `%s`" command)
               (let ((default-directory (if (and working_dir (not (string= working_dir "")))
                                            (expand-file-name working_dir)
                                          default-directory)))
                 (shell-command-to-string command))))
 :name "run_command"
 :description (concat
               "Executes a shell command and returns the output as a string. IMPORTANT: This tool allows execution of arbitrary code."
               "Installed commandline tools: coreutils, git, patch, findutils, the-silver-searcher curl"
               "NOTE: You can use a combination of `find` and `the-silver-searcher` to find your way around a codebase")
 :args (list
        '(:name "command"
                :type string
                :description "The complete shell command to execute.")
        '(:name "working_dir"
                :type string
                :description "Optional: The directory in which to run the command. Defaults to the current directory if not specified."))
 :category "command"
 :include t)


(defun munen-gptel--trafilatura-fetch-url (url)
  "Fetch content from URL using trafilatura and return it as a string.
Tries the 'trafilatura' CLI first; falls back to 'python3 -m trafilatura' or 'python -m trafilatura'.
Returns a human-readable error string on failure."
  (with-temp-message (format "Fetching content from: %s" url)
    (let* ((exe (or (executable-find "trafilatura")
                    (executable-find "python3")
                    (executable-find "python")))
           (use-python (and exe
                            (member (file-name-nondirectory exe)
                                    '("python3" "python")))))
      (if (not exe)
          (format "Error: trafilatura not found. Install it (pip install trafilatura) and ensure it is on PATH.")
        (with-temp-buffer
          (let* ((args (append (when use-python (list "-m" "trafilatura"))
                               (list "--output-format=markdown"
                                     "--with-metadata"
                                     "-u" url)))
                 (status (apply #'call-process exe nil t nil args)))
            (if (and (integerp status) (zerop status))
                (buffer-string)
              (format "Error running trafilatura (exit %s). Ensure it is installed and on PATH. Output:\n%s"
                      status (buffer-string)))))))))


(defun munen-gptel--trafilatura-fetch-url-async (url callback &optional timeout-seconds)
  "Asynchronously fetch content from URL using trafilatura and call CALLBACK.
CALLBACK receives a single string: the page text or an error message.
Optional TIMEOUT-SECONDS (default 25) cancels long-running fetches."
  (let* ((exe (or (executable-find "trafilatura")
                  (executable-find "python3")
                  (executable-find "python")))
         (use-python (and exe (member (file-name-nondirectory exe) '("python3" "python")))))
    (if (not exe)
        (funcall callback "Error: trafilatura not found. Install it (pip install trafilatura) and ensure it is on PATH.")
      (let* ((args (append (when use-python (list "-m" "trafilatura"))
                           (list "--output-format=markdown"
                                 "--with-metadata"
                                 "-u" url)))
             (proc-name (format "trafilatura-%s" (md5 (or url ""))))
             (out-buf (generate-new-buffer (format "*trafilatura: %s*" url)))
             (done nil)
             (proc nil)
             (timer nil)
             (timeout (or timeout-seconds 25))
             (finish (lambda (text)
                       (unless done
                         (setq done t)
                         (when (timerp timer) (cancel-timer timer))
                         (when (buffer-live-p out-buf) (kill-buffer out-buf))
                         (
                          if (string-prefix-p "error" text 1)
                             (message "Fetching failed: %s" url)
                           (message "Fetching succeeded: %s"  url)
                          )
                         (funcall callback text)))))
        (condition-case e
            (progn
              (setq proc
                    (make-process
                     :name proc-name
                     :buffer out-buf
                     :command (cons exe args)
                     :noquery t
                     :stderr out-buf))
              (set-process-sentinel
               proc
               (lambda (p event)
                 (ignore event)
                 (unless done
                   (let ((exit (process-exit-status p)))
                     (with-current-buffer out-buf
                       (let ((text (buffer-string)))
                         (if (and (integerp exit) (zerop exit))
                             (funcall finish text)
                           (funcall finish (format "Error running trafilatura (exit %s). Output:\n%s" exit text)))))))))
              (setq timer
                    (run-at-time timeout nil
                                 (lambda ()
                                   (unless done
                                     (when (process-live-p proc)
                                       (delete-process proc))
                                     (funcall finish (format "Timeout after %ss fetching %s" timeout url))))))
              t)
          (error
           (funcall finish (format "Error starting trafilatura: %s" (error-message-string e)))))))))


;; (munen-gptel--trafilatura-fetch-url "https://www.theguardian.com/us-news/2025/aug/12/mayor-national-guard-washington-dc")


(gptel-make-tool
 :name "fetch_page"
 :function #'munen-gptel--trafilatura-fetch-url
 :description "Fetch content from a URL using trafilatura, which extracts main content and metadata while removing boilerplate, navigation and ads."
 :args (list '(:name "url"
                     :type string
                     :description "URL to fetch content from"))
 :category "web"
 )


(defun munen-gptel--edit-file (file-path &optional file-edits)
  "Edit FILE-PATH by applying FILE-EDITS using fuzzy string matching (non-interactive).

This function directly modifies the file on disk without user confirmation.
Each edit in FILE-EDITS should specify:
- :old_string - The string to find and replace (fuzzy matched)
- :new_string - The replacement string

EDITING RULES:
- The old_string is matched using fuzzy search throughout the file
- If multiple matches exist, only the first occurrence is replaced
- Include enough context in old_string to uniquely identify the location
- Whitespace differences are normalized during matching
- Keep edits focused on the specific change requested

Returns a success/failure message indicating whether edits were applied."
  (if (and file-path (not (string= file-path "")) file-edits)
      (with-current-buffer (get-buffer-create "*edit-file*")
        (erase-buffer)
        (insert-file-contents (expand-file-name file-path))
        (let ((inhibit-read-only t)
              (target-file-name (expand-file-name file-path))
              (edit-success nil)
              (applied-edits 0)
              (total-edits (length file-edits)))
          ;; Apply changes
          (dolist (file-edit (seq-into file-edits 'list))
            (when-let ((old-string (plist-get file-edit :old_string))
                       (new-string (plist-get file-edit :new_string))
                       (is-valid-old-string (not (string= old-string ""))))
              (goto-char (point-min))
              ;; Try exact match first
              (if (search-forward old-string nil t)
                  (progn
                    (replace-match new-string t t)
                    (setq edit-success t)
                    (setq applied-edits (1+ applied-edits)))
                ;; If exact match fails, try fuzzy match
                (goto-char (point-min))
                (when (munen-gptel--fuzzy-search old-string)
                  (replace-match new-string t t)
                  (setq edit-success t)
                  (setq applied-edits (1+ applied-edits))))))
          ;; Return result
          (if edit-success
              (progn
                (write-file target-file-name nil)
                (kill-buffer (current-buffer))
                (format "Successfully edited and saved %s (%d/%d edits applied)"
                        target-file-name applied-edits total-edits))
            (progn
              (kill-buffer (current-buffer))
              (format "Failed to apply edits to %s. No matching strings found." target-file-name)))))
    (format "Failed to edit %s (invalid path or no edits provided)." file-path)))

(defun munen-gptel--normalize-whitespace (string)
  "Normalize whitespace in STRING for fuzzy matching.
Converts multiple whitespace characters to single spaces and trims."
  (string-trim (replace-regexp-in-string "[ \t\n\r]+" " " string)))

(defun munen-gptel--fuzzy-search (target-string)
  "Search for TARGET-STRING using fuzzy matching.
Returns t if found and positions point after the match, nil otherwise.
Tries multiple matching strategies in order of preference."
  (let ((normalized-target (munen-gptel--normalize-whitespace target-string))
        (case-fold-search nil))
    (or
     ;; Strategy 1: Normalized whitespace matching
     (progn
       (goto-char (point-min))
       (let ((found nil))
         (while (and (not found) (not (eobp)))
           (let* ((line-start (line-beginning-position))
                  (line-end (line-end-position))
                  (line-text (buffer-substring-no-properties line-start line-end))
                  (normalized-line (munen-gptel--normalize-whitespace line-text)))
             (when (string-match-p (regexp-quote normalized-target) normalized-line)
               ;; Found a match, now find the actual position in the original text
               (goto-char line-start)
               (when (re-search-forward
                      (munen-gptel--create-fuzzy-regex target-string)
                      line-end t)
                 (setq found t)))
             (unless found (forward-line 1))))
         found))
     ;; Strategy 2: Case-insensitive search
     (progn
       (goto-char (point-min))
       (let ((case-fold-search t))
         (search-forward target-string nil t)))
     ;; Strategy 3: Regex-based flexible matching
     (progn
       (goto-char (point-min))
       (re-search-forward (munen-gptel--create-flexible-regex target-string) nil t)))))

(defun munen-gptel--create-fuzzy-regex (string)
  "Create a regex pattern for fuzzy matching STRING.
Allows flexible whitespace matching between words."
  (let ((escaped (regexp-quote string)))
    ;; Replace escaped whitespace with flexible whitespace pattern
    (replace-regexp-in-string
     "\\\\[ \t\n\r]+"
     "[ \t\n\r]+"
     escaped)))

(defun munen-gptel--create-flexible-regex (string)
  "Create a very flexible regex pattern for STRING.
Allows optional whitespace between characters and words."
  (let* ((chars (string-to-list string))
         (pattern-parts '()))
    (dolist (char chars)
      (cond
       ((memq char '(?\s ?\t ?\n ?\r))
        ;; For whitespace, allow flexible matching
        (push "[ \t\n\r]*" pattern-parts))
       (t
        ;; For regular characters, escape and add optional whitespace after
        (push (concat (regexp-quote (char-to-string char)) "[ \t\n\r]*")
              pattern-parts))))
    (concat "\\(" (string-join (reverse pattern-parts) "") "\\)")))

(gptel-make-tool
 :function #'munen-gptel--edit-file
 :name "edit_file"
 :description "Edits a file by applying fuzzy string matching changes. This is a primary method for file modification.

If this tool fails, try 'apply_diff'. As a last resort, use 'replace_file_contents'.
This tool modifies the file directly on disk without user confirmation.

Each edit requires an old string to find (fuzzy matched) and a new string to replace it with."
 :args (list '(:name "file-path"
                     :type string
                     :description "The full path of the file to edit.")
             '(:name "file-edits"
                     :type array
                     :items (:type object
                                   :properties
                                   (:old_string
                                    (:type string :description "The exact string to be replaced (will be fuzzy matched if exact match fails).")
                                    :new_string
                                    (:type string :description "The new string to replace old_string.")))
                     :description "A list of edits to apply to the file. Each edit must contain old_string and new_string."))
 :category "filesystem"
 :include t)


(defun munen-gptel--edit-file-interactive (file-path file-edits)
  "Edit FILE-PATH by applying FILE-EDITS with interactive review using ediff.

This function applies the specified edits to the file and then opens an ediff
session to review changes before saving. Each edit in FILE-EDITS should specify:
- :line_number - The 1-based line number where the edit occurs
- :old_string - The exact string to find and replace
- :new_string - The replacement string

EDITING RULES:
- The old_string must EXACTLY MATCH the existing file content at the specified line
- Include enough context in old_string to uniquely identify the location
- Keep edits concise and focused on the specific change requested
- Do not include long runs of unchanged lines

After applying edits, opens ediff to compare original vs modified versions,
allowing user to review and selectively apply changes before saving.
Returns a success/failure message indicating whether edits were applied."
  (if (and file-path (not (string= file-path "")) file-edits)
      (with-current-buffer (get-buffer-create "*edit-file*")
        (erase-buffer)
        (insert-file-contents (expand-file-name file-path))
        (let ((inhibit-read-only t)
              (case-fold-search nil)
              (file-name (expand-file-name file-path))
              (edit-success nil))
          ;; apply changes
          (dolist (file-edit (seq-into file-edits 'list))
            (when-let ((line-number (plist-get file-edit :line_number))
                       (old-string (plist-get file-edit :old_string))
                       (new-string (plist-get file-edit :new_string))
                       (is-valid-old-string (not (string= old-string ""))))
              (goto-char (point-min))
              (forward-line (1- line-number))
              (when (search-forward old-string nil t)
                (replace-match new-string t t)
                (setq edit-success t))))
          ;; return result to gptel
          (if edit-success
              (progn
                ;; show diffs
                (ediff-buffers (find-file-noselect file-name) (current-buffer))
                (format "Successfully edited %s" file-name))
            (format "Failed to edited %s" file-name))))
    (format "Failed to edited %s" file-path)))

(gptel-make-tool
   :function #'munen-gptel--edit-file-interactive
   :name "edit_file_interactive"
   :description "Edit a file interactively by applying a list of edits with review via ediff.

This tool applies the specified edits and opens an ediff session for review.
Each edit specifies a line number, old string to find, and new string replacement.

After applying edits, ediff opens to compare original vs modified versions,
allowing interactive review and selective application of changes before saving.
This provides a safe way to review changes before committing them to disk."
   :args (list '(:name "file-path"
                       :type string
                       :description "The full path of the file to edit")
               '(:name "file-edits"
                       :type array
                       :items (:type object
                                     :properties
                                     (:line_number
                                      (:type integer :description "The line number of the file where edit starts.")
                                      :old_string
                                      (:type string :description "The old-string to be replaced.")
                                      :new_string
                                      (:type string :description "The new-string to replace old-string.")))
                       :description "The list of edits to apply on the file"))
   :category "emacs")

(gptel-make-tool
   :name "apply_diff"
   :description (concat
                 "Applies a diff (patch) to a file. This is a primary method for file modification. "
                 "If this tool fails, try 'edit_file'. As a last resort, use 'replace_file_contents'. "
                 "The diff must be in the unified format ('diff -u'). "
                 "Ensure file paths in the diff (e.g., '--- a/file', '+++ b/file') match the 'file_path' argument and 'patch_options'. "
                 "Common 'patch_options' include: '' (for exact/relative paths), "
                 "'-p0' (if diff paths are full), '-p1' (to strip one leading directory). "
                 "Default options are '-N' (ignore already applied patches).")
   :args (list
          '(:name "file_path"
                  :type string
                  :description "The path to the file that needs to be patched.")
          '(:name "diff_content"
                  :type string
                  :description "The diff content in unified format (e.g., from 'diff -u').")
          '(:name "patch_options"
                  :type string
                  :optional t
                  :description "Optional: Additional options for the 'patch' command (e.g., '-p1', '-p0', '-R'). Defaults to '-N'. Prepend other options if needed, e.g., '-p1 -N'.")
          '(:name "working_dir"
                  :type string
                  :optional t
                  :description "Optional: The directory in which to interpret file_path and run patch. Defaults to the current buffer's directory if not specified."))
   :category "filesystem"
   :function
   (lambda (file_path diff_content &optional patch_options working_dir)
     (let ((original-default-directory default-directory)
           (user-patch-options (if (and patch_options (not (string-empty-p patch_options)))
                                   (split-string patch_options " " t)
                                 nil))
           ;; Combine user options with -N, ensuring -N is there.
           ;; If user provides -N or --forward, use their version. Otherwise, add -N.
           (base-options '("-N"))
           (effective-patch-options '()))

       (if user-patch-options
           (if (or (member "-N" user-patch-options) (member "--forward" user-patch-options))
               (setq effective-patch-options user-patch-options)
             (setq effective-patch-options (append user-patch-options base-options)))
         (setq effective-patch-options base-options))

       (let* ((out-buf-name (generate-new-buffer-name "*patch-stdout*"))
              (err-buf-name (generate-new-buffer-name "*patch-stderr*"))
              (target-file nil)
              (exit-status -1) ; Initialize to a known non-zero value
              (result-output "")
              (result-error ""))
         (unwind-protect
             (progn
               (when (and working_dir (not (string-empty-p working_dir)))
                 (setq default-directory (expand-file-name working_dir)))

               (setq target-file (expand-file-name file_path))

               (unless (file-exists-p target-file)
                 ;; Use error to signal failure, which gptel should catch.
                 (error "File to patch does not exist: %s" target-file))

               (with-temp-message (format "Applying diff to: `%s` with options: %s" target-file effective-patch-options)
                 (with-temp-buffer
                   (insert diff_content)
                   (unless (eq (char-before (point-max)) ?\n)
                     (goto-char (point-max))
                     (insert "\n"))

                   ;; Pass buffer *names* to call-process-region
                   (setq exit-status (apply #'call-process-region
                                            (point-min) (point-max)
                                            "patch"       ; Command
                                            nil           ; delete region (no)
                                            (list out-buf-name err-buf-name) ; stdout/stderr buffer names
                                            nil           ; display (no)
                                            (append effective-patch-options (list target-file))))))

               ;; Retrieve content from buffers using their names
               (let ((stdout-buf (get-buffer out-buf-name))
                     (stderr-buf (get-buffer err-buf-name)))
                 (when stdout-buf
                   (with-current-buffer stdout-buf
                     (setq result-output (buffer-string))))
                 (when stderr-buf
                   (with-current-buffer stderr-buf
                     (setq result-error (buffer-string)))))

               (if (= exit-status 0)
                   (format "Diff successfully applied to %s.\nPatch command options: %s\nPatch STDOUT:\n%s\nPatch STDERR:\n%s"
                           target-file effective-patch-options result-output result-error)
                 ;; Signal an Elisp error, which gptel will catch and display.
                 ;; The arguments to 'error' become the error message.
                 (error "Failed to apply diff to %s (exit status %s).\nPatch command options: %s\nPatch STDOUT:\n%s\nPatch STDERR:\n%s"
                        target-file exit-status effective-patch-options result-output result-error)))
           ;; Cleanup clause of unwind-protect
           (setq default-directory original-default-directory)
           (let ((stdout-buf-obj (get-buffer out-buf-name))
                 (stderr-buf-obj (get-buffer err-buf-name)))
             (when (buffer-live-p stdout-buf-obj) (kill-buffer stdout-buf-obj))
             (when (buffer-live-p stderr-buf-obj) (kill-buffer stderr-buf-obj)))))))
   :include t)


(defun gptel--normalize-max-depth (max-depth)
  "Convert MAX-DEPTH to a number, handling strings, numbers, or nil.
Returns 3 as default if MAX-DEPTH is nil or invalid."
  (cond
   ;; Already a number
   ((numberp max-depth) max-depth)
   ;; String that can be converted to number
   ((and (stringp max-depth)
         (not (string-empty-p max-depth))
         (string-match-p "^[0-9]+$" max-depth))
    (string-to-number max-depth))
   ;; Default case (nil, empty string, or invalid input)
   (t 3)))

(defun gptel--parse-gitignore (gitignore-file)
  "Parse a .gitignore file and return a list of patterns."
  (when (file-exists-p gitignore-file)
    (with-temp-buffer
      (insert-file-contents gitignore-file)
      (let ((patterns '()))
        (goto-char (point-min))
        (while (not (eobp))
          (let ((line (string-trim (buffer-substring-no-properties
                                   (line-beginning-position)
                                   (line-end-position)))))
            (unless (or (string-empty-p line) (string-prefix-p "#" line))
              (push line patterns)))
          (forward-line 1))
        (nreverse patterns)))))

(defun gptel--should-ignore-p (file-path gitignore-patterns)
  "Check if FILE-PATH should be ignored based on GITIGNORE-PATTERNS."
  (let ((relative-path (file-name-nondirectory file-path)))
    (cl-some (lambda (pattern)
               (cond
                ;; Directory pattern (ends with /)
                ((string-suffix-p "/" pattern)
                 (and (file-directory-p file-path)
                      (string-match-p (concat "^" (regexp-quote (string-remove-suffix "/" pattern)) "$")
                                     relative-path)))
                ;; Exact match
                ((not (string-match-p "[*?]" pattern))
                 (string= relative-path pattern))
                ;; Wildcard pattern
                (t
                 (string-match-p (concat "^" (replace-regexp-in-string "\\*" ".*" (regexp-quote pattern)) "$")
                                relative-path))))
             gitignore-patterns)))

(defun gptel--collect-gitignore-patterns (directory)
  "Collect all .gitignore patterns from DIRECTORY and parent directories."
  (let ((patterns '())
        (current-dir (expand-file-name directory)))
    (while (and current-dir (not (string= current-dir "/")))
      (let ((gitignore-file (expand-file-name ".gitignore" current-dir)))
        (when (file-exists-p gitignore-file)
          (setq patterns (append (gptel--parse-gitignore gitignore-file) patterns))))
      (let ((parent (file-name-directory (directory-file-name current-dir))))
        (setq current-dir (if (string= parent current-dir) nil parent))))
    ;; Add common ignore patterns
    (append patterns '(".git" ".DS_Store" "node_modules" "__pycache__" "*.pyc"))))

(defun gptel--directory-tree (directory max-depth show-hidden)
  "Generate a tree representation of DIRECTORY."
  (let ((expanded-dir (expand-file-name directory)))
    (concat (abbreviate-file-name expanded-dir) "\n"
            (gptel--directory-tree-recursive expanded-dir max-depth 0 show-hidden ""))))

(defun gptel--directory-tree-recursive (directory max-depth current-depth show-hidden prefix)
  "Internal recursive function for generating directory tree."
  (if (>= current-depth max-depth)
      ""
    (let* ((expanded-dir (expand-file-name directory))
           (gitignore-patterns (gptel--collect-gitignore-patterns expanded-dir))
           (entries (condition-case nil
                        (directory-files expanded-dir t "^[^.]" t)
                      (error nil)))
           (filtered-entries '())
           (result ""))

      ;; Add hidden files if requested
      (when show-hidden
        (setq entries (append entries
                             (directory-files expanded-dir t "^\\.[^.]" t))))

      ;; Filter out ignored files
      (dolist (entry entries)
        (unless (gptel--should-ignore-p entry gitignore-patterns)
          (push entry filtered-entries)))

      (setq filtered-entries (sort filtered-entries #'string<))

      ;; Generate tree output
      (let ((total (length filtered-entries)))
        (dotimes (i total)
          (let* ((entry (nth i filtered-entries))
                 (basename (file-name-nondirectory entry))
                 (is-last (= i (1- total)))
                 (is-dir (file-directory-p entry))
                 (connector (if is-last "└── " "├── "))
                 (new-prefix (concat prefix (if is-last "    " "│   "))))

            (setq result (concat result prefix connector basename
                                (if is-dir "/" "") "\n"))

            ;; Recurse into directories
            (when (and is-dir (< (1+ current-depth) max-depth))
              (setq result (concat result
                                  (gptel--directory-tree-recursive entry max-depth
                                                                  (1+ current-depth) show-hidden
                                                                  new-prefix)))))))
      result)))

(gptel-make-tool
 :function (lambda (directory &optional max-depth show-hidden)
             (with-temp-message (format "Listing directory tree: %s" directory)
               (condition-case err
                   (let ((max-depth (gptel--normalize-max-depth max-depth))
                         (show-hidden (and show-hidden (not (string= show-hidden "")))))
                     (gptel--directory-tree directory max-depth show-hidden))
                 (error (format "Error listing directory: %s - %s" directory (error-message-string err))))))
 :name "list_directory"
 :description "List the contents of a directory in a tree format, respecting .gitignore files"
 :args (list '(:name "directory"
                     :type string
                     :description "The path to the directory to list")
             '(:name "max-depth"
                     :type string
                     :description "Optional: Maximum depth to traverse (default: 3)")
             '(:name "show-hidden"
                     :type string
                     :description "Optional: Show hidden files/directories (default: false)"))
 :category "filesystem"
 :include t)

(gptel-make-tool
   :function (lambda (filepath)
               (let ((ignore-patterns (when (boundp 'gptel-read-file-ignore-patterns)
                                       gptel-read-file-ignore-patterns))
                     (expanded-path (expand-file-name filepath)))
                 (if (and ignore-patterns
                          (cl-some (lambda (pattern)
                                    (string-match-p pattern expanded-path))
                                  ignore-patterns))
                     (format "Access denied: File %s matches ignore patterns" filepath)
                   (with-temp-message (format "Reading file: %s" filepath)
                     (condition-case err
                         (with-temp-buffer
                           (insert-file-contents expanded-path)
                           (buffer-string))
                       (error (format "Error reading file: %s - %s" filepath (error-message-string err))))))))
   :name "read_file"
   :description "Read and display the contents of a file. Note: If a file is already included in the current gptel context (conversation), there is no need to read it again as the context is always current."
   :args (list '(:name "filepath"
                       :type string
                       :description "Path to the file to read. Supports relative paths and ~. Only use this tool for files not already in the conversation context."))
   :category "filesystem"
   :include t)


(gptel-make-tool
 :name "file_lint_with_flycheck"
 :description (concat
               "Lints the specified file using Flycheck in Emacs, returning any errors or warnings "
               "(or a 'no errors found' message).\n\n"
               "**LLM Workflow for Code Modification:**\n"
               "1.  **Baseline Check:** Run this tool on the file *before* generating a patch or "
               "other code modifications. This helps understand the existing lint status and "
               "avoid re-introducing pre-existing issues or being blamed for them.\n"
               "2.  **Verification Check:** After your changes have been applied to the file "
               "(e.g., via a patch), run this tool again.\n"
               "3.  **Self-Correction:** Compare the lint output from step 2 (after your changes) "
               "with the baseline from step 1 (before your changes). If your modifications "
               "introduced *new* lint errors, you are expected to refactor your code to fix "
               "these new errors. Re-run this lint tool to confirm your fixes before "
               "considering the task complete. Focus on fixing errors introduced by your changes.")
 :args (list '(:name "filename"
                     :type "string"
                     :description "The path (relative or absolute) to the file to be checked."))
 :category "emacs"
 :include t
 :function
 (lambda (filename)
   (unless (require 'flycheck nil t)
     (error "Flycheck package is not available."))
   (unless (stringp filename)
     (error "Filename argument must be a string."))
   (let ((original-filename filename))
     (condition-case err
         (let* ((absolute-filename (expand-file-name filename))
                (buffer-object (get-file-buffer absolute-filename))
                (temp-buffer-created (not buffer-object))
                (buffer (or buffer-object
                            (progn
                              (unless (file-exists-p absolute-filename)
                                (error "File not found: %s (expanded from %s)" absolute-filename original-filename))
                              (find-file-noselect absolute-filename))))
                (flycheck-was-on-in-buffer nil)
                (errors-string "Error: Failed to collect Flycheck results.")) ; Default error

           (unless (buffer-live-p buffer)
             (error "Could not open or find buffer for file: %s" absolute-filename))

           (with-temp-message (format "Linting %s with Flycheck..." absolute-filename)
             (unwind-protect
                 (progn ;; Main work block
                   (with-current-buffer buffer
                     (setq flycheck-was-on-in-buffer flycheck-mode)
                     (unless flycheck-mode
                       (flycheck-mode 1)
                       (unless flycheck-mode
                         (error "Failed to enable Flycheck mode in buffer %s." (buffer-name))))

                     (flycheck-buffer) ;; Request a syntax check

                     (let ((timeout 15.0)
                           (start-time (float-time)))
                       (while (and (flycheck-running-p)
                                   (< (- (float-time) start-time) timeout))
                         (sit-for 0.1 t))) ;; Wait, process events

                     ;; Check reason for loop termination & collect errors
                     (if (flycheck-running-p)
                         (error "Flycheck timed out after %.0f seconds for %s" timeout absolute-filename)
                       ;; Flycheck is no longer running, collect errors
                       (progn
                         ;; flycheck-current-errors is a VARIABLE
                         (let ((current-errors flycheck-current-errors))
                           (if current-errors
                               (setq errors-string
                                     (format "Flycheck results for %s:\n%s"
                                             absolute-filename
                                             (mapconcat
                                              (lambda (err-obj) ;; err-obj is a flycheck-error struct
                                                (format "- %S at L%s%s (%s): %s"
                                                        (flycheck-error-level err-obj)
                                                        (flycheck-error-line err-obj)
                                                        (if-let ((col (flycheck-error-column err-obj))) ; CORRECTED
                                                            (format ":C%s" col) "")
                                                        (flycheck-error-checker err-obj)
                                                        (flycheck-error-message err-obj)))
                                              current-errors "\n")))
                             (setq errors-string (format "No Flycheck errors found in %s." absolute-filename)))))))
                   ;; errors-string is now set based on Flycheck output
                   ) ;; End of with-current-buffer
                 ;; Cleanup block for unwind-protect
                 (progn
                   (when (buffer-live-p buffer)
                     (with-current-buffer buffer
                       (when (and flycheck-mode (not flycheck-was-on-in-buffer))
                         (flycheck-mode 0))))
                   (when (and temp-buffer-created (buffer-live-p buffer))
                     (kill-buffer buffer)))))
           errors-string)
       (error (format "Error linting file %s: %s"
                      original-filename (error-message-string err)))))))

