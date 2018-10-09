# ========================
# History substring search
# ========================
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=black,bg=green,underline"
bindkey -M afu '^R' history-incremental-pattern-search-backward
bindkey -M afu '^S' history-incremental-pattern-search-forward

zmodload zsh/terminfo
bindkey -M afu "${key[Up]}" history-substring-search-up
bindkey -M afu "${key[Down]}" history-substring-search-down

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
