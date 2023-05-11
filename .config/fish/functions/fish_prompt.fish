function fish_prompt
    set_color $fish_color_cwd
    echo -n (basename $PWD)
    printf "\e[6 q"
    set_color -o red
    echo -n ' 〉' (set_color normal)
end
