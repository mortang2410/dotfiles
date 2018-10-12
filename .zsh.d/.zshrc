# 10ms for key sequences 
KEYTIMEOUT=1 
source ~/env.sh
export ZDOTDIR=~/.zsh.d

BORING_FILES='*\~|*.elc|*.pyc|!*|_*|*.swp|*.zwc|*.zwc.old|*.synctex.gz'
#
#

setopt nomenucomplete
setopt extendedglob
unsetopt caseglob
setopt GLOB_DOTS


export ZPLUG_HOME=$ZDOTDIR/.zplugin
if [[ ! -d $ZPLUG_HOME ]]; then
  mkdir -p $ZPLUG_HOME
  git clone https://github.com/zdharma/zplugin.git $ZPLUG_HOME/bin
fi
source $ZPLUG_HOME/bin/zplugin.zsh

autoload -U compinit promptinit
autoload -Uz zkbd                # automatic keybinding detection
#### never load compinit twice as it is slow. Zplugin already loads compinit anyway.
# # compinit
# # promptinit

zmodload zsh/complist



function global_bindkey () {
  bindkey -M command $@
  bindkey -M emacs   $@
  bindkey -M main  $@
  # bindkey -M afu   $@
  bindkey      $@
}

global_bindkey "^Hk" describe-key-briefly


source $ZDOTDIR/modules/env.zsh
source $ZDOTDIR/modules/smart_completion.zsh
source $ZDOTDIR/modules/zstyle.zsh




# zstyle ':completion:*' matcher-list                                      \
#     '                                   m:{[:lower:]}={[:upper:]}' \
#     '                                   m:{[:lower:]\-}={[:upper:]_}' \
#     'r:[^[:alpha]]||[[:alpha]]=** r:|=* m:{[:lower:]\-}={[:upper:]_}' \
#     'r:|?=**                            m:{[:lower:]\-}={[:upper:]_}'



#
# export ZPLGM[HOME_DIR]=$ZPLUG_HOME
#
zplugin light "zsh-users/zsh-syntax-highlighting"
zplugin light "zsh-users/zsh-completions"
# # zplugin light "yonchu/zsh-vcs-prompt"
# # zplugin light "seebi/dircolors-solarized"
#
zplugin ice as"program"
zplugin light "Vifon/fasd" 
#
# zplugin light "zsh-users/zsh-history-substring-search"
#
zplugin light "zsh-users/zaw"
# # zplugin light "yonchu/zaw-src-git-log", on:"zsh-users/zaw"
# # zplugin light "yonchu/zaw-src-git-show-branch", on:"zsh-users/zaw"
# zplugin light "mafredri/zsh-async"
# zplugin light "knu/zsh-git-escape-magic"
# zplugin light "coldfix/zsh-soft-history" 
#
# zplugin light "PythonNut/auto-fu.zsh" 
# # zplugin light "mortang2410/auto-fu.zsh" 
# # zplugin light "PythonNut/zsh-autosuggestions"
#
zplugin light "zsh-users/zsh-autosuggestions"
#

# zplug "marszall87/lambda-pure"
# export PURE_NODE_ENABLED=0




# setup auto-fu.zsh, which autocompletes on the fly
# autofu_file="~/auto-fu.zsh"
# if [[ -f ~/auto-fu.zsh ]]; then
#     if [[ ! -f ~/.zsh/auto-fu || ! -f ~/.zsh/auto-fu.zwc ]]; then
#         echo love
#         source ~/auto-fu.zsh 
#         auto-fu-zcompile ~/auto-fu.zsh  ~/.zsh
#     fi
# fi


## setting editor
export EDITOR='nvim'
export VISUAL=$EDITOR
alias vim=$EDITOR
alias vi=$EDITOR
alias vimdiff='$EDITOR -d'
alias nvims='NVIM_LISTEN_ADDRESS=/tmp/vimtex nvim'
alias gvimr='gvim --remote'
alias vims='vim --servername vim'

# make aliases work with sudo
alias sudo='sudo '

# sync with unison
alias zsync_wiki='unison -ui text vimwiki ssh://linode/vimwiki'

## tabbed zathura function

