
if status is-interactive
    # Commands to run in interactive sessions can go here
end

#for fzf
export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore -l ""'
export FZF_CTRL_T_COMMAND='rg --hidden --no-ignore -l ""'
export FZF_ALT_C_COMMAND='fd --hidden -t d'

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
export NNN_PLUG='f:-!&open .;o:-!&open "$nnn";p:preview-tui;m:-!&open -a marta "$nnn";t:nmount;v:imgview'
export NNN_PAGER='bat'
#use nnn as file picker
alias np="n -p -"

### using pistol in NNN will disable viu image previewer
# export NNN_PISTOL=1

# make bat have readable color as a replacement for less 
export BAT_THEME=ansi
export PAGER='bat --terminal-width -10'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"



alias t="tmux"
alias nv="nvim"
alias rgi="rg -a. -i --no-ignore"
alias fdi="fd -HI"
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/wilder/.ghcup/bin $PATH # ghcup-env