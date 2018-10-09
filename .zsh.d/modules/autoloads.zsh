# =========
# Autoloads
# =========
{
  autoload -Uz zargs               # a more integrated xargs
  autoload -Uz zmv                 # concise file renaming/moving
  autoload -Uz zed                 # edit files right in the shell
  autoload -Uz zsh/mathfunc        # common mathematical functions
  autoload -Uz zcalc               # a calculator right in the shell
  autoload -Uz zkbd                # automatic keybinding detection
  autoload -Uz zsh-mime-setup      # automatic MIME type suffixes
  autoload -Uz colors              # collor utility functions
  autoload -Uz vcs_info            # integrate with version control
  autoload -Uz copy-earlier-word   # navigate backwards with C-. C-,
  autoload -Uz url-quote-magic     # automatically%20escape%20characters
  autoload -Uz add-zsh-hook        # a more modular way to hook
  autoload -Uz is-at-least         # enable graceful regression
  autoload -Uz throw               # throw exceptions
  autoload -Uz catch               # catch exceptions

  zmodload zsh/complist            # ensure complist is loaded
  zmodload zsh/sched               # delayed execution in zsh
  zmodload zsh/mathfunc            # mathematical functions in zsh
  zmodload zsh/terminfo            # terminal parameters from terminfo
  zmodload zsh/complist            # various completion functions
  
} &>> $ZDOTDIR/startup.log
