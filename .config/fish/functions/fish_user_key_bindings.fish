function fish_user_key_bindings
    fzf_key_bindings
    bind \cf fzf-cd-widget
    set -U fish_escape_delay_ms 200
    bind \cE edit_command_buffer
end
