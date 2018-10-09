# ========================================
# Title + Path compression + chpwd handler
# ========================================

function chpwd_async_worker () {
  emulate -LR zsh
  TRAPTERM () {
    kill -INT $$
  }

  local chpwd_minify_fasd_str="$(minify_path_fasd $1)"
  local chpwd_minify_full_str="$(minify_path_full $1)"
  local chpwd_minify_smart_str="$(minify_path_smart $chpwd_minify_full_str)"

  typeset -p chpwd_minify_smart_str
  typeset -p chpwd_minify_fasd_str
}

function chpwd_callback {
  emulate -LR zsh -o prompt_subst -o transient_rprompt

  # Clear the timeout entry
  local -i sched_id
  sched_id=${zsh_scheduled_events[(i)*:*:prompt_async_timeout]}
  sched -$sched_id &> /dev/null

  {
    disable -r typeset
    # force variables to go up scope
    typeset() { builtin typeset -g "$@"; }
    eval $3
  } always {
    unset -f typeset 2>/dev/null
    enable -r typeset
  }

  zle && zle reset-prompt
  title_async_compress
}

async_start_worker chpwd_worker -u
async_register_callback chpwd_worker chpwd_callback

function prompt_async_timeout () {
  echo chpwd compressor timed out! >> $ZDOTDIR/startup.log
  async_flush_jobs chpwd_worker

  async_stop_worker chpwd_worker
  async_start_worker chpwd_worker -u
  async_register_callback chpwd_worker chpwd_callback
}

function prompt_async_compress () {
  emulate -LR zsh -o prompt_subst -o transient_rprompt
  # check if we're running under Midnight Commander
  if (( $degraded_terminal[decorations] == 1 )); then
    chpwd_minify_smart_str=${${:-.}:A:t}
    zle && zle reset-prompt
  else
    chpwd_minify_fasd_str=""
    chpwd_minify_fast_str="$(minify_path .)"
    chpwd_minify_smart_str="$(minify_path_smart $chpwd_minify_fast_str)"
    async_job chpwd_worker chpwd_async_worker ${${:-.}:A}
    sched +10 prompt_async_timeout
  fi
}

add-zsh-hook chpwd prompt_async_compress
prompt_async_compress
