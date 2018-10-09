# =============================
# AutoFU continuous completions
# =============================


function {
  emulate -LR zsh
  integer -g afu_enabled=1
  integer -g afu_menu=1

  zle-line-init () {
    local nesting=${(%%)${:-%^}}
    if [[ -z $nesting ]] && (( $afu_enabled == 1 )); then
      auto-fu-init
    fi
  }
  zle -N zle-line-init

  zstyle ":auto-fu:var" postdisplay ""
  zstyle ":auto-fu:var" autoable-function/skipwords yum touch brew

  zstyle ':completion:*' show-completer no
  zstyle ':completion:*' extra-verbose no
  zstyle ':completion:*:options' description no
  zstyle ':completion:*' completer _oldlist _complete

  toggle_afu() {
    if [[ $afu_menu == 1 ]]; then
      afu_menu=0
    else
      afu_menu=1
    fi
  }

  # highjack afu-comppost function
  afu-comppost () {
    emulate -LR zsh
    if [[ $afu_menu == 1 && $BUFFER[1] != ' ' ]]; then
      local -i lines=$((compstate[list_lines] + BUFFERLINES + 2))
      if ((lines > LINES*0.75 || lines > 30)); then
        # If this is unset, the list of matches will never be listed
        # according to zshall(1)
        compstate[list]=
        if [[ $WIDGET != afu+complete-word ]]; then
          compstate[insert]=
        fi
      else
        compstate[list]=autolist
      fi
    else
      compstate[list]=
    fi

    typeset -g afu_one_match_p=
    if (( $compstate[nmatches] == 1 )); then
      afu_one_match_p=t
    fi
    afu_curcompleter=$_completer
  }
} &>> $ZDOTDIR/startup.log

{
  source $ZPLUG_HOME/repos/mafredri/zsh-async/async.zsh
  source $ZPLUG_HOME/repos/PythonNut/zsh-autosuggestions/zsh-autosuggestions.zsh

  if (( $degraded_terminal[colors256] == 1 )); then
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=black,bold'
  fi

  ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(
    "expand-or-complete"
    "pcomplete"
    "copy-earlier-word"
  )

  # Start the autosuggestion widgets
  _zsh_autosuggest_start() {
    _zsh_autosuggest_check_deprecated_config
    _zsh_autosuggest_bind_widgets
    add-zsh-hook -d precmd _zsh_autosuggest_start
  }
} &>> $ZDOTDIR/startup.log

zstyle ':auto-fu:var' autoable-function/skiplbuffers \
       '?(sudo*)+([[:space:]\\])apt-get+([[:space:]])*install+([[:space:]])*' \
       '?(sudo*)+([[:space:]\\])dnf+([[:space:]])*install+([[:space:]])*' \
       '?(sudo*)+([[:space:]\\])yum+([[:space:]])*install+([[:space:]])*' \
       '*([[:space:]\\])brew+([[:space:]])*' \
       '*([[:space:]\\])curl+([[:space:]])*' \
       '*([[:space:]\\])wget+([[:space:]])*' \
       '?(sudo*)+([[:space:]\\])yaourt+([[:space:]])*' \
       '?(sudo*)+([[:space:]\\])pacman+([[:space:]])*' \
       '*/'

function global_bindkey () {
  bindkey -M command $@
  bindkey -M emacs   $@
  bindkey -M main  $@
  bindkey -M afu   $@
  bindkey      $@
}

global_bindkey "^Hk" describe-key-briefly

# Weird M-arrow and C-arrow codes
bindkey -M afu "^[[1;3C" forward-word
bindkey -M afu "^[[1;3D" backward-word
bindkey -M afu "^[[1;5C" forward-word
bindkey -M afu "^[[1;5D" backward-word
