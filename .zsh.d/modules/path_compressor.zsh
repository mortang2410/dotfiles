# ================
# path compressors
# ================

# Reduce path to shortest prefixes. Heavily Optimized
function minify_path () {
  emulate -LR zsh -o glob_dots -o extended_glob
  local full_path="/" ppath cur_path dir glob
  local -a revise
  local -i matches col
  for token in ${(s:/:)${1:A}/${HOME:A}/\~}; do
    cur_path=${full_path:s/\~/$HOME/}
    col=1
    glob="${token[0,1]}"
    cur_path=($cur_path/*(/))
    # prune the single dir case
    if [[ $#cur_path == 1 ]]; then
      ppath+="/"
      full_path=${full_path%%(/##)}/$token
      continue
    fi
    while; do
      matches=0
      revise=()
      for fulldir in $cur_path; do
        dir=${${fulldir%%/}##*/}
        if (( ${#dir##(#l)($glob)} < $#dir )); then
          ((matches++))
          revise+=$fulldir
          if (( matches > 1 )); then
            break
          fi
        fi
      done
      if (( $matches > 1 )); then
        glob=${token[0,$((col++))]}
        if (( $col -1 > $#token )); then
          break
        fi
      else
        break
      fi
      cur_path=($revise)
    done
    ppath+="/$glob"
    full_path=${full_path%%(/##)}
    full_path+="/$token"
  done
  echo ${${ppath:s/\/\~/\~/}:-/}
}

function zsh_run_with_timeout () {
  setopt local_options no_monitor
  (eval $2) &
  local PID=$! START_TIME=$SECONDS MTIME=$(zstat '+mtime' /proc/$!)
  while true; do
    sleep 0.001
    # TODO: This probably isn't portable
    if [[ ! -d /proc/$PID || $(zstat '+mtime' /proc/$PID) != $MTIME ]]; then
      break
    fi
    if (( $SECONDS - $START_TIME > $1 )); then
      {
        kill $PID
        wait $PID
      } 2> /dev/null
      break
    fi
  done
}

typeset -A zsh_minify_path_cache
ZSH_MINIFY_PATH_CACHE_FILE=$ZDOTDIR/.minify-path.cache

# take every possible branch on the file system into account
function minify_path_full () {
  zparseopts -D -E d=DEBUG
  emulate -LR zsh -o extended_glob -o null_glob -o glob_dots
  local glob temp_glob result official_result seg limit
  fullpath=${${1:A}/${HOME:A}/\~}
  glob=("${(@s:/:)fullpath}")

  local -i index=$(($#glob)) k

  temp_glob=("${(s/ /)glob//(#m)?/$MATCH*}")
  temp_glob="(#l)"${${(j:/:)temp_glob}/\~\*/$HOME}(/oN)
  official_result=(${~temp_glob})

  # open the cache file
  if [[ ! -f $ZSH_MINIFY_PATH_CACHE_FILE ]]; then
    touch $ZSH_MINIFY_PATH_CACHE_FILE
    zsh_minify_path_cache=()
  fi

  source $ZSH_MINIFY_PATH_CACHE_FILE

  local test_glob=("${(@)glob}")
  local test_path=${(@j:/:)test_glob}
  if (( ${+zsh_minify_path_cache[$test_path]} )); then
    # verify the cache hit:
    local -a cache_glob=("${(@s:/:)zsh_minify_path_cache[$test_path]}")
    temp_glob=("${(s/ /)cache_glob//(#m)?/$MATCH*}")
    temp_glob="(#l)"${${(j:/:)temp_glob}/\~\*/$HOME}(/oN)
    if [[ -n $DEBUG ]]; then
      echo Testing cached: $temp_glob
    fi
    result=($(zsh_run_with_timeout 0.3 "setopt glob_dots extended_glob; echo $temp_glob"))
    if [[ $result == $official_result ]]; then
      glob=("${(@)cache_glob}")
    fi
  fi

  # set glob short circuit level
  limit="(/Y$(( ${#official_result} + 1 )))"

  while ((index >= 1)); do
    if [[ ${glob[$index]} == "~" ]]; then
      break
    fi
    k=${#glob[$index]}
    old_glob=${glob[$index]}
    while true; do
      seg=$glob[$index]
      temp_glob=("${(s/ /)glob//(#m)?/$MATCH*}")
      temp_glob="(#l)"${${(j:/:)temp_glob}/\~\*/$HOME}
      temp_glob+=$limit
      result=($(zsh_run_with_timeout 0.3 "setopt glob_dots extended_glob; echo $temp_glob"))
      if [[ $result != $official_result ]]; then
        glob[$index]=$old_glob
        seg=$old_glob
      else
        # if we succeeded, try smart casing
        if [[ ${${glob[$index]}[$k]} == [[:upper:]] ]]; then
          old_glob=$glob[$index]

          temp_glob=$old_glob
          temp_glob[$k]=${temp_glob[$k]:l}
          glob[$index]=$temp_glob
          continue
        fi
      fi

      if (( $k == 0 )); then
        break
      fi

      old_glob=${glob[$index]}
      glob[$index]=$seg[0,$(($k-1))]$seg[$(($k+1)),-1]
      ((k--))
      if [[ -n $DEBUG ]]; then
         echo ${(j:/:)glob}
      fi
    done
    ((index--))
  done

  local return=${(j:/:)glob}
  zsh_minify_path_cache[$fullpath]=$return
  typeset -p zsh_minify_path_cache > $ZSH_MINIFY_PATH_CACHE_FILE

  echo $return
}

# collapse empty runs too
function minify_path_smart () {
  emulate -LR zsh -o brace_ccl -o extended_glob
  echo ${${1//(#m)\/\/##/%U${#MATCH}%u}//(#m)\/[^0-9]/%U${MATCH#/}%u}
}

# find shortest unique fasd prefix. Heavily optimized
function minify_path_fasd () {
  zparseopts -D -E a=ALL
  setopt local_options extended_glob
  if ! (( $+commands[fasd] )); then
    printf ""
    return
  fi

  1=${${1:A}%/}
  if [[ $1 == ${${:-~}:A} ]]; then
    printf ""
    return
  fi


  local dirs=("${(@f)$(fasd -l)}")
  if ! (( ${+dirs[(r)$1]} )); then
    printf ""
    return 1
  fi

  local index=${${${dirs[$((${dirs[(i)$1]}+1)),-1]}%/}##*/}
  local minimal_path=$1:t i
  for ((i=0; i<=$#minimal_path+1; i++)); do
    for ((k=1; k<=$#minimal_path-$i; k++)); do
      test=${minimal_path[$k,$(($k+$i))]}
      if [[ -z ${index[(r)*$test*]} ]]; then
        if [[ $(type $test) == *not* && -z ${(P)temp} || -n $ALL ]]; then
          echo $test
          return
        fi
      fi
    done
  done

  index=(${${dirs[$((${dirs[(i)$1]}+1)),-1]}%/})
  minimal_path=${1//\//\ }
  for i in {1..$#minimal_path}; do
    local temp=$minimal_path[$i]
    minimal_path[$i]=" "
    if [[ -n "$index[(r)*${minimal_path// ##/*}*]" ]]; then
      minimal_path[$i]=$temp
    fi
  done
  echo "${${${minimal_path// ##/ }%%[[:space:]]#}##[[:space:]]#}"
}
