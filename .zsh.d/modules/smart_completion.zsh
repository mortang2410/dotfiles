# ========================
# smart tab - really smart
# ========================

function pcomplete() {
  emulate -L zsh
  {
    setopt function_argzero prompt_subst extended_glob
    setopt list_packed list_rows_first

    local -a show_completer
    local -a extra_verbose
    local -a verbose
    local -a completer
    local -a menu

    zstyle -a ':completion:*' show-completer show_completer
    zstyle -a ':completion:*' extra-verbose extra_verbose
    zstyle -a ':completion:*' verbose verbose
    zstyle -a ':completion:*' completer completer
    zstyle -a ':completion:*' menu menu

    setopt auto_list              # list if multiple matches
    setopt complete_in_word       # complete at cursor
    setopt menu_complete          # add first of multiple
    setopt auto_remove_slash      # remove extra slashes if needed
    setopt auto_param_slash       # completed directory ends in /
    setopt auto_param_keys        # smart insert spaces " "

    # hack a local function scope using unfuction
    function pcomplete_forward_word () {
      local old_word_style
      zstyle -s ':zle:*' word-style old_word_style
      zstyle ':zle:*' word-style shell
      autoload -Uz forward-word-match
      zle forward-word-match
      zstyle ':zle:*' word-style $old_word_style
    }

    zstyle ':completion:*' show-completer true
    zstyle ':completion:*' extra-verbose true
    zstyle ':completion:*' verbose true
    zstyle ':completion:*' menu select=1 interactive

    zstyle ':completion:*' completer \
      _oldlist \
      _expand \
      _complete \
      _match \
      _prefix

    local cur_rbuffer space_index i
    local -i single_match
    local -a match mbegin mend

    # detect single auto-fu match
    for param in $region_highlight; do
      if [[ $param == (#b)[^0-9]#(<->)[^0-9]##(<->)(*) ]]; then
        i=($match)
        if [[ $i[3] == *black* ]] && (($i[2] - $i[1] > 0 && $i[1] > 1)); then
          pcomplete_forward_word
          break
        elif [[ $i[3] == *underline* ]] && (($i[2] - $i[1] > 0 && $i[1] >= $CURSOR)); then
          single_match=1
          break
        fi
      fi
    done

    if [[ $single_match == 1 ]]; then
      zle expand-or-complete
      if [[ $LBUFFER[-1] == " " ]]; then
        zle .backward-delete-char
      fi
    else
      zle menu-expand-or-complete
    fi

    zstyle ':completion:*' show-completer $show_completer
    zstyle ':completion:*' extra-verbose $extra_verbose
    zstyle ':completion:*' verbose $verbose
    zstyle ':completion:*' completer $completer
    zstyle ':completion:*' menu $menu

  } always {
    unfunction "pcomplete_forward_word"
  }
  _zsh_highlight 2>/dev/null
}

bindkey -M menuselect . self-insert

zle -N pcomplete

global_bindkey '^i' pcomplete
bindkey -M menuselect '^i' forward-char

function _magic-space () {
  emulate -LR zsh
  if [[ $LBUFFER[-1] != " "  ]]; then
    zle .magic-space
    if [[ $LBUFFER[-2] == " " ]]; then
      zle backward-delete-char
    fi
  else
    zle .magic-space
  fi
}

zle -N magic-space _magic-space
