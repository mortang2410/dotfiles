# ====================
# Interactive commands
# ====================

# increments the last number on the line
function _increase_number() {
  emulate -LR zsh -o prompt_subst
  local -a match mbegin mend
  while [[ ! $LBUFFER =~ '([0-9]+)[^0-9]*$' ]]; do
    zle up-line-or-search
  done
  
  LBUFFER[mbegin,mend]=$(printf %0${#match[1]}d $((10#$match+${NUMERIC:-1})))
}
zle -N increase-number _increase_number
global_bindkey '^X^a' increase-number
bindkey -s '^Xx' '^[-^Xa'

# C-r/s intelligently adds to line instead of replacing it or searches using it
autoload -Uz narrow-to-region
function _history-incremental-preserving-pattern-search-backward {
  emulate -LR zsh -o extended_glob -o prompt_subst
  local state

  if [[ $LBUFFER == *(\;|\||\|\&|\&\&|\|\|)[[:space:]]# ]]; then
    # If we are following a metacharacter, add to the current line
    MARK=CURSOR  # magic, else multiple ^R don't work
    narrow-to-region -p "$LBUFFER${BUFFER:+>>}" -P "${BUFFER:+<<}$RBUFFER" -S state
    zle end-of-history
    zle history-incremental-pattern-search-backward
    narrow-to-region -R state
  else
    # Otherwise, search using the current line
    if [[ -n $BUFFER ]]; then
      zle -U $BUFFER
      BUFFER=""
    fi
    zle history-incremental-pattern-search-backward
  fi
}

function _history-incremental-preserving-pattern-search-forward {
  emulate -LR zsh -o extended_glob -o prompt_subst
  local state

  if [[ $LBUFFER == *(\;|\||\|\&|\&\&|\|\|)[[:space:]]# ]]; then
  # If we are following a metacharacter, add to the current line
  MARK=CURSOR  # magic, else multiple ^R don't work
  narrow-to-region -p "$LBUFFER${BUFFER:+>>}" -P "${BUFFER:+<<}$RBUFFER" -S state
  zle end-of-history
  zle history-incremental-pattern-search-forward
  narrow-to-region -R state
  else
    # Otherwise, search using the current line
    if [[ -n $BUFFER ]]; then
      zle -U $BUFFER
      BUFFER=""
    fi
    zle history-incremental-pattern-search-forward
  fi
}

zle -N _history-incremental-preserving-pattern-search-backward
zle -N _history-incremental-preserving-pattern-search-forward

global_bindkey "^R" _history-incremental-preserving-pattern-search-backward
global_bindkey "^S" _history-incremental-preserving-pattern-search-forward

bindkey -M isearch "^R" history-incremental-pattern-search-backward
bindkey -s -M isearch " " "*"
bindkey -M isearch "^ " magic-space

autoload -Uz cycle-completion-positions
zle -N cycle-completion-positions
global_bindkey "^X^I" cycle-completion-positions


autoload -Uz forward-word-match
autoload -Uz backward-word-match
autoload -Uz kill-word-match
autoload -Uz backward-kill-word-match
autoload -Uz transpose-words-match
autoload -Uz select-word-style
autoload -Uz match-word-context
autoload -Uz match-words-by-style

zle -N forward-word-match
zle -N backward-word-match
zle -N kill-word-match
zle -N backward-kill-word-match
zle -N transpose-words-match
zle -N select-word-style
zle -N match-word-context
zle -N match-words-by-style

select-word-style shell

global_bindkey "^[^F" forward-word-match
global_bindkey "^[^B" backward-word-match
global_bindkey "^[^K" backward-kill-word-match
global_bindkey "^[^T" transpose-words-match

WORDCHARS=${WORDCHARS/\//}

# M-, moves to the previous word on the current line, like M-.
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
global_bindkey "^[," copy-earlier-word
global_bindkey "^[." insert-last-word

# rationalize dots
rationalise_dot () {
  emulate -LR zsh -o prompt_subst
  # typing .... becomes ../../../ etc.
  local MATCH # keep the regex match from leaking to the environment
  if [[ $LBUFFER =~ '(^|/| |      |'$'\n''|\||;|&)\.\.$' ]]; then
    LBUFFER+=/
    zle self-insert
    zle self-insert
  else
    zle self-insert
  fi
}

zle -N rationalise_dot
global_bindkey . rationalise_dot
# without this, typing a "." aborts incremental history search
bindkey -M isearch . self-insert

# zaw: helm.el for zsh
function () {
  emulate -LR zsh

  ZAW_SRC_GIT_LOG_MAX_COUNT=0

  # and import other zaw sources
  for file in $ZDOTDIR/zaw-misc-sources/*.zsh(n); do
    source $file
  done

  zle -N zaw-autoload-git-log
  zle -N zaw-autoload-git-show-branch
  
  global_bindkey "^X;" zaw
  global_bindkey "^Xr" zaw-history
  global_bindkey "^Xo" zaw-open-file
  global_bindkey "^Xa" zaw-applications


  global_bindkey "^Xgf" zaw-git-files
  global_bindkey "^Xgb" zaw-git-recent-branches
  global_bindkey "^Xgs" zaw-git-status
  global_bindkey "^Xgl" zaw-git-log
  # global_bindkey "^Xgc" zaw-git-show-branch
  global_bindkey "^Xgr" zaw-git-reflog

  global_bindkey "^Xf" zaw-open-file-recursive
  
  zstyle ':filter-select' extended-search yes
  zstyle ':filter-select' case-insensitive yes
  zstyle ':filter-select' max-lines -10
}
