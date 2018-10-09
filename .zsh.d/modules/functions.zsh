# =============
# Adaptive Exit
# =============
integer _exitForce=0

# exit with background jobs lists them
# use logout for normal exit or EXIT
function disown_running() {
  emulate -LR zsh
  local running_jobs

  # disown running jobs
  running_jobs=${${${(@f)"$(jobs -r)"}/\[/%}%%\]*}
  if [[ -n "$running_jobs" ]]; then
    disown $running_jobs
  fi
  
  # check for remaining jobs
  # returns 1 if jobs still remaining, else 0
  if [[ -n $(jobs) ]]; then
    return 1
  else
    return 0
  fi
}

add-zsh-hook zshexit disown_running

function exit() {
  emulate -LR zsh
  if [[ $_ZSH_PARENT_CMDLINE == (tmux*) ]]; then
    if (( ${#${(f)"$(tmux list-clients)"}} > 1 )); then
      if (( ${#${(f)"$(tmux list-windows)"}} == 1 )); then
        echo Detaching from tmux session...
        tmux detach
        return 0
      fi
    fi
  fi

  disown_running && builtin exit "$@"
  if [[ $_exitForce == $(fc -l) ]]; then
    builtin exit
  else
    echo "You have stopped jobs:"
    jobs
    _exitForce=$(fc -l)
  fi
}

alias EXIT="builtin exit"

# =====================
# Convenience functions
# =====================

# recursive Regex ls
function lv() {
  emulate -LR zsh
  local p=$argv[-1]
  [[ -d $p ]] && { argv[-1]=(); } || p='.'
  find $p ! -type d | sed 's:^./::' | egrep "${@:-.}"
}
alias -E lv="noglob lv"

# super powerful ls
function lr() {
  zparseopts -D -E S=S t=t r=r h=h U=U l=l F=F d=d
  local sort="sort -t/ -k2"                                # by name (default)
  local numfmt="cat"
  local long='s:[^/]* /::; s:^\./\(.\):\1:;'               # strip detail
  local classify=''
  [[ -n $F ]] && classify='/^d/s:$:/:; /^-[^ ]*x/s:$:*:;'  # dir/ binary*
  [[ -n $l ]] && long='s: /\./\(.\): \1:; s: /\(.\): \1:;' # show detail
  [[ -n $S ]] && sort="sort -n -k5"                        # by size
  [[ -n $r ]] && sort+=" -r"                               # reverse
  [[ -n $t ]] && sort="sort -k6" && { [[ -n $r ]] || sort+=" -r" } # by date
  [[ -n $U ]] && sort=cat                                  # no sort, live output
  [[ -n $h ]] && numfmt="numfmt --field=5 --to=iec --padding=6"  # human fmt
  [[ -n $d ]] && set -- "$@" -prune                        # don't enter dirs
  find "$@" -printf "%M %2n %u %g %9s %TY-%Tm-%Td %TH:%TM /%p -> %l\n" |
  $=sort | $=numfmt |
  sed '/^[^l]/s/ -> $//; '$classify' '$long
}

# search for process without matching self
alias -E px="nocorrect noglob px"
function px() {
  emulate -LR zsh
  ps uwwp ${$(pgrep -d, "${(j:|:)@}"):?no matches}
}

# extract any archive 
compdef '_files -g "*.((tar|)(.gz|.bz2|.xz|.zma)|(t(gz|bz|bz2|lz|xz))|(lzma|Z|zip|rar|7z|deb)|tar)"'  extract
function extract() {
  emulate -LR zsh
  local remove_archive
  local success
  local file_name
  local extract_dir

  if (( $# == 0 )); then
    echo "Usage: extract [-option] [file ...]"
    echo
    echo Options:
    echo "    -r, --remove    Remove archive."
    echo
    echo "Report bugs to <sorin.ionescu@gmail.com>."
  fi

  remove_archive=1
  if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
    remove_archive=0
    shift
  fi

  while (( $# > 0 )); do
    if [[ ! -f "$1" ]]; then
      echo "extract: '$1' is not a valid file" 1>&2
      shift
      continue
    fi

    success=0
    file_name="$( basename "$1" )"
    extract_dir="$( echo "$file_name" | sed "s/\.${1##*.}//g" )"
    case "$1" in
      (*.tar.gz|*.tgz) tar xvzf "$1" ;;
      (*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
      (*.tar.xz|*.txz) tar --xz --help &> /dev/null \
        && tar --xz -xvf "$1" \
        || xzcat "$1" | tar xvf - ;;
      (*.tar.zma|*.tlz) tar --lzma --help &> /dev/null \
        && tar --lzma -xvf "$1" \
        || lzcat "$1" | tar xvf - ;;
      (*.tar) tar xvf "$1" ;;
      (*.gz) gunzip "$1" ;;
      (*.bz2) bunzip2 "$1" ;;
      (*.xz) unxz "$1" ;;
      (*.lzma) unlzma "$1" ;;
      (*.Z) uncompress "$1" ;;
      (*.zip) unzip "$1" -d $extract_dir ;;
      (*.rar) unrar e -ad "$1" ;;
      (*.7z) 7za x "$1" ;;
      (*.deb)
        mkdir -p "$extract_dir/control"
        mkdir -p "$extract_dir/data"
        cd "$extract_dir"; ar vx "../${1}" > /dev/null
        cd control; tar xzvf ../control.tar.gz
        cd ../data; tar xzvf ../data.tar.gz
        cd ..; rm *.tar.gz debian-binary
        cd ..
        ;;
      (*)
        echo "extract: '$1' cannot be extracted" 1>&2
        success=1
        ;;
    esac
    
    (( success = $success > 0 ? $success : $? ))
    (( $success == 0 )) && (( $remove_archive == 0 )) && rm "$1"
    shift
  done
}

function mv-edit() {
  local src dst
  for src; do
    [[ -e $src ]] || { print -u2 "$src does not exist"; continue }
    dst=$src
    vared dst
    [[ $src != $dst ]] && mkdir -p $dst:h && mv -n $src $dst
  done
}

function wc-counter() {
  local -i count=0
  while read -r line ; do
    ((count++))
    echo -ne "\r$count"
  done
  echo
}

function mcd() {
  mkdir -p $1
  cd $1
}

function ix() {
  curl -F 'f:1=<-' ix.io
}
