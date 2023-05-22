
Dotfiles
==============

![current](https://github.com/mortang2410/dotfiles/assets/3200308/98c18c21-6158-4701-8821-74c624f73ce2)

Mac OS has the worst UX design.
Use Synergy + remap Ctrl and Cmd in setting + remap Ctrl and Cmd in iterm2.
Use Alt-tab with search (beta build).
Keycastr, Karabiner, Maccy, yabai, Whichspace make Mac OS half usable. Note that Karabiner does not work with Synergy unless the Mac is the host. I had to [enable](https://www.macworld.com/article/351347/how-to-activate-key-repetition-through-the-macos-terminal.html) repeating keys and [disable](https://apple.stackexchange.com/questions/14001/how-to-turn-off-all-animations-on-os-x) window opening animations in the terminal, and [disabled](https://github.com/pqrs-org/Karabiner-Elements/issues/2981) globe key changing input source, and enabled [passwordless sudo](https://jefftriplett.com/2022/enable-sudo-without-a-password-on-macos/) + [unsigned binaries](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection) for yabai.

Replace nvim with helix, ranger with nnn and zsh with fish + fzf. Because who can bother to remember configs? 0-config with sane defaults is the future.

nnn
----
Use n (function in fish) to invoke nnn with auto-dir entry disabled and cd on quit. Use `np` like in `file (np)` to file-pick with nnn. 
Press `ta`,`td`, `ts` in nnn to display/undisplay folder sizes. I installed plugins as [instructed](https://github.com/jarun/nnn/tree/master/plugins), and many things for [live preview](https://github.com/jarun/nnn/blob/master/plugins/preview-tui#LL29), including [pistol](https://github.com/doronbehar/pistol#from-source) from Go. Press `;<Enter>` to choose which plugin to use, `;m` to open Marta at current dir and `;p` for `preview-tui`. Note that previewing images with `viu` in `tmux` in `iterm` is pixelated (half-blocks) because `tmux` sucks (there's a fork with sixel I haven't tried).
I also have my own nnn fork to add "force yes" to cp/mv prompts. Selecting a file copies the path into clipboard, and we can use `C-G` to paste file path into the open file dialog in Mac. 

fish
----
Run "open" to open in Finder. Use `fish_add_path` to add to `$PATH` (I had to add $GOPATH/bin for Go). Press `<Esc>-e` to edit prompt in editor. Press `<super>-<left>` to move back in dir history. My own functions: use `mant <command>` to open man page in Skim, and `abrew` to replace `brew` (adding `arch -arm64` to `brew`).

I hardcoded cursor shape `line` by `printf "\e[6 q"` in the fish_prompt.

Check `bind | rg fzf`  to see the binding in fish with fzf. Fish does not allow auto-completing hidden files (stubborn author). So fzf is the next best. 

Misc
----
Helix is awesome. `clipboard-yank` is nice.
I also made F2 in finder and marta open iterm2. Also `C-M` in Finder to open marta. Play with `C-p` and `C-P` in marta.
iterm2's preferences is stored in `~/Library/Preferences` like other programs. I modified the setting "dimming for inactive panes". Also I set `<Super>-=` to open iterm2 in Guake style.
Press `C-?` to open help menu search for GUI apps.

Press `<Super>-T` to float and `<Super>-t` to toggle sticky + topmost for window with yabai.

Remember that for reverse search to work in LyX we need to start lyxserver by specifying lyxpipe in path preferences.

For Zotero, I use zotfile for file management and Better Bibtex. In zotfile preferences, be careful not to confuse between "Base directory" for linked attachment (should be a Dropbox folder), and "Data Directory location" (which should be local and synced by Zotero).

For tmux, `C-b I` the first time it starts to install plugins. Then `C-b ?` for keybindings, `C-b %` to split, `C-b <Space>` to change split layout, right-click and choose "Zoom" to temporarily zoom without moving panes, and `C-b !` to break the current pane into a new window. Custom keybind: `C-b @` to add a pane from other windows into current window. I added `C-c C-c` to change tmux's current dir.

nvim tips
-----
Watch [this](https://youtu.be/GEHPiZ10gOk) to use/configure astronvim. Use `plugin/user.lua` to add plugins (add `lazy = false` to always load).
`:Bufferize <command>` to view output of command in another buffer. Use `:SudaWrite` to sudo write. `C-]` to jump into help tags. Use `<Space>fk` and `<Space>fC` for user keymaps and ex+plugin commands, and `<Space>?` for built-in keymaps. `za` to toggle fold. `<space>fw` to find words by telescope and `:Spectre` to find + replace. `<space>fk` and search for "split" and "buffer" to work with windows and buffers.
