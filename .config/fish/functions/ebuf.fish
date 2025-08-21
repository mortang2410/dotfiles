function ebuf --description 'Read stdin into a new Emacs buffer via emacsclient'
    set -l tmp (mktemp -t emacs-pipe.XXXXXX)
    cat > "$tmp"

    set -l name "*pipe*"
    if test (count $argv) -gt 0
        set name $argv[1]
    end

    # Encode tiny strings so we can embed them safely in ELisp
    set -l path_b64 (printf %s "$tmp" | base64 | tr -d '\n')
    set -l name_b64 (printf %s "$name" | base64 | tr -d '\n')

    emacsclient -n -a "" --eval "
(let* ((file (base64-decode-string \"$path_b64\"))
       (name (base64-decode-string \"$name_b64\"))
       (buf  (generate-new-buffer name)))
  (with-current-buffer buf
    (insert-file-contents file)
    (goto-char (point-min))
    (normal-mode))
  (pop-to-buffer buf)
  (ignore-errors (delete-file file))
  t)"
end
