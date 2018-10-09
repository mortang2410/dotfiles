# ========================================
# Autogen Options - manfile/GNUdoc scraper
# ========================================

# scrapes helpfiles looking for arguments
function autohelp() {
  emulate -LR zsh
  if [[ ! -f $ZDOTDIR/helpgen ]]; then
    return 1
  fi
  for cmd in $(<$ZDOTDIR/helpgen); do
    compdef _gnu_generic $cmd
  done
}

# helper function, mark a command as autohelpable
function helpgen() {
  emulate -LR zsh
  echo -e "$1" >> $ZDOTDIR/helpgen
  sort $ZDOTDIR/helpgen -o $ZDOTDIR/helpgen
  compdef _gnu_generic $1
}

autohelp

function auto_recompile () {
  autoload -Uz zrecompile
  zrecompile $ZDOTDIR/.zshrc
  local zsh_module file

  for zsh_module in $ZDOTDIR/modules/*.zsh(n); do
    zrecompile $zsh_module
  done

  for file in $ZDOTDIR/local/*.zsh(n); do
    zrecompile $file
  done
}

# asynchronously recompile in the background
auto_recompile $!
