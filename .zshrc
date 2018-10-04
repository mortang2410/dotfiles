# Created by newuser for 4.
autoload -U compinit promptinit
compinit
promptinit

source ~/env.sh


zstyle ':completion:*' menu select
zstyle ':completion:*' completer _expand _complete _match
zstyle -e ':completion:*' list-colors 'thingy=${PREFIX##*/} reply=( "=(#b)($thingy)(?)*=00=$color[green]=$color[bg-green]" )'
setopt extendedglob
unsetopt caseglob
setopt GLOB_DOTS

# 10ms for key sequences 
KEYTIMEOUT=1 

## setting editor
export EDITOR='nvim'
export VISUAL=$EDITOR
alias vim=$EDITOR
alias vi=$EDITOR
alias vimdiff='$EDITOR -d'
alias nvims='NVIM_LISTEN_ADDRESS=/tmp/vimtex nvim'
alias gvimr='gvim --remote'
alias vims='vim --servername vim'
alias sudo='sudo '

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
alias dotfilesgit='export GIT_DIR=$HOME/.cfg/; export GIT_WORK_TREE=$HOME; git add ~/.vim ~/.scripts'

# dot file edit function
function edlink {
    [[ -z $1 ]] && return
    f=$(readlink -f $1)
    cd ${f%/*}
    ${EDITOR:-vi} $f
    cd - > /dev/null;
}
# dot file aliases
alias edbash='edlink $HOME/.bashrc; if [ "$(echo $BASH_VERSION)" ]; then source $HOME/.bashrc; fi'
alias edzsh='edlink $HOME/.zshrc; if [ "$(echo $ZSH_VERSION)" ]; then source $HOME/.zshrc; fi'
alias edvim='edlink $HOME/.vim/vimrc'
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
# make aliases work with sudo


#ranger exit with cd 
zr() {
    ranger --choosedir=$HOME/.rangerdir "$@";
    LASTDIR=`cat $HOME/.rangerdir`;
    cd "$LASTDIR";
}


ec() {emacsclient -c "$*" &!; }
run() {xdg-open "$*" &!;}


##fuzzy completion, case insensitive
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' matcher-list                                      \
    '                                   m:{[:lower:]}={[:upper:]}' \
    '                                   m:{[:lower:]\-}={[:upper:]_}' \
    'r:[^[:alpha]]||[[:alpha]]=** r:|=* m:{[:lower:]\-}={[:upper:]_}' \
    'r:|?=**                            m:{[:lower:]\-}={[:upper:]_}'
add-zsh-hook precmd zdelicious
unset LESS
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
zdelicious() {

p_shlvlhist="%fzsh%(2L./$SHLVL.) %B%h%b "
p_rc="%(?..[%?%1v] )"
p_vcs="%(2v.%U%2v%u.)"
local prompt_pwd_size=$(( COLUMNS - 50 ))
PROMPT=$'

%{\e[1;38m%}'${MACHTYPE}/${OSTYPE}/$(uname -r)$'   %{\e[0;33m%}'%D{"%a %b %d,%I:%M"}%b$'%{\e[0m%}

%{\e[0;34m%}%B┌─[%b%{\e[0m%}%{\e[1;38m%}%n%{\e[1;38m%}@%{\e[0m%}%{\e[0;36m%}%m%{\e[0;34m%}%B]%b%{\e[0;34m%}%B─[%{\e[1;35m%}'$p_shlvlhist$p_rc$p_vcs$'%{\e[0;34m%}%B]%b%{\e[0;34m%}%B─%{\e[0;34m%}%B[%b%{\e[0;34m%}%'$prompt_pwd_size$'<...<%~%<<%{\e[0;34m%}%B]
└─%{\e[0;34m%}%B[%{\e[1;35m%}%#%{\e[0;34m%}%B]>%{\e[0m%}%b '

PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '

}


#fix ls for the solarized theme
eval `dircolors ~/.dircolors`

preexec () {
    if [[ "$TERM" == "screen" ]]; then
    local CMD=${1[(wr)^(*=*|sudo|-*)]}
    echo -n "\ek$CMD\e\\"
    fi
}




export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;37m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

export OOO_FORCE_DESKTOP="gnome"


export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
# export _JAVA_OPTIONS='-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel' 
# export _JAVA_OPTIONS='-Dswing.defaultlaf=javax.swing.plaf.metal.MetalLookAndFeel'
# export _JAVA_OPTIONS =$_JAVA_OPTIONS ' -Dawt.useSystemAAFontSettings=gasp'
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
# export _JAVA_OPTIONS ="-Dawt.useSystemAAFontSettings=on"


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

if [[ -n "$TMUX" ]]; then
	bindkey -e '"\e[1~":"\e[7~"'
	bindkey -e '"\e[4~":"\e[8~'
fi

#add git submodule to dotfilesgit
dotf-addmodule(){
for x in "$@"
if [ -d "${x}/.git" ] ; then
    cd "${x}"
    origin="$(git config --get remote.origin.url)"
    cd - 1>/dev/null
	dotfilesgit
	git rm --cached "${x}"
	git submodule add "${origin}" "${x}"
fi
}
zmodload zsh/zpty
stty stop undef

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if [[ -n $(whence fasd)  ]] eval "$(fasd --init auto)"

export FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion    
bindkey '^I' complete-word
