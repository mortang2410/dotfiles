if status is-interactive
    # Commands to run in interactive sessions can go here
end

export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore -l ""'
export FZF_CTRL_T_COMMAND='rg --hidden --no-ignore -l ""'
export FZF_ALT_C_COMMAND='fd --hidden -t d'

set -gx LDFLAGS "-L/opt/homebrew/opt/llvm/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/llvm/include"
export EDITOR='hx'

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

