# ==================
# unified key system
# ==================

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

fpath+=$ZPLUG_HOME/repos/knu/zsh-git-escape-magic
autoload -Uz git-escape-magic
git-escape-magic

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

typeset -A key
function {
  emulate -LR zsh
  local zkbd_dest
  zkbd_dest=${ZDOTDIR:-$HOME}/.zkbd/$_OLD_TERM-$VENDOR-$OSTYPE
  local REPLY REPLY_PERM
  {
  if [[ -s $zkbd_dest ]]; then
    source $zkbd_dest
  elif [[ -f $zkbd_dest ]]; then
    throw KeyFallback
  else
    echo "No keybinding definitions found in ${zkbd_dest}"
    read -q "REPLY?Generate keybindings for $_OLD_TERM? (y/n) " -n 1

    if [[ $REPLY != [Yy]* ]]; then
      echo
      read -q "REPLY_PERM?Ask again? (y/n) " -n 1
      if [[ $REPLY_PERM != [Yy]* ]]; then
        touch $zkbd_dest
        exec $SHELL
      else
        throw KeyFallback
      fi
    fi

    if [[ $REPLY == [Yy]* ]]; then
      echo
      export TERM=$_OLD_TERM
      zkbd
      echo "Keys generated ... exiting"
      mv ${ZDOTDIR:-$HOME}/.zkbd/$TERM-:0 $zkbd_dest &> /dev/null
      source $zkbd_dest
    fi
  fi
  } always {
    if catch KeyFallback; then
      key[Home]=${terminfo[khome]}
      key[End]=${terminfo[kend]}
      key[Insert]=${terminfo[kich1]}
      key[Delete]=${terminfo[kdch1]}
      key[Up]=${terminfo[kcuu1]}
      key[Down]=${terminfo[kcud1]}
      key[PageUp]=${terminfo[kpp]}
      key[PageDown]=${terminfo[knp]}

      # these will get run anyway
      # key[Left]=${terminfo[kcub1]}
      # key[Right]=${terminfo[kcuf1]}
    fi
  }
}

[[ -n ${key[Backspace]} ]] && global_bindkey "${key[Backspace]}" backward-delete-char
[[ -n ${key[Insert]}    ]] && global_bindkey "${key[Insert]}"    overwrite-mode
[[ -n ${key[Home]}      ]] && global_bindkey "${key[Home]}"      beginning-of-line
[[ -n ${key[PageUp]}    ]] && global_bindkey "${key[PageUp]}"    up-line-or-history
[[ -n ${key[Delete]}    ]] && global_bindkey "${key[Delete]}"    delete-char
[[ -n ${key[End]}       ]] && global_bindkey "${key[End]}"       end-of-line
[[ -n ${key[PageDown]}  ]] && global_bindkey "${key[PageDown]}"  down-line-or-history
[[ -n ${key[Up]}        ]] && global_bindkey "${key[Up]}"        up-line-or-search
[[ -n ${key[Down]}      ]] && global_bindkey "${key[Down]}"      down-line-or-search

# let the terminal take care of these
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}

# Weird M-arrow and C-arrow codes
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
