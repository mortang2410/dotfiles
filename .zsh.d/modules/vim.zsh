# ========
# VIM MODE
# ========

global_bindkey 'jj' vi-cmd-mode
global_bindkey 'kk' vi-cmd-mode
global_bindkey 'jk' vi-cmd-mode

bindkey -M vicmd 'u' undo
bindkey -M vicmd '^R' redo

global_bindkey '^R' redo
global_bindkey '^Z' undo

bindkey -M vicmd 'Y' vi-yank-eol
bindkey -M vicmd '\-' vi-repeat-find
bindkey -M vicmd '_' vi-rev-repeat-find

function _vi-insert () {
  # hack to enable Auto-FU during vi-insert
  zle .vi-insert
  zle zle-line-init
}

function _vi-append () {
  # hack to enable Auto-FU during vi-append
  zle .vi-append
  zle zle-line-init
}

zle -N vi-insert _vi-insert
zle -N vi-append _vi-append

if (( $+commands[xclip] )); then
  zsh-x-kill-region () {
    zle kill-region
    print -rn $CUTBUFFER | xclip -i -selection clipboard
  }

  zsh-x-yank () {
    CUTBUFFER=$(xclip -o -selection clipboard)
    zle yank
  }

  zsh-x-copy-region-as-kill () {
    zle copy-region-as-kill
    print -rn $CUTBUFFER | xclip -i -selection clipboard
  }

  zle -N zsh-x-yank
  zle -N zsh-x-kill-region
  zle -N zsh-x-copy-region-as-kill

  global_bindkey '\eW' zsh-x-copy-region-as-kill
  global_bindkey '^W' zsh-x-kill-region
  global_bindkey '^y' zsh-x-yank
fi

global_bindkey "^A" beginning-of-line
global_bindkey "^E" end-of-line
