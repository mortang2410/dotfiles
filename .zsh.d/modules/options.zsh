# ===========
# ZSH options
# ===========

{
  # general
  setopt zle                    # magic stuff
  setopt no_beep                # beep is annoying
  setopt rm_star_wait           # are you REALLY sure?
  setopt auto_resume            # running a suspended program
  setopt check_jobs             # check jobs before exiting
  setopt auto_continue          # send CONT to disowned processes
  setopt function_argzero       # $0 contains the function name
  setopt interactive_comments   # shell comments (for presenting)

  # completion
  setopt auto_list              # list if multiple matches
  setopt complete_in_word       # complete at cursor
  setopt menu_complete          # add first of multiple
  setopt auto_remove_slash      # remove extra slashes if needed
  setopt auto_param_slash       # completed directory ends in /
  setopt auto_param_keys        # smart insert spaces " "
  setopt list_packed            # conserve space

  # globbing
  setopt numeric_glob_sort      # sort globs numerically
  setopt extended_glob          # awesome globs
  setopt ksh_glob               # allow modifiers before regex ()
  setopt no_case_glob           # lazy case for globs
  setopt glob_dots              # don't require a dot
  setopt glob_star_short        # **.c ==> **/*.c
  setopt no_case_match          # lazy case for regex matches
  setopt bare_glob_qual         # can use qualifirs by themselves
  setopt mark_dirs              # glob directories end in "/"
  setopt list_types             # append type chars to files
  setopt null_glob              # don't err on null globs
  setopt brace_ccl              # extended brace expansion

  # history
  setopt hist_reduce_blanks     # collapse extra whitespace
  setopt hist_ignore_space      # ignore lines starting with " "
  setopt hist_ignore_dups       # ignore immediate duplicates
  setopt hist_find_no_dups      # ignore all search duplicates
  setopt hist_subst_pattern     # allow pattern substitutions
  setopt extended_history       # timestamps are nice, really
  setopt append_history         # append is good, append!
  setopt inc_append_history     # append in real time
  setopt hist_no_store          # don't store history commands
  setopt hist_expire_dups_first # kill the dups! kill the dups!
  setopt hist_verify            # verify history expansions
  setopt csh_junkie_history     # single instead of dual bang
  setopt bang_hist              # make ! a special character

  # i/o and syntax
  setopt multios                # redirect to globs!
  setopt multibyte              # Unicode!
  setopt noclobber              # don't overwrite with > use !>
  setopt rc_quotes              # 'Isn''t' ==> Isn't
  setopt equals                 # "=ps" ==> "/usr/bin/ps"
  setopt hash_list_all          # more accurate correction
  setopt list_rows_first        # rows are way better
  setopt hash_cmds              # don't search for commands
  setopt short_loops            # sooo lazy: for x in y do cmd
  setopt chase_links            # resolve links to their location
  setopt notify                 # I want to know NOW!

  # navigation
  setopt auto_cd                # just "dir" instead of "cd dir"
  setopt auto_pushd             # push everything to the dirstack
  setopt pushd_silent           # don't tell me though, I know.
  setopt pushd_ignore_dups      # duplicates are redundant (duh)
  setopt pushd_minus            # invert pushd behavior
  setopt pushd_to_home          # pushd == pushd ~
  setopt auto_name_dirs         # if I set a=/usr/bin, cd a works
  setopt magic_equal_subst      # expand expressions after =

  setopt prompt_subst           # Preform live prompt substitution
  setopt transient_rprompt      # Get rid of old rprompts
  setopt continue_on_error      # don't stop! stop = bad

} &>> $ZDOTDIR/startup.log
