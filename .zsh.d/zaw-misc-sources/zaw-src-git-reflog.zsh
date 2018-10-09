# heavily derived from 
# https://github.com/yonchu/zaw-src-git-log

ZAW_SRC_GIT_LOG_REFLOG_FORMAT="%gd | %gs [%an]"

function zaw-src-git-reflog () {
  # Check git directory.
  git rev-parse -q --is-inside-work-tree > /dev/null 2>&1 || return 1

  # Set up option.
  local -a opt
  opt=("--pretty=format:%h $ZAW_SRC_GIT_LOG_REFLOG_FORMAT")
  if [ "$ZAW_SRC_GIT_LOG_NO_ABBREV" != 'false' ]; then
    opt+=('--no-abbrev')
  fi
  if [ $ZAW_SRC_GIT_LOG_MAX_COUNT -gt 0 ]; then
    opt+=("--max-count=$ZAW_SRC_GIT_LOG_MAX_COUNT")
  fi

  # Get git log.
  local log="$(git log "${opt[@]}" -g)"

  # Set candidates.
  candidates+=(${(f)log})
  actions=("zaw-src-git-reflog-append-to-buffer")
  act_descriptions=("git-reflog for zaw")
  # Enable multi marker.
  options+=(-m)
}

# Action function.
function zaw-src-git-reflog-append-to-buffer () {
  local list
  local item
  for item in "$@"; do
    list+="$(echo "$item" | cut -d' ' -f2) "
  done
  set -- $list

  local buf=
  if [ $# -eq 2 ]; then
    # To diff.
    buf+="$1..$2"
  else
    # 1 or 3 or more items.
    buf+="${(j: :)@}"
  fi

  # escape brackets, since they're caught by extended_blog
  buf=${${buf:gs/\{/\\\{}:gs/\}/\\\}}
  
  # Append left buffer.
  LBUFFER+="$buf"
}

zaw-register-src -n git-reflog zaw-src-git-reflog
