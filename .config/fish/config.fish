
if status is-interactive
    # Commands to run in interactive sessions can go here
end

#for fzf
export FZF_DEFAULT_COMMAND='fd -HI'
export FZF_CTRL_T_COMMAND='fd -HI'
export FZF_ALT_C_COMMAND='fd -HI -t d'

set -gx LDFLAGS "-L/opt/homebrew/opt/llvm/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/llvm/include"
set -agx LIBRARY_PATH "/opt/homebrew/lib"
set -agx INCLUDE_PATH "/opt/homebrew/include"
export NPM_CONFIG_PREFIX="~/.npm-global"
export EDITOR='nvim'

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

#for homebrew, but still doesn't work 
export ARCHFLAGS='-arch arm64'

#for Go stuff compilation
export HOMEBREW_PREFIX=(brew --prefix)
export CGO_CFLAGS="-I$HOMEBREW_PREFIX/include" CGO_LDFLAGS="-L$HOMEBREW_PREFIX/lib"
export GOPATH=$HOME/go


# for nnn
export NNN_FIFO='/tmp/nnn.fifo'
export nnn_selection=$HOME/.config/nnn/.selection
export NNN_PLUG='f:fzopen;o:-!&open "$nnn";F:-!&open -R "$nnn";d:dropover;p:preview-tui;n:!nvr -s "$nnn"*;m:-!&open -a marta "$nnn";t:nmount;v:imgview'
export NNN_PAGER='bat'
#use nnn as file picker
alias np="n -p -"
#use nnn to drag and drop selected
alias ndr="np | dr"

### using pistol in NNN will disable viu image previewer
# export NNN_PISTOL=1

# make bat have readable color as a replacement for less 
export BAT_THEME=ansi
export PAGER='bat --terminal-width -10'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"



alias t="tmux"
alias tda="tmux detach -a" # detach all but current terminal
alias nv="nvr -s"
alias fdi="fd -HI"
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/wilder/.ghcup/bin $PATH # ghcup-env
