# Setup fzf
# ---------
if [[ ! "$PATH" == */root/.fzf/bin* ]]; then
  export PATH="$PATH:/root/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/root/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/root/.fzf/shell/key-bindings.bash"

