# ===========
# Environment
# ===========

# check if user has root privileges
integer user_has_root
function {
  if (( $UID == 0 )); then
    echo Warning! This user has root privileges.
    user_has_root=1
  fi
}

HISTFILE=$ZDOTDIR/.histfile
HISTSIZE=50000
SAVEHIST=50000

# Forcefully disable the bell
ZBEEP=""

if (( $+commands[nvim] )); then
  export EDITOR="nvim"
elif (( $+commands[gvim] )); then
  export EDITOR="$ZDOTDIR/bin/gvim-with-flags"
elif (( $+commands[vim] )); then
  export EDITOR="vim"
elif (( $+commands[emacs] )); then
  export EDITOR="$ZDOTDIR/bin/emacs-with-flags"
elif (( $+commands[vi] )); then
  export EDITOR="vi"
elif (( $+commands[nano] )); then
  export EDITOR="nano"
fi

export REPORTTIME=10
export SAGE_STARTUP_FILE=~/.sage/init.sage
export PATH

typeset -TU LD_LIBRARY_PATH ld_library_path
typeset -TU PERL5LIB        perl5lib

typeset -U path
typeset -U manpath
typeset -U fpath 
typeset -U cdpath

path+=(
  $ZPLUG_HOME/repos/zplug/zplug/bin
  $ZPLUG_HOME/bin
  /usr/local/bin
  /sbin
  /usr/sbin
  /usr/local/sbin
  ~/bin
  ~/usr/bin
  ~/.local/bin
)

path=( ${(u)^path:A}(N-/) )

NULLCMD="cat"
READNULLCMD="less"

# =================
# Terminal handling
# =================

# Indicates terminal does not support colors/decorations/unicode
typeset -A degraded_terminal

degraded_terminal=(
  colors       0
  colors256    0
  decorations  0
  unicode      0
  rprompt      0
  title        0
  display_host 0
)

export _OLD_TERM=$TERM
case $_OLD_TERM in
  (linux|vt100)
    degraded_terminal[colors256]=1
    degraded_terminal[unicode]=1;;

  (screen*|tmux*)
    # check for lack of 256color support
    if [[ $TTY == /dev/tty*  ]]; then
      export TERM='screen'
    else
      export TERM='screen-256color'
    fi;;

  (eterm*)
    degraded_terminal[unicode]=1
    degraded_terminal[title]=1;;

  (xterm-256color)
    ;;

  (*)
    export TERM=xterm
    if [[ -f /usr/share/terminfo/x/xterm-256color ]]; then
      export TERM=xterm-256color
    elif [[ -f /lib/terminfo/x/xterm-256color ]]; then
      export TERM=xterm-256color
    elif [[ -f /usr/share/misc/termcap ]]; then
      if [[ $(</usr/share/misc/termcap) == *xterm-256color* ]]; then
        export TERM=xterm-256color
      fi
    fi;;
esac

if [[ -n ${MC_TMPDIR+1} ]]; then
  degraded_terminal[rprompt]=1
  degraded_terminal[decorations]=1
  degraded_terminal[title]=1
fi

if [[ -f /proc/$PPID/cmdline ]]; then
  read _ZSH_PARENT_CMDLINE < /proc/$PPID/cmdline
fi

if [[ -f /proc/sys/kernel/osrelease ]]; then
  read _ZSH_OSRELEASE < /proc/sys/kernel/osrelease
fi

if [[ $_ZSH_OSRELEASE == *Microsoft* && -z $DISPLAY ]]; then
  degraded_terminal[unicode]=1
fi

if [[ -n $TMUX && -n $SSH_CLIENT ]]; then
  degraded_terminal[display_host]=1
elif [[ $_ZSH_PARENT_CMDLINE == (sshd*|*/sshd|mosh-server*) ]]; then
  degraded_terminal[display_host]=1
fi

# Only start tmux if PWD wasn't overridden
if [[ ${PWD:A} == (${${:-~}:A}|/) ]]; then
  # And if the current session is remote
  if [[ $degraded_terminal[display_host] == 1 ]]; then
    # And if tmux is installed, but not currently running
    if (( $+commands[tmux] )) && [[ -z $TMUX ]]; then
      if tmux ls 2> /dev/null; then
        exec tmux attach
      else
        exec tmux
      fi
    fi
  fi
fi

if [[ $(locale) != *LANG=*UTF-8* ]]; then
  degraded_terminal[unicode]=1
fi

# ======
# Colors
# ======
colors

if (( $+commands[dircolors] )); then
  function () {
    local DIRCOLORS
    DIRCOLORS=$ZPLUG_HOME/repos/seebi/dircolors-solarized/dircolors.ansi-universal
    eval ${$(dircolors $DIRCOLORS):s/di=36/di=1;30/}
  }
fi

# ==========================
# Persistent directory stack
# ==========================

autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs

touch $ZDOTDIR/zdirs

zstyle ':chpwd:*' recent-dirs-max 100
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-pushd true
zstyle ':chpwd:*' recent-dirs-file "$ZDOTDIR/zdirs"

dirstack=(${(u@Q)$(<$ZDOTDIR/zdirs)})

zstyle ':completion:*:cdr:*' verbose true
zstyle ':completion:*:cdr:*' extra-verbose true

# ===========
# Detect sudo
# ===========

function detect_sudo_type {
  if sudo -n true &> /dev/null; then
    echo passwordless
  elif [[ $(sudo -vS < /dev/null 2>&1) == (*password*|*askpass*) ]]; then
    echo passworded
  else
    echo none
  fi
}

BORING_USERS=(pythonnut pi)
