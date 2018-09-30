# Setup fzf
# ---------
if [[ ! "$PATH" == */home/wilder/.fzf/bin* ]]; then
  export PATH="$PATH:/home/wilder/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/wilder/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/wilder/.fzf/shell/key-bindings.bash"

