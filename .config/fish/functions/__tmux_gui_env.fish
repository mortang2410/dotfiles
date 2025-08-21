function __tmux_gui_env --description 'Sync GUI env & normalize Xauth for tmux (Linux only)'
    if not status is-interactive; or test (uname) != Linux
        return
    end
    if test -z "$DISPLAY" -a -z "$WAYLAND_DISPLAY"
        return
    end

    # Normalize Xauthority -> ~/.Xauthority
    if type -q xauth
        set -l src $XAUTHORITY
        if test -z "$src" -o ! -e "$src"
            set -l uid (id -u)
            set src (command find /run/user/$uid -maxdepth 2 -type f -name 'xauth_*' -print -quit)
            if test -z "$src" -o ! -e "$src"
                test -e "$HOME/.Xauthority"; and set src "$HOME/.Xauthority"
            end
        end
        if test -n "$src" -a -e "$src" -a -n "$DISPLAY"
            xauth -f $src nlist $DISPLAY | xauth -f ~/.Xauthority nmerge -
        end
    end

    # Push vars into tmux server
    if type -q tmux
        for name in DISPLAY XAUTHORITY WAYLAND_DISPLAY XDG_RUNTIME_DIR DBUS_SESSION_BUS_ADDRESS SSH_AUTH_SOCK
            set -l val (eval echo \$$name)
            test -n "$val"; and tmux setenv -g $name $val >/dev/null 2>&1
        end
        tmux setenv -g XAUTHORITY $HOME/.Xauthority >/dev/null 2>&1
    end
end
