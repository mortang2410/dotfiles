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

  _zsh_autosuggest_start() {
    _zsh_autosuggest_check_deprecated_config
    _zsh_autosuggest_bind_widgets
    add-zsh-hook -d precmd _zsh_autosuggest_start
  }
} &>> $ZDOTDIR/startup.log

function global_bindkey () {
  bindkey -M command $@
  bindkey -M emacs   $@
  bindkey -M main    $@
  bindkey            $@
}

# because some other lines call this function to reset state
zle-line-init () { }
zle -N zle-line-init

global_bindkey "^Hk" describe-key-briefly
