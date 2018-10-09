# ============
# Auto handler
# ============

function _accept-line() {
  emulate -LR zsh -o prompt_subst -o transient_rprompt

  if [[ -z $BUFFER ]]; then
    zle clear-screen
    zle-line-init
    return 0
  fi

  # expand all aliases on return
  if [[ $#RBUFFER == 0 ]]; then
    expand_alias no_space
  fi

  zle .accept-line
}

zle -N accept-line _accept-line
