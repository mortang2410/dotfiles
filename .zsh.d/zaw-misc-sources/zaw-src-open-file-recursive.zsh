function zaw-src-open-file-recursive() {
  local root parent f
  setopt local_options null_glob glob_dots
  if (( $# == 0 )); then
    root="${PWD}/"
  else
    root="$1"
  fi
  parent="${root:h}"
  if [[ "${parent}" != */ ]]; then
    parent="${parent}/"
  fi
  candidates+=("${parent}")
  cand_descriptions+=("../")
  for f in "${root%/}"/**/*; do
    candidates+=("${f#${${:-.}:A}/}")
    cand_descriptions+=("${f#${${:-.}:A}/}")
  done
  actions=( "zaw-callback-append-to-buffer" "zaw-callback-open-file" )
  act_descriptions=( "append to edit buffer" "open file or directory" )
  # TODO: open multiple files
  #options=( "-m" )
  options=( "-t" "${root}" )
}

zaw-register-src -n open-file-recursive zaw-src-open-file-recursive
