# =======
# Aliases
# =======
typeset -A global_abbrevs command_abbrevs
typeset -a expand

expand=('mc')


function alias () {
  emulate -LR zsh
  zparseopts -D -E eg=EG ec=EC E=E
  if [[ -n $EG ]]; then
    for token in $@; do
      token=(${(s/=/)token})
      builtin alias -g $token
      global_abbrevs[$token[1]]=$token[2]
    done
  elif [[ -n $EC ]]; then
    for token in $@; do
      builtin alias $token
      token=(${(s/=/)token})
      command_abbrevs[$token[1]]=$token[2]
    done
  else
    if [[ -n $E ]]; then
      for token in $@; do
        if [[ $token == (*=*) ]]; then
          token=(${(s/=/)token})
          expand+="$token[1]"
        fi
      done
    fi
    builtin alias $@
  fi
}

# history supression aliases
alias -E clear=' clear'
alias -E pwd=' pwd'
alias -E exit=' exit'

# proxy aliases
BORING_FILES='*\~|*.elc|*.pyc|!*|_*|*.swp|*.zwc|*.zwc.old|*.synctex.gz'
if [[ $OSTYPE = (#i)((free|open|net)bsd)* ]]; then
    # in BSD, -G is the equivalent of --color
    alias -E lst=' \ls -G'
elif [[ $OSTYPE = (#i)darwin* ]]; then
  if (( $+commands[gls] )); then
    alias lsa='\gls --color --group-directories-first'
    alias -E lst=" lsa -I '"${BORING_FILES//\|/\' -I \'}"'"
  else
    alias -E lst=' \ls -G'
   fi
else
  alias lsa='\ls --color --group-directories-first'
  alias -E lst=" lsa -I '"${BORING_FILES//\|/\' -I \'}"'"
fi
alias -E egrep='nocorrect \egrep --line-buffered --color=auto'

# cd aliases
alias -- -='cd -'

# ls aliases
if (( $+commands[exa] )); then
  alias exa="exa --group-directories-first -I \"${BORING_FILES}\""
  alias ls='exa -Fx'
  alias ll='exa -FGlx --git'
  alias lss='exa -FGlxrs size'
  alias lsp='\ls'
else
  alias ls='lst -BFxv'
  alias l='lst -lFBGhv'
  alias ll='lsa -lAFGhv'
  alias lss='lst -BFshxv'
  alias lsp='\ls'
fi

# safety aliases
alias rm='rm -i'
alias -E cp='nocorrect cp'
alias ln="\ln -s"

# global aliases
alias -g G='|& egrep -i'
alias -g L='|& less -R'
alias -g Lr='|& less'
alias -g D='>&/dev/null'
alias -g W='|& wc'
alias -g Q='>&/dev/null&'

# regular aliases
alias su='su -'
alias watch='\watch -n 1 -d '
alias emacs='\emacs -nw'
alias df='\df -h'
alias ping='\ping -c 10'
alias exi='exit'
alias locate='\locate -ib'
alias -E exit=' exit'

# suppression aliases
# alias -E man='nocorrect noglob \man'
alias -E find='noglob find'
alias -E touch='nocorrect \touch'
alias -E mkdir='nocorrect \mkdir'

if (( $+commands[killall] )); then
  alias -E killall='nocorrect \killall'
elif (( $+commands[pkill] )); then
  alias -E killall='nocorrect \pkill'
fi

if (( $+commands[systemctl] )); then
  alias -E systemctl='nocorrect \systemctl'
fi

# sudo aliases
if (( $+commands[sudo] )); then
  function sudo {
    emulate -L zsh
    local precommands=()
    while [[ $1 == (nocorrect|noglob) ]]; do
      precommands+=$1
      shift
    done
    eval "$precommands command sudo ${(q)@}"
  }
  alias -E sudo='nocorrect sudo '
fi

function alias_create_please_command {
  emulate -LR zsh -o extended_glob
  if [[ $(detect_sudo_type) == none ]]; then
    local cmdline="${history[$#history]##[[:space:]]#}"
    local -i alias_found
    local exp
    # We're going to need to intelligently substitute aliases
    # This uses recursive expansion, which keeps track of previously expanded
    # aliases to avoid infinite loops with cyclic aliases
    local -a expanded=()
    while true; do
      alias_found=0
      for als in ${(k)aliases}; do
        if [[ $cmdline = ${als}* ]] && ! (( ${+expanded[(r)$als]} )); then
        expanded+=${als#\\}
          exp=$aliases[$als]
          cmdline="${cmdline/#(#m)${als}[^[:IDENT:]]/$exp${MATCH##[[:IDENT:]]#}}"
          cmdline=${cmdline##[[:space:]]#}
          alias_found=1
          break
        fi
      done
      if (( alias_found == 0 )); then
        break
      fi
    done
    # Needless to say, the result is rarely pretty
    echo -E \\su -c \"$cmdline\"
  else
    echo -E sudo ${history[$#history]}
  fi
}

alias -ec please='alias_create_please_command'

# yaourt aliases
if (( $+commands[yaourt] )); then
  alias y='yaourt'
  alias yi='yaourt -Sa'
  alias yr='yaourt -Rs'
  alias ys='yaourt -Ss'
  alias yu='yaourt -Syyua --noconfirm'
  alias yuu='yaourt -Syyua --noconfirm --devel'
fi

if (( $+commands[aurman] )); then
  alias a='aurman'
  alias ai='aurman -S'
  alias au='aurman -Syyu --noconfirm --noedit'
  alias auu='aurman -Syyu --noconfirm --noedit --devel'
fi

# dnf aliases
if (( $+commands[dnf] )); then
  alias -E dnf='nocorrect noglob \dnf'
fi

# vim aliases
if (( $+commands[gvim] )); then
  alias -E vim="gvim -v"
fi
if (( $+commands[vim] )); then
  alias -E vi="vim"
fi

# git aliases
if (( $+commands[git] )); then
  alias gs='git status -sb'
  alias gst='git status'

  alias gp="git pull --rebase"
  alias gpa="git pull --rebase --autostash"

  alias ga='git add'
  alias gau='git add -u'
  alias gaa='git add -A'

  alias gc='git commit -v'
  alias -ec gcm="echo -E git commit -v -m '{}'"
  alias gc!='git commit -v --amend'
  alias gca='git commit -v -a'
  alias -ec gcam="echo -E git commit -v -a -m '{}'"
  alias gca!='git commit -v -a --amend'

  alias gck='git checkout'
  alias -ec gfork='echo -E git checkout -b {} $(git rev-parse --abbrev-ref HEAD 2>/dev/null)'

  alias gb='git branch -vvv'
  alias gm='git merge'
  alias gma='git merge --autostash'
  alias gr='git rebase'
  alias gra='git rebase --autostash'

  alias gd='git diff'
  alias gdc='git diff --cached'

  alias gl='git log --oneline --graph --decorate'

  alias -eg .B='echo $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "N/A")'
fi

if (( $+commands[git-annex] )); then
  alias gxp='git annex proxy'
  alias gxa='git annex add'
  alias gxg='git annex get'
  alias gxs='git annex sync'
  alias gxd='git annex drop'
  alias gxc='git annex copy'
  alias gxm='git annex move'
fi

if (( $+commands[emacsclient] )); then
  alias emacsd="g emacs --daemon"
  alias emacsdk="emacsclient -e '(kill-emacs)'"j
  alias -E e='emacsclient -n -q -a $EDITOR'
fi

if (( $+commands[ranger] )); then
  alias f=ranger
fi

# ==============
# Expand aliases
# ==============

# expand aliases on space
function expand_alias() {
  emulate -LR zsh -o hist_subst_pattern -o extended_glob
  {
    # hack a local function scope using unfuction
    function expand_alias_smart_space () {
      if [[ $RBUFFER[1] != ' ' ]]; then
        zle magic-space
      else
        # we aren't at the end of the line so squeeze spaces
        
        zle forward-char
        while [[ $RBUFFER[1] == " " ]]; do
          zle forward-char
          zle backward-delete-char
        done
      fi
    }

    function expand_alias_smart_expand () {
      zparseopts -D -E g=G
      local expansion="${@[2,-1]}"
      local delta=$(($#expansion - $expansion[(i){}] - 1))

      alias ${G:+-g} $1=${expansion/{}/}

      zle _expand_alias
      
      for ((i=0; i < $delta; i++)); do
        zle backward-char
      done
    }

    # skip inside quotes
    local -a match mbegin mend
    for param in $region_highlight; do
      if [[ $param == (#b)[^0-9]#(<->)[^0-9]##(<->)[[:space:]]#(*) ]]; then
        if (($match[2] - $match[1] > 0 && $match[1] > 1)); then
          if [[ $match[3] == ${ZSH_HIGHLIGHT_STYLES[double-quoted-argument]} ||
                $match[3] == ${ZSH_HIGHLIGHT_STYLES[single-quoted-argument]} ]]; then
            zle magic-space
            return
          fi
        fi
      fi
    done

    local -a cmd
    cmd=(${(@s/;/)LBUFFER:gs/[^\\[:IDENT:]]/;})
    if [[ -n "$command_abbrevs[$cmd[-1]]" && $#cmd == 1 ]]; then
      expand_alias_smart_expand $cmd[-1] "$(${=${(e)command_abbrevs[$cmd[-1]]}})"

    elif [[ -n "$global_abbrevs[$cmd[-1]]" ]]; then
      expand_alias_smart_expand -g $cmd[-1] "$(${=${(e)global_abbrevs[$cmd[-1]]}})"

    elif [[ "${(j: :)cmd}" == *\!* ]] && alias "$cmd[-1]" &>/dev/null; then
      if [[ -n "$aliases[$cmd[-1]]" ]]; then
        LBUFFER="$aliases[$cmd[-1]] "
      fi
      
    elif [[ "$+expand[(r)$cmd[-1]]" != 1 && "$cmd[-1]" != (\\|\"|\')* ]]; then
      zle _expand_alias
      expand_alias_smart_space "$1"
      
    else
      expand_alias_smart_space "$1"
    fi

  } always {
    unfunction "expand_alias_smart_space" "expand_alias_smart_expand"
  }

  _zsh_highlight 2>/dev/null
}

zle -N expand_alias

global_bindkey " " expand_alias
global_bindkey "^ " magic-space
bindkey -M isearch " " magic-space

