# ======
# Prompt
# ======

if (( $degraded_terminal[unicode] != 1 )); then
  # a prompt that commits suicide when pasted
  nbsp=$'\u00A0'
  function kill_prompt_on_paste () {
    PASTED=${(F)${${(f)PASTED}#*$nbsp}}
  }
  zstyle :bracketed-paste-magic paste-init kill_prompt_on_paste
else
  nbsp=$' '
fi

PROMPT_HOSTNAME=
PROMPT_KEYMAP=

if (( $degraded_terminal[display_host] == 1 )); then
  if (( $degraded_terminal[colors256] != 1 )); then
    if (( $+commands[md5sum] )); then
      # hash hostname and generate one of 256 colors
      PROMPT_HOSTNAME="%F{$((0x${$(echo ${HOST%%.*} |md5sum):1:2}))}"
    elif (( $+commands[md5] )); then
      PROMPT_HOSTNAME="%F{$((0x${$(echo ${HOST%%.*} |md5):1:2}))}"
    fi
    if [[ -n $PROMPT_HOSTNAME_FULL ]]; then
      PROMPT_HOSTNAME+="@${HOST}%k%f"
    else
      PROMPT_HOSTNAME+="@${HOST:0:3}%k%f"
    fi
  fi
fi

function compute_prompt () {
  emulate -LR zsh -o prompt_subst -o transient_rprompt -o extended_glob
  local pure_ascii
  PS1=

  # user (highlight root in red)
  if [[ -z $BORING_USERS[(R)$USER] ]]; then
    PS1+='%{%F{default}%}%B%{%(!.%F{red}.%F{black})%}%n'
  fi

  # reset decorations
  PS1+='%u%{%b%F{default}%}'

  PS1+="$PROMPT_HOSTNAME "

  # show background jobs
  PS1+='%(1j.%{%B%F{yellow}%}%j&%{%F{default}%b%} .)'

  # compressed_path
  PS1+='$chpwd_minify_smart_str'

  # Add teleport shortcut
  PS1+='${${${PWD:A}/#%(${${:-~}:A}|\/)/}:+${${$(( $#chpwd_minify_fasd_str && $#chpwd_minify_fasd_str <= $#chpwd_minify_smart_str ))%0}:+→${chpwd_minify_fasd_str//(#m) ?/%U${MATCH# }%u}}}'

  if (( $degraded_terminal[rprompt] != 1 )); then
    # shell depth
    if [[ $_ZSH_PARENT_CMDLINE == [[:alpha:]]#sh* ]]; then
      PS1+=" <%L>"
    fi

    # vim normal/textobject mode indicator
    RPS1='${${PROMPT_KEYMAP/vicmd/%B%F{black\} [% N]% %b }/(afu|main)/}'
    RPS1=$RPS1'${vcs_info_msg_0_}'

  else
    RPS1=
    PS1+='${${${#vcs_info_msg_0_}%0}:+ ${vcs_info_msg_0_}}'
  fi

  # show the last error code
  RPS1+='%{%B%F{red}%}%(?.. %?)%{%b%F{default}%}'

  # change the sigil color based on the return code and keymap
  PS1+='${${${${${PROMPT_KEYMAP}:#vicmd}:-%{%F{magenta\}%\}}:#${PROMPT_KEYMAP}}:-%{%(?.%F{green\}.%B%F{red\})%\}}'

  # compute the sigil
  if [[ -n $TMUX ]]; then
    if (( $degraded_terminal[unicode] != 1 )); then
      PS1+=" %(!.#.❯)"

    else
      PS1+=" %(!.#.$)"
    fi
  else
    PS1+=" %#"
  fi
  PS1+="%{%b%F{default}%}$nbsp"
}


compute_prompt
PS2="\${(l:\${#\${(M)\${\${(%%S)\$(eval \"echo \${\${(q)PS1}//\\\\\$/\\\$}\")//\%([BSUbfksu]|([FBK]|)\{*\})/}}%%[^$'\n']#}}:: :)\${:->$nbsp}}"
RPS2='%^'

# intercept keymap selection
function zle-keymap-select () {
  emulate -LR zsh -o prompt_subst -o transient_rprompt -o extended_glob
  PROMPT_KEYMAP=$KEYMAP
  zle .reset-prompt
  zle -R
}
zle -N zle-keymap-select

function conditional_rprompt () {
  if (( $? != 0 )); then
    unsetopt transient_rprompt
  else
    setopt transient_rprompt
  fi
}

function zle-line-finish () {
  if [[ $options[transient_rprompt] == off ]]; then
    local TEMP_RPS1=$RPS1
    RPS1='%{%B%F{red}%}%(?.. %?)%{%b%F{default}%}'
    zle .reset-prompt
    zle -R
    RPS1=$TEMP_RPS1
  fi
}

add-zsh-hook precmd conditional_rprompt
zle -N zle-line-finish
