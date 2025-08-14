
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
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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
  ;; GNU Emacs app (“NS” build):
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

;; make preview in latex switch to svg for scaling
(after! preview
  (setq preview-image-type 'png
        preview-scale-function 4
        preview-pdf-color-adjust-method nil
        preview-scale 4))

;; using xenops to preview latex
(add-hook 'latex-mode-hook #'xenops-mode)
(add-hook 'LaTeX-mode-hook #'xenops-mode)


;; setting up gptel

(use-package! gptel
  :init
  ;; Optional: pick a default model/backend later if you want.
  :config
  ;; You can omit this; gptel will use auth-source by default.
  (setq gptel-api-key #'gptel-api-key-from-auth-source)

  (map! :leader
        (          ;; no label → keeps Doom’s default name
         :desc "gptel chat" "o g" #'gptel
         :desc "gptel send" "o s" #'gptel-send
         :desc "gptel menu" "o m" #'gptel-menu)))


;; gptel context area highlight
;;
(custom-set-faces
 '(gptel-context-highlight-face ((t (:background "gray9")))))


;; Place the panels using Doom’s popup system
(set-popup-rule! "^\\*Backtrace\\*$" :side 'right  :size 0.45 :select t :ttl nil)





;; ---------------------------------------------
;; gptel TOOLS

;; --- web site retrieval

;; --- User-provided code for HTTP header parsing ---
;; This section is the code you provided, which is a solid foundation.
(require 'url)
(require 'url-http)
(require 'shr) ;; Needed for parsing HTML to text

(defgroup gptel-web-search-tools-debug nil
  "Debug helpers for gptel web tools."
  :group 'gptel)


(defcustom my-gptel-web-debug nil
  "When non-nil, emit detailed messages while splitting headers/body."
  :type 'boolean
  :group 'gptel-web-search-tools-debug)

(defcustom my-gptel-web-log-function #'message
  "Function used for debug logs. Set to `ignore' to silence."
  :type 'function
  :group 'gptel-web-search-tools-debug)

(defcustom my-gptel-web-preview-chars 160
  "How many characters to show around the split point in logs."
  :type 'integer
  :group 'gptel-web-search-tools-debug)

(defun my-gptel-web--log (fmt &rest args)
  "Log a message if debugging is enabled."
  (when my-gptel-web-debug
    (funcall my-gptel-web-log-function (apply #'format (concat "[gptel-web] " fmt) args))))

(defun my-gptel-web--safe-preview (beg end)
  "Return a short, *literal* preview string for region BEG..END for logs.
We avoid `replace-regexp-in-string` backslash semantics by using
`string-replace` (literal) to visualize newlines and tabs."
  (let* ((len (max 0 (- end beg)))
         (n (min len my-gptel-web-preview-chars))
         (s (buffer-substring-no-properties beg (+ beg n))))
    (setq s (string-replace "\n" "\\n" s))
    (setq s (string-replace "\t" "\\t" s))
    s))

(defun my-url-http-body-start (&optional log)
  "Return buffer position of the start of the HTTP body.
When LOG is non-nil (or `my-gptel-web-debug' is non-nil), emit debug info
indicating whether we used `url-http-end-of-headers' or the CRLF fallback."
  (let* ((emit (or log my-gptel-web-debug))
         (hdrvar (and (boundp 'url-http-end-of-headers) url-http-end-of-headers))
         (status (and (boundp 'url-http-response-status) url-http-response-status))
         (ver    (and (boundp 'url-http-version) url-http-version))
         (found  (and (integerp hdrvar) hdrvar)))
    (when emit
      (my-gptel-web--log "HTTP status=%s version=%s" status ver)
      (my-gptel-web--log "url-http-end-of-headers=%S (type %s)"
                         url-http-end-of-headers (type-of url-http-end-of-headers)))
    (unless (and found (> found (point-min)) (< found (point-max)))
      ;; Fallback: tolerant CRLF/CR boundary search
      (save-excursion
        (goto-char (point-min))
        (when (re-search-forward "\r?\n\r?\n" nil t)
          (setq found (point))
          (when emit
            (my-gptel-web--log "Fallback boundary used at %d" found)
            (let ((ph (max (point-min) (- (match-beginning 0) 80)))
                  (pt (min (point-max) (+ (match-end 0) 80))))
              (my-gptel-web--log "Around boundary: %s…"
                                 (my-gptel-web--safe-preview ph pt)))))))
    (unless found
      (when emit
        (my-gptel-web--log "ERROR: Could not determine end of headers"))
      (error "Could not determine end of HTTP headers"))
    (when emit
      (let ((ph (max (point-min) (- found 120)))
            (pt (min (point-max) (+ found 40))))
        (my-gptel-web--log "Header tail preview: %s…"
                           (my-gptel-web--safe-preview ph found))
        (my-gptel-web--log "Body head preview: %s…"
                           (my-gptel-web--safe-preview found pt)))
      (when (and (boundp 'url-http-response-status)
                 (memq url-http-response-status '(301 302 303 307 308)))
        (save-excursion
          (goto-char (point-min))
          (when (re-search-forward "^Location: *\(.*\)$" found t)
            (my-gptel-web--log "Redirect -> %s"
                               (buffer-substring-no-properties (match-beginning 1) (match-end 1)))))))
    found))

(defun my-gptel-web-debug-probe (url)
  "Fetch URL synchronously and log how the header/body split was determined."
  (interactive "sURL: ")
  (let ((my-gptel-web-debug t)
        (url-request-extra-headers '(("User-Agent" . "Emacs (gptel debug)")
                                     ("Accept-Language" . "en"))))
    (let ((buf (url-retrieve-synchronously url t t 15)))
      (unless buf (user-error "Fetch failed: %s" url))
      (unwind-protect
          (with-current-buffer buf
            (let ((pos (my-url-http-body-start t)))
              (my-gptel-web--log "Final body start position: %d" pos)
              (message "Body starts at %d for %s" pos url)))
        (kill-buffer buf)))))


;; --- NEW: Core function to get web content as text ---

(defun my-gptel-web-get-content (url)
  "Fetch URL and return its textual content by parsing the HTML.
This function retrieves the content from a URL, finds the body of the
HTTP response, and then uses the `shr` library to render the HTML
into plain text, which is suitable for an LLM."
  (let ((url-request-extra-headers '(("User-Agent" . "Mozilla/5.0 (compatible; Emacs gptel-tool)")
                                     ("Accept" . "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"))))
    (let ((buffer (url-retrieve-synchronously url)))
      (unless buffer
        (error "Failed to retrieve URL: %s" url))
      (unwind-protect
          (with-current-buffer buffer
            (let* ((body-start (my-url-http-body-start))
                   (html-content (buffer-substring-no-properties body-start (point-max))))
              ;; Use a temporary buffer to render HTML to text, then return the text.
              (with-temp-buffer
                (let ((inhibit-read-only t))
                  (insert html-content)
                  (goto-char (point-min))
                  (shr-render-region (point-min) (point-max))
                  (buffer-string)))))
        (kill-buffer buffer)))))


;; --- NEW: gptel Tool to Get Web Content ---

(gptel-make-tool
 'my-gptel-tool-get-web-content
 :name "get_web_content"
 :description "Retrieves the clean text content of a web page given its URL. Returns the full text, stripped of HTML."
 :fn (lambda (url)
       (message "Gptel tool: fetching %s" url)
       ;; Use condition-case to gracefully handle and report errors to the LLM.
       (condition-case err
           (my-gptel-web-get-content url)
         (error (format "Error retrieving or parsing URL: %s" (error-message-string err)))))
 :args-schema
 (gptel-fun-schema
  ((url "The full URL of the web page to retrieve." t string))))


;; --- NEW: Interactive Command to Summarize a URL ---

(defun my-gptel-summarize-url (url)
  "Fetch content from a URL and ask gptel to summarize it.
This is a user-facing command. It gets the web content using the
function above and then creates a new prompt in the `*gptel*` buffer
to summarize it."
  (interactive "sURL to summarize: ")
  (let ((content (condition-case err
                     (my-gptel-web-get-content url)
                   (error (format "Error: Could not retrieve content from %s. %s" url (error-message-string err))))))
    (if (stringp content)
        (if (> (length content) 20)
            (progn
              (gptel-show) ;; Make the gptel buffer visible
              (with-current-buffer (get-buffer-create "*gptel*")
                (goto-char (point-max))
                ;; Ensure we are in a prompt-receptive state
                (unless (looking-back gptel-prompt-prefix-regexp nil)
                  (insert "\n"))
                (insert
                 (format
                  "#+BEGIN_PROMPT\nSummarize the key points of the web page %s. The content is provided below:\n\n\"\"\"\n%s\n\"\"\"\n#+END_PROMPT\n"
                  url
                  ;; Truncate very long pages to not exceed token limits.
                  (if (> (length content) 15000)
                      (substring content 0 15000)
                    content)))
                (message "Sending content of %s to gptel for summary." url)
                (gptel-send)))
          (message "Content from %s is too short or empty to summarize." url))
      (message "%s" content)))) ; Display the error message if content is not a string


;; --- NEW: Activation ---
;; Add the new tool to the list of tools gptel can use.

(setq-default gptel-use-tools 'allow)                                                                                                    ;;
(add-to-list 'gptel-tools 'my-gptel-tool-get-web-content)

;; You can also bind the interactive summary command to a key for easy access.
;; For example, to bind it to "C-c g s":
;; (define-key global-map (kbd "C-c g s") #'my-gptel-summarize-url)

(message "gptel web tools loaded.")




;; preparing for search




;;;  BUG WEB SEARCH TO BE FIXED


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'gptel)                                                                                                                           ;;
;; (require 'url)                                                                                                                             ;;
;; (require 'url-parse)                                                                                                                       ;;
;; (require 'url-http)                                                                                                                        ;;
;; (require 'dom)                                                                                                                             ;;
;; (require 'shr)                                                                                                                             ;;
;; (require 'cl-lib)                                                                                                                          ;;
;; (require 'subr-x)                                                                                                                          ;;
;;                                                                                                                                            ;;
;; (defgroup gptel-web-search-tools nil                                                                                                       ;;
;;   "Web search + readable fetch helpers for gptel."                                                                                         ;;
;;   :group 'gptel)                                                                                                                           ;;
;;                                                                                                                                            ;;
;; (defcustom my-gptel-web-timeout 15                                                                                                         ;;
;;   "Timeout (seconds) for synchronous HTTP requests."                                                                                       ;;
;;   :type 'integer :group 'gptel-web-search-tools)                                                                                           ;;
;;                                                                                                                                            ;;
;; (defcustom my-gptel-web-user-agent                                                                                                         ;;
;;   (format "Emacs/%s (gptel-web-search-tools)" emacs-version)                                                                               ;;
;;   "User-Agent header used for searches and fetches."                                                                                       ;;
;;   :type 'string :group 'gptel-web-search-tools)                                                                                            ;;
;;                                                                                                                                            ;;
;; (defcustom my-gptel-web-max-context-chars 6000                                                                                             ;;
;;   "Total context chars to return from fetched pages."                                                                                      ;;
;;   :type 'integer :group 'gptel-web-search-tools)                                                                                           ;;
;;                                                                                                                                            ;;
;; (defcustom my-gptel-web-per-page-chars 1200                                                                                                ;;
;;   "Per-page context char limit when including page text."                                                                                  ;;
;;   :type 'integer :group 'gptel-web-search-tools)                                                                                           ;;
;;                                                                                                                                            ;;
;; ;; ---------------------------------------------------------------------------                                                             ;;
;; ;; Robust header/body split for url.el buffers                                                                                             ;;
;; ;; ---------------------------------------------------------------------------                                                             ;;
;;                                                                                                                                            ;;
;; (defun my-url-http-body-start ()                                                                                                           ;;
;;   "Return buffer position of the start of the HTTP body.                                                                                   ;;
;; Tries, in order:                                                                                                                           ;;
;; 1. `url-http-end-of-headers' if present and sane;                                                                                          ;;
;; 2. The end of the last HTTP header block when a 100-Continue preface is present;                                                           ;;
;; 3. The first blank line (CRLF/CR/LF tolerant);                                                                                             ;;
;; 4. The first likely HTML tag (<html, <!DOCTYPE, <head, <body).                                                                             ;;
;;                                                                                                                                            ;;
;; Signals an error if nothing plausible is found. Must be called inside                                                                      ;;
;; `with-current-buffer' of a URL retrieval buffer."                                                                                          ;;
;;   (let* ((min (point-min))                                                                                                                 ;;
;;          (max (point-max))                                                                                                                 ;;
;;          pos)                                                                                                                              ;;
;;     ;; 1) Prefer url.el's computed boundary                                                                                                ;;
;;     (setq pos (and (boundp 'url-http-end-of-headers)                                                                                       ;;
;;                    (integerp url-http-end-of-headers)                                                                                      ;;
;;                    (> url-http-end-of-headers min)                                                                                         ;;
;;                    (< url-http-end-of-headers max)                                                                                         ;;
;;                    url-http-end-of-headers))                                                                                               ;;
;;     ;; 2) Handle possible 100-Continue preface (two header blocks)                                                                         ;;
;;     (unless pos                                                                                                                            ;;
;;       (save-excursion                                                                                                                      ;;
;;         (goto-char min)                                                                                                                    ;;
;;         (cond                                                                                                                              ;;
;;          ((looking-at "HTTP/[0-9]\.[0-9] 100 ")                                                                                            ;;
;;           (when (re-search-forward "?                                                                                                    ;;
;; ?                                                                                                                                        ;;
;; " nil t)                                                                                                                                   ;;
;;             (when (re-search-forward "?                                                                                                  ;;
;; ?                                                                                                                                        ;;
;; " nil t)                                                                                                                                   ;;
;;               (setq pos (point)))))                                                                                                        ;;
;;          (t                                                                                                                                ;;
;;           (when (re-search-forward "?                                                                                                    ;;
;; ?                                                                                                                                        ;;
;; " nil t)                                                                                                                                   ;;
;;             (setq pos (point)))))))                                                                                                        ;;
;;     ;; 3) As a last resort, jump to the first likely HTML tag                                                                              ;;
;;     (unless pos                                                                                                                            ;;
;;       (save-excursion                                                                                                                      ;;
;;         (goto-char min)                                                                                                                    ;;
;;         (when (re-search-forward "<\(!DOCTYPE\|html\|head\|body\)\b" nil t)                                                                ;;
;;           (setq pos (match-beginning 0)))))                                                                                                ;;
;;     (or pos (error "Could not determine end of HTTP headers")))                                                                            ;;
;;                                                                                                                                            ;;
;; ;; ---------------------------------------------------------------------------                                                             ;;
;; ;; Readable fetcher (HTML -> text via shr)                                                                                                 ;;
;; ;; ---------------------------------------------------------------------------                                                             ;;
;;                                                                                                                                            ;;
;; (defun my-gptel-fetch-readably (url &optional maxchars)                                                                                    ;;
;;   "Fetch URL and return readable text via shr."                                                                                            ;;
;;   (let* ((url-request-extra-headers `(("User-Agent" . ,my-gptel-web-user-agent)                                                            ;;
;;                                       ("Accept-Language" . "en, *;q=0.5")))                                                                ;;
;;          (buf (url-retrieve-synchronously url t t my-gptel-web-timeout)))                                                                  ;;
;;     (unless buf (error "Fetch failed: %s" url))                                                                                            ;;
;;     (unwind-protect                                                                                                                        ;;
;;         (with-current-buffer buf                                                                                                           ;;
;;           (goto-char (my-url-http-body-start))                                                                                             ;;
;;           (let* ((dom (libxml-parse-html-region (point) (point-max)))                                                                      ;;
;;                  (txt (with-temp-buffer                                                                                                    ;;
;;                         (let ((shr-width 1000000)) ; avoid hard line-wraps                                                                 ;;
;;                           (shr-insert-document dom))                                                                                       ;;
;;                         (buffer-string))))                                                                                                 ;;
;;             (setq txt (replace-regexp-in-string "\n\n\n+" "\n\n" txt))                                                                     ;;
;;             (if (and maxchars (> (length txt) maxchars))                                                                                   ;;
;;                 (concat (substring txt 0 maxchars) " …")                                                                                   ;;
;;               txt)))                                                                                                                       ;;
;;       (kill-buffer buf))))                                                                                                                 ;;
;;                                                                                                                                            ;;
;; ;; ---------------------------------------------------------------------------                                                             ;;
;; ;; Search helpers                                                                                                                          ;;
;; ;; ---------------------------------------------------------------------------                                                             ;;
;;                                                                                                                                            ;;
;; (defun my--normalize-google-url (href)                                                                                                     ;;
;;   "Turn Google /url?q=… links into direct URLs; otherwise return HREF."                                                                    ;;
;;   (if (and href (string-match "^/url\\?q=\\([^&]+\\)" href))                                                                               ;;
;;                                                                                                                                            ;;
;; (defun my--ddg-normalize-href (href)                                                                                                       ;;
;;   "Return an absolute external URL from a DuckDuckGo redirect HREF, or HREF."                                                              ;;
;;   (cond                                                                                                                                    ;;
;;    ;; Relative redirect, e.g. /l/?kh=-1&uddg=<ENCODED>                                                                                     ;;
;;    ((and (stringp href) (string-prefix-p "/l/?" href))                                                                                     ;;
;;     (let* ((q (ignore-errors (cadr (split-string href "?" t))))                                                                            ;;
;;            (params (and q (url-parse-query-string q)))                                                                                     ;;
;;            (uddg (car (alist-get "uddg" params nil nil #'string-equal))))                                                                  ;;
;;       (when uddg                                                                                                                           ;;
;;         (condition-case _                                                                                                                  ;;
;;             (setq uddg (url-unhex-string (url-unhex-string uddg)))                                                                         ;;
;;           (error (setq uddg (url-unhex-string uddg))))                                                                                     ;;
;;         (when (string-match-p "^https?://" uddg)                                                                                           ;;
;;           (setq href uddg))))                                                                                                              ;;
;;     href)                                                                                                                                  ;;
;;    ;; Absolute DDG redirect                                                                                                                ;;
;;    ((and (stringp href) (string-match "^https?://[^/]*duckduckgo\.com/l/\?\(.*\)$" href))                                                  ;;
;;     (let* ((q (match-string 1 href))                                                                                                       ;;
;;            (params (and q (url-parse-query-string q)))                                                                                     ;;
;;            (uddg (car (alist-get "uddg" params nil nil #'string-equal))))                                                                  ;;
;;       (when uddg                                                                                                                           ;;
;;         (condition-case _                                                                                                                  ;;
;;             (setq uddg (url-unhex-string (url-unhex-string uddg)))                                                                         ;;
;;           (error (setq uddg (url-unhex-string uddg))))                                                                                     ;;
;;         (if (string-match-p "^https?://" uddg) uddg href))))                                                                               ;;
;;    (t href)))                                                                                                                              ;;
;;       (url-unhex-string (match-string 1 href))                                                                                             ;;
;;     href))                                                                                                                                 ;;
;;                                                                                                                                            ;;
;; (defun my--absolute-http-url-p (s)                                                                                                         ;;
;;   (and (stringp s) (string-match-p "^https?://" s)))                                                                                       ;;
;;                                                                                                                                            ;;
;; (defun my--collect-external-links (dom host-to-avoid)                                                                                      ;;
;;   "Collect candidate result links from DOM, skipping HOST-TO-AVOID.                                                                        ;;
;; Understands Google /url?q=… and DuckDuckGo /l/?uddg=… redirects."                                                                          ;;
;;   (let (out)                                                                                                                               ;;
;;     (dolist (a (dom-by-tag dom 'a))                                                                                                        ;;
;;       (let* ((href (dom-attr a 'href))                                                                                                     ;;
;;              (href (cond                                                                                                                   ;;
;;                     ((and href (string-prefix-p "/url?" href))                                                                             ;;
;;                      (my--normalize-google-url href))                                                                                      ;;
;;                     (href (my--ddg-normalize-href href))                                                                                   ;;
;;                     (t href)))                                                                                                             ;;
;;              (txt (string-trim (dom-texts a)))                                                                                             ;;
;;              (ok (and (stringp href)                                                                                                       ;;
;;                       (string-match-p "^https?://" href)                                                                                   ;;
;;                       (not (string-match-p (regexp-quote host-to-avoid) href))                                                             ;;
;;                       (not (string-match-p "^https?://\(www\.\)?google\.com" href))                                                        ;;
;;                       (not (string-match-p "^https?://\(www\.\)?duckduckgo\.com" href))                                                    ;;
;;                       (> (length txt) 0))))                                                                                                ;;
;;         (when ok (push (list :title txt :url href) out))))                                                                                 ;;
;;     (nreverse (cl-delete-duplicates out :test (lambda (a b)                                                                                ;;
;;                                                (equal (plist-get a :url)                                                                   ;;
;;                                                       (plist-get b :url))))))                                                              ;;
;;              (txt (string-trim (dom-texts a)))                                                                                             ;;
;;              (ok (and (my--absolute-http-url-p href)                                                                                       ;;
;;                       (not (string-match-p (regexp-quote host-to-avoid) href))                                                             ;;
;;                       (not (string-match-p "^https?://(www\\.)?google\\.com" href))                                                        ;;
;;                       (not (string-match-p "^https?://(www\\.)?duckduckgo\\.com" href))                                                    ;;
;;                       (> (length txt) 0)))                                                                                                 ;;
;;         (when ok (push (list :title txt :url href) out))) )                                                                                ;;
;;     (nreverse (cl-delete-duplicates out :test (lambda (a b)                                                                                ;;
;;                                                (equal (plist-get a :url)                                                                   ;;
;;                                                       (plist-get b :url)))))                                                               ;;
;;                                                                                                                                            ;;
;;                                                                                                                                            ;;
;;                                                                                                                                            ;;
;; Here’s the corrected version of your function with balanced parentheses:                                                                   ;;
;;                                                                                                                                            ;;
;; ```elisp                                                                                                                                   ;;
;; (defun my--collect-external-links (dom host-to-avoid)                                                                                      ;;
;;   "Collect candidate result links from DOM, skipping HOST-TO-AVOID.                                                                        ;;
;; Understands Google /url?q=… and DuckDuckGo /l/?uddg=… redirects."                                                                          ;;
;;   (let (out)                                                                                                                               ;;
;;     (dolist (a (dom-by-tag dom 'a))                                                                                                        ;;
;;       (let* ((href (dom-attr a 'href))                                                                                                     ;;
;;              (href (cond                                                                                                                   ;;
;;                     ((and href (string-prefix-p "/url?" href))                                                                             ;;
;;                      (my--normalize-google-url href))                                                                                      ;;
;;                     (href (my--ddg-normalize-href href))                                                                                   ;;
;;                     (t href)))                                                                                                             ;;
;;              (txt (string-trim (dom-texts a)))                                                                                             ;;
;;              (ok (and (stringp href)                                                                                                       ;;
;;                       (string-match-p "^https?://" href)                                                                                   ;;
;;                       (not (string-match-p (regexp-quote host-to-avoid) href))                                                             ;;
;;                       (not (string-match-p "^https?://\\(www\\.)?google\\.com" href))                                                      ;;
;;                       (not (string-match-p "^https?://\\(www\\.)?duckduckgo\\.com" href))                                                  ;;
;;                       (> (length txt) 0))))                                                                                                ;;
;;         (when ok (push (list :title txt :url href) out))))                                                                                 ;;
;;     (nreverse (cl-delete-duplicates out :test (lambda (a b)                                                                                ;;
;;                                                (equal (plist-get a :url)                                                                   ;;
;;                                                       (plist-get b :url)))))))                                                             ;;
;;                                                                                                                                            ;;
;;                                                                                                                                            ;;
;;                                                                                                                                            ;;
;; Ensure this comment matches the style used at the beginning of your file. Place it at the very end of your buffer to suppress the warning. ;;
;;                                                                                                                                            ;;
;; (defun my--search-google (query)                                                                                                           ;;
;;   "Return (list :engine \"google\" :results [...]) for QUERY via HTML `gbv=1`."                                                            ;;
;;   (let* ((url-request-extra-headers `(("User-Agent" . ,my-gptel-web-user-agent)                                                            ;;
;;                                       ("Accept-Language" . "en, *;q=0.5")))                                                                ;;
;;          (q (url-hexify-string query))                                                                                                     ;;
;;          ;; `gbv=1` forces a basic HTML version that libxml can parse.                                                                     ;;
;;          (search-url (format "https://www.google.com/search?gbv=1&q=%s" q))                                                                ;;
;;          (buf (url-retrieve-synchronously search-url t t my-gptel-web-timeout)))                                                           ;;
;;     (unless buf (error "Search failed (Google)"))                                                                                          ;;
;;     (unwind-protect                                                                                                                        ;;
;;         (with-current-buffer buf                                                                                                           ;;
;;           (goto-char (my-url-http-body-start))                                                                                             ;;
;;           (let* ((dom (libxml-parse-html-region (point) (point-max)))                                                                      ;;
;;                  (links (my--collect-external-links dom "google.com")))                                                                    ;;
;;             (list :engine "google" :results links)))                                                                                       ;;
;;       (kill-buffer buf))))                                                                                                                 ;;
;;                                                                                                                                            ;;
;; (defun my--search-auto (query)                                                                                                             ;;
;;   "Try DDG first, then Google. Return plist :engine and :results."                                                                         ;;
;;   (condition-case _                                                                                                                        ;;
;;       (my--search-ddg query)                                                                                                               ;;
;;     (error (my--search-google query))))                                                                                                    ;;
;;                                                                                                                                            ;;
;; ;; ---------------------------------------------------------------------------                                                             ;;
;; ;; Public API: search + optional readable context                                                                                          ;;
;; ;; ---------------------------------------------------------------------------                                                             ;;
;;                                                                                                                                            ;;
;; (defun my-gptel-web-search-core (query &optional maxresults include-context per-page-chars total-context-chars engine)                     ;;
;;   "Search the web for QUERY and return formatted text for the LLM.                                                                         ;;
;; MAXRESULTS (default 5) truncates result list.                                                                                              ;;
;; If INCLUDE-CONTEXT is non-nil, also fetch top pages and include readable                                                                   ;;
;; text using `shr`, limited to PER-PAGE-CHARS and TOTAL-CONTEXT-CHARS.                                                                       ;;
;; ENGINE is one of nil/'auto, 'ddg, or 'google."                                                                                             ;;
;;   (let* ((maxresults (or maxresults 5))                                                                                                    ;;
;;          (per-page (or per-page-chars my-gptel-web-per-page-chars))                                                                        ;;
;;          (total (or total-context-chars my-gptel-web-max-context-chars))                                                                   ;;
;;          (search (pcase engine                                                                                                             ;;
;;                    ('ddg    (my--search-ddg query))                                                                                        ;;
;;                    ('google (my--search-google query))                                                                                     ;;
;;                    (_       (my--search-auto query))))                                                                                     ;;
;;          (engine-name (plist-get search :engine))                                                                                          ;;
;;          (results (seq-take (plist-get search :results) maxresults))                                                                       ;;
;;          (ts (format-time-string "%Y-%m-%d %H:%M:%S %Z")))                                                                                 ;;
;;     (with-temp-buffer                                                                                                                      ;;
;;       (insert (format "SEARCH RESULTS\nQuery: %s\nEngine: %s\nTime: %s\n\n" query engine-name ts))                                         ;;
;;       (cl-loop for i from 1                                                                                                                ;;
;;                for r in results do                                                                                                         ;;
;;                (insert (format "%d) %s\n   URL: %s\n\n"                                                                                    ;;
;;                                i (plist-get r :title) (plist-get r :url))))                                                                ;;
;;       (when include-context                                                                                                                ;;
;;         (insert "--- BEGIN CONTEXT FROM TOP PAGES ---\n\n")                                                                                ;;
;;         (let ((remaining total)                                                                                                            ;;
;;               (i 0))                                                                                                                       ;;
;;           (while (and results (> remaining 0))                                                                                             ;;
;;             (cl-incf i)                                                                                                                    ;;
;;             (let* ((r (pop results))                                                                                                       ;;
;;                    (url (plist-get r :url))                                                                                                ;;
;;                    (title (plist-get r :title))                                                                                            ;;
;;                    (chunk (condition-case err                                                                                              ;;
;;                                (my-gptel-fetch-readably url (min per-page remaining))                                                      ;;
;;                              (error (format "[Fetch error for %s] %s" url (error-message-string err))))))                                  ;;
;;               (insert (format "[%d] %s\n%s\n\n" i (or title url) chunk))                                                                   ;;
;;               (cl-decf remaining (length chunk)))))                                                                                        ;;
;;         (insert "--- END CONTEXT ---\n"))                                                                                                  ;;
;;       (buffer-string))))                                                                                                                   ;;
;;                                                                                                                                            ;;
;; ;; ---------------------------------------------------------------------------                                                             ;;
;; ;; gptel tool wrapper and registration                                                                                                     ;;
;; ;; ---------------------------------------------------------------------------                                                             ;;
;;                                                                                                                                            ;;
;; (defun my-gptel-web-search-tool (query &optional maxresults include_context per_page_chars total_context_chars engine)                     ;;
;;   "Tool entry: return markdown text with search results and optional context."                                                             ;;
;;   (my-gptel-web-search-core query maxresults include_context per_page_chars total_context_chars engine))                                   ;;
;;                                                                                                                                            ;;
;; (defvar my-gptel-web-search nil)                                                                                                           ;;
;;                                                                                                                                            ;;
;; (defun my-gptel-register-web-tools ()                                                                                                      ;;
;;   "Register the web_search tool with gptel and allow tool usage."                                                                          ;;
;;   (interactive)                                                                                                                            ;;
;;   (setq-default gptel-use-tools 'allow)                                                                                                    ;;
;;   (when (boundp 'gptel-tools)                                                                                                              ;;
;;     (setq gptel-tools (cl-remove-if (lambda (t)                                                                                            ;;
;;                                       (and (plistp t)                                                                                      ;;
;;                                            (eq (plist-get t :name) 'web_search)))                                                          ;;
;;                                     gptel-tools)))                                                                                         ;;
;;   (setq my-gptel-web-search                                                                                                                ;;
;;         (gptel-make-tool                                                                                                                   ;;
;;          :name "web_search"                                                                                                                ;;
;;          :description (concat                                                                                                              ;;
;;                        "Search the web (DDG HTML with Google fallback). "                                                                  ;;
;;                        "Returns a ranked list and, if requested, readable context "                                                        ;;
;;                        "extracted from top hits via shr.")                                                                                 ;;
;;          :category "web"                                                                                                                   ;;
;;          :function #'my-gptel-web-search-tool                                                                                              ;;
;;          :args (list                                                                                                                       ;;
;;                 '(:name "query" :type string :description "Search query string")                                                           ;;
;;                 '(:name "maxresults" :type integer :optional t :description "Number of results (default 5)")                               ;;
;;                 '(:name "include_context" :type boolean :optional t :description "Also fetch readable context")                            ;;
;;                 '(:name "per_page_chars" :type integer :optional t :description "Per-page context cap (default 1200)")                     ;;
;;                 '(:name "total_context_chars" :type integer :optional t :description "Total context cap (default 6000)")                   ;;
;;                 '(:name "engine" :type string :optional t :description "one of auto, ddg, google"))))                                      ;;
;;   (add-to-list 'gptel-tools my-gptel-web-search)                                                                                           ;;
;;   ;; Provide a convenience alias for your readable fetcher as well (optional):                                                             ;;
;;   (when (boundp 'my-gptel-web-get) (makunbound 'my-gptel-web-get))                                                                         ;;
;;   (setq my-gptel-web-get                                                                                                                   ;;
;;         (gptel-make-tool                                                                                                                   ;;
;;          :name "web_get"                                                                                                                   ;;
;;          :description "Fetch a web page and return readable text via shr."                                                                 ;;
;;          :category "web"                                                                                                                   ;;
;;          :function (lambda (url &optional maxchars)                                                                                        ;;
;;                      (my-gptel-fetch-readably url (or maxchars 16000)))                                                                    ;;
;;          :args (list                                                                                                                       ;;
;;                 '(:name "url" :type string :description "http/https URL")                                                                  ;;
;;                 '(:name "maxchars" :type integer :optional t :description "truncate length (default 16000)"))))                            ;;
;;   (add-to-list 'gptel-tools my-gptel-web-get)                                                                                              ;;
;;   (message "gptel-web-search-tools: registered web_search and web_get tools."))                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;  (my--search-google "Obama")
;;; config.el ends here
