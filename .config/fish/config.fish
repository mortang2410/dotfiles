
if status is-interactive
    # Commands to run in interactive sessions can go here
end

#for fzf
export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore -l ""'
export FZF_CTRL_T_COMMAND='rg --hidden --no-ignore -l ""'
export FZF_ALT_C_COMMAND='fd --hidden -t d'

set -gx LDFLAGS "-L/opt/homebrew/opt/llvm/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/llvm/include"
export EDITOR='hx'

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

#for homebrew, but still doesn't work 
export ARCHFLAGS='-arch arm64'

#for Go stuff compilation
export HOMEBREW_PREFIX=(brew --prefix)
export CGO_CFLAGS="-I$HOMEBREW_PREFIX/include" CGO_LDFLAGS="-L$HOMEBREW_PREFIX/lib"
export GOPATH=$HOME/go

# for nnn
export NNN_FIFO='/tmp/nnn.fifo'
export NNN_PLUG='f:-!&open .;o:fzopen;p:preview-tui;d:diffs;t:nmount;v:imgview'
export NNN_PAGER='bat'
### using pistol in NNN will disable viu image previewer
# export NNN_PISTOL=1

# make bat have readable color as a replacement for less 
export BAT_THEME=ansi
export PAGER='bat --terminal-width -10'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

alias t="tmux"