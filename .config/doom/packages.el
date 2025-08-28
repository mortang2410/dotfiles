;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;; (package! some-package)

;; -*- no-byte-compile: t; -*-
(unpin! org)

(package! org
  :recipe
  (:host nil
   :repo "https://git.tecosaur.net/mirrors/org-mode.git" :remote "mirror"
   :fork (:host nil :repo "https://git.tecosaur.net/tec/org-mode.git"
                :branch "dev" :remote "tecosaur")
   :files (:defaults "etc" "lisp/org-loaddefs.el" "org-version.el")
   :build t
   :pre-build
   (progn
     ;; 1) Generate org-version.el (Doom expects this during load)
     (with-temp-file "org-version.el"
       (require 'lisp-mnt)
       (let ((version (with-temp-buffer
                        (insert-file-contents "lisp/org.el")
                        (lm-header "version")))
             (git-version
              (string-trim
               (with-temp-buffer
                 (call-process "git" nil t nil "rev-parse" "--short" "HEAD")
                 (buffer-string)))))
         (insert
          (format "(defun org-release () \"The release version of Org.\" %S)\n" version)
          (format "(defun org-git-version () \"The truncate git commit hash of Org mode.\" %S)\n" git-version)
          "(provide 'org-version)\n")))
     ;; 2) Generate autoloads: produces lisp/org-loaddefs.el
     (let ((coding-system-for-read 'utf-8)
           (coding-system-for-write 'utf-8))
       (call-process "make" nil (get-buffer-create "*org-make*") nil "autoloads"))))
  :pin nil)




(package! dired-narrow)
;; (package! xenops)
(package! gptel :recipe (:nonrecursive t))
(package! rainbow-delimiters)
(package! atomic-chrome)
(package! evil-snipe :disable t)




;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/radian-software/straight.el#the-recipe-format
;; (package! another-package
;;   :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;; (package! this-package
;;   :recipe (:host github :repo "username/repo"
;;            :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;; (package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;; (package! builtin-package :recipe (:nonrecursive t))
;; (package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see radian-software/straight.el#279)
;; (package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;; (package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;; (unpin! pinned-package)
;; ...or multiple packages
;; (unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;; (unpin! t)
