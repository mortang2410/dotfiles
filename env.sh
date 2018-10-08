export PATH=$HOME/.gem/ruby/2.5.0/bin:$HOME/.scripts:$HOME/localpath:$HOME/.local/usr/bin:$HOME/.local/bin:$PATH:$HOME/build/dasht/bin
export MANPATH=$HOME/.local/share/man:$MANPATH:$HOME/build/dasht/man
export JAVA_FONTS=/usr/share/fonts/TTF
export COWPATH=/usr/share/cowsay/cows:~/cows/
export KDEDIRS=/usr/local/:$HOME/build/kdevelop_platform_combined_bin/:$KDEDIRS
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib 
export MYPYPATH="/usr/lib/python36.zip:/usr/lib/python3.6:/usr/lib/python3.6/lib-dynload"
export XDG_CACHE_HOME=~/.cache
if [[ -f $HOME/build/dasht/etc/zsh/completions.zsh ]]; then
    source $HOME/build/dasht/etc/zsh/completions.zsh 
fi