pastebin () { curl -F "c=@${1:--}" https://ptpb.pw/ }
alias pdfzip='gs -dEmbedAllFonts=true -dCompatibilityLevel=1.5 -dAutoRotatePages=/None -dQUIET -sDEVICE=pdfwrite -o out.pdf'
alias zinstall='sudo apt-fast -y install'
alias zaudio='sudo chmod 777 /dev/snd -R; pulseaudio -k; pulseaudio --start'
alias zup='sudo apt-fast -y dist-upgrade'
alias beep='paplay /usr/share/sounds/KDE-Im-Irc-Event.ogg'
alias myebwin='env LANG=ja_JP.utf8 wine "$HOME/.wine/drive_c/Program Files/EBWin/EBWin.exe"'
alias mylatex='latexmk -pdf -pvc'
alias tmux='tmux -2'
alias grepc='grep -i --color=always'
alias lsc='ls --color=always --group-directories-first -a'
alias mysu="su -c \"ZDOTDIR=$HOME zsh\""
alias emat='emacs --daemon &!'
alias reload='source ~/.zshrc'
alias e='emacsclient -t' 
alias im='sxiv'
alias lim='ls -tr *(.) |  sxiv -iao'
alias dstat1='dstat --top-io-adv --top-cpu-adv --top-cputime --top-latency --top-mem --top-oom '
alias dstat2='dstat -af -m '
alias zstart='sudo systemctl start'
alias zstop='sudo systemctl stop'
alias ztray='wmsystemtray --non-wmaker --bgcolor white &!'
alias zoff='xset dpms force off'
alias urlz='urlscan -c -r "firefox {}"'
alias python='python3'
alias pip='pip3'
alias zs='sublime_text'
alias xclipz='xclip -sel clip'
dotfilesgit() {
    export GIT_DIR=$HOME/.cfg/ 
    export GIT_WORK_TREE=$HOME 
    git add ~/.vim ~/.scripts ~/.zsh.d ~/.config/ranger
    if [[ -n "$TMUX" ]]; then
        ztmux-set-title DOTFILESGIT
    fi
}

# set title of tmux
ztmux-set-title() {
    printf "\033k$1\033\\"
}
# dot file edit function
function edlink {
    [[ -z $1 ]] && return
    f=$(readlink -f $1)
    cd ${f%/*}
    ${EDITOR:-vi} $f
    cd - > /dev/null;
}
alias ztmux-close='tmux kill-session'
# dot file aliases
alias edbash='edlink $HOME/.bashrc; if [ "$(echo $BASH_VERSION)" ]; then source $HOME/.bashrc; fi'
alias edzsh='edlink $HOME/.zshrc; if [ "$(echo $ZSH_VERSION)" ]; then source $HOME/.zshrc; fi'
alias edvim='edlink $HOME/.vimrc'
alias edgvim='edlink $HOME/.gvimrc'
alias ednvim='edlink $HOME/.config/nvim/init.vim'
alias edtmux='edlink $HOME/.tmux.conf'
alias edi3='edlink $HOME/.config/i3/config'
alias edi3status='edlink $HOME/.i3status.conf'
alias edi3blocks='edlink $HOME/.i3blocks.conf'
alias edtermite='edlink $HOME/.config/termite/config'
alias edxresources='edlink $HOME/.Xresources; xrdb $HOME/.Xresources'
alias edxinit='edlink $HOME/.xinitrc'
alias edbspwm='edlink $HOME/.config/bspwm/bspwmrc'
alias edsxhkd='edlink $HOME/.config/sxhkd/sxhkdrc'
alias eddunst='edlink $HOME/.config/dunst/dunstrc; killall dunst; (dunst &)'
alias edzprofile='edlink $HOME/.zprofile'
alias edprofile='edlink $HOME/.profile'
alias edbashprofile='edlink $HOME/.bash_profile'
alias edcompton='edlink $HOME/.config/compton.conf'
alias edpolybar='edlink $HOME/.config/polybar/config'
alias edrofi='edlink $HOME/.config/rofi/config'
alias edalacritty='edlink $HOME/.config/alacritty/alacritty.yml'
alias edzathura='edlink $HOME/.config/zathura/zathurarc'
alias edranger='edlink $HOME/.config/ranger/rc.conf'
alias checkinstall='checkinstall -D --install'

alias zpandoc_latex='pandoc --template ~/.pandoc/templates/eisvogel.tex'
alias zgollum_commit='cd ~/vimwiki; git add .; git commit -am "Changes"'

#ranger exit with cd 
zr() {
    ranger --choosedir=$HOME/.rangerdir "$@";
    LASTDIR=`cat $HOME/.rangerdir`;
    cd "${$LASTDIR}";
}


ec() {emacsclient -c "$*" &!; }
run() {xdg-open "$*" &!;}

remakedwm() {cd ~/dwm; makepkg -efi --skipinteg; }


#custom functions for myself
normalize_audio() {
	for var in "$@"
	do
		name=$(print $var(:r))
		ffmpeg-normalize $var -c:a aac -b:a 192k -o $name.new.m4a  		
	done
}

trim50() {
	for x in "$@"
	do
        integer z=$(($(wc -l <$x)/2)) ;
        sed -i -e 1,$[z]d $x ;
    done
}

# now i just use nvim as manpager
# thanks magic function from Adam Byrtek
man() {
    /usr/bin/man "$@" | \
        col -b | \
        vim -R -c 'set ft=man nomod nolist' -
}


if [[ -n $(whence vimpager)  ]]; then
  	export PAGER=vimpager
  	alias less=$PAGER
	alias zless=$PAGER
fi


#add git submodule to dotfilesgit
dotf-addmodule(){
for x in "$@"
do
    if [ -d "${x}/.git" ] ; then
    cd "${x}"
    origin="$(git config --get remote.origin.url)"
    cd - 1>/dev/null
	dotfilesgit
	git rm --cached "${x}"
	git submodule add "${origin}" "${x}"
    fi
done
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#### use zplugin now which loads this.
# if [[ ! -f  $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
#     git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/zsh-syntax-highlighting
# fi
#
# source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# if [[ -n $(whence fasd)  ]] eval "$(fasd --init auto)"

export FZF_COMPLETION_TRIGGER='**'

if [[ -n $(whence fd)  ]]; then
    export FZF_DEFAULT_COMMAND='fd --type f --color=never --no-ignore -H'
    export FZF_ALT_C_COMMAND='fd --type d . --color=never --no-ignore -H'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    alias zfd='fd --no-ignore -H'
fi
if [[ -n $(whence rg)  ]]; then
    alias zrg='rg --no-ignore --hidden'
fi

# WSL stuff

alias zwiki_view='firefox $(wslpath -w ~/vimwiki_html/index.html)'

# world clocks
ztime() {
for x in "Asia/Ho_Chi_Minh"  "Australia/Perth" "America/Los_Angeles" 
do
    print $x " \: " $(TZ=$x date)
done
}
#motd for ubuntu
zmotd_ubuntu() {
for i in /etc/update-motd.d/*; 
do 
    if [ "$i" != "/etc/update-motd.d/98-fsck-at-reboot" ]; then $i; fi; 
done
}


### ${KEYMAP}<tab> to see the current keymap. Using autofu, so that is 'afu'.
# Normal mode keybindings, please put some more.\
bindkey -v
bindkey '^P' up-history
bindkey -v "^?" backward-delete-char
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line


# #fix home/end. 
# # Use cat -v to figure what what home/end keys map to. 
# # If Home gives ^[[7~, we replace ^[ by \e and get \e[7~. 
# if [[ -n "$TMUX" ]]; then
# 	bindkey -M afu "\e[7~" beginning-of-line
# 	bindkey -M afu "\e[8~" end-of-line
# fi


PROMPT='%F{red}%n%f@%F{blue}%m%f  %F{yellow}%1~%f 
%# '
RPROMPT='[ %F{yellow}%?%f]'
unsetopt MULTIBYTE
source ~/.zsh.d/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}


stty -ixon
# Make menu selection a liveable place
#
bindkey -M menuselect '^F' accept-and-infer-next-history
bindkey -M menuselect 'i' accept-and-infer-next-history
bindkey -M menuselect '^?' undo
bindkey -M menuselect ' ' accept-and-hold
bindkey -M menuselect '/' history-incremental-search-forward
bindkey -M menuselect '?' history-incremental-search-backward
bindkey -M menuselect ${key[PageDown]} forward-word
bindkey -M menuselect ${key[PageUp]} backward-word
bindkey -M menuselect 'v' vi-insert

global_bindkey '^X;' zaw
global_bindkey '^Xe' edit-command-line
global_bindkey '^X^E' edit-command-line

global_bindkey  '^T' fzf-completion    
# global_bindkey  '^I' complete-word
global_bindkey  '^R' fzf-history-widget 
global_bindkey  '^[c' fzf-cd-widget
bindkey -e
