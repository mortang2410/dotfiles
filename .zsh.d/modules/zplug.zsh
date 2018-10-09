export ZPLUG_HOME=$ZDOTDIR/.zplugin

if [[ ! -d $ZPLUG_HOME ]]; then
  mkdir -p $ZPLUG_HOME
  git clone https://github.com/zdharma/zplugin.git $ZPLUG_HOME/bin
fi
source $ZPLUG_HOME/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

export ZPLGM[HOME_DIR]=$ZPLUG_HOME

zplugin light "zsh-users/zsh-syntax-highlighting"
zplugin light "zsh-users/zsh-completions"
# zplugin light "yonchu/zsh-vcs-prompt"
# zplugin light "seebi/dircolors-solarized"
zplugin light "Vifon/fasd" 
zplugin light "zsh-users/zsh-history-substring-search"
zplugin light "zsh-users/zaw"
# zplugin light "yonchu/zaw-src-git-log", on:"zsh-users/zaw"
# zplugin light "yonchu/zaw-src-git-show-branch", on:"zsh-users/zaw"
zplugin light "mafredri/zsh-async"
zplugin light "knu/zsh-git-escape-magic"
zplugin light "coldfix/zsh-soft-history" 
zplugin light "PythonNut/auto-fu.zsh" 
# zplugin light "mortang2410/auto-fu.zsh" 
# zplugin light "PythonNut/zsh-autosuggestions"
zplugin light "zsh-users/zsh-autosuggestions"


# zplug "marszall87/lambda-pure"
# export PURE_NODE_ENABLED=0


