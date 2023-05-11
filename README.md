
Dotfiles
==============

![current](https://github.com/mortang2410/dotfiles/assets/3200308/98c18c21-6158-4701-8821-74c624f73ce2)

Mac OS has the worst UX design.
Use Synergy + remap Ctrl and Cmd in setting + remap Ctrl and Cmd in iterm2.
Use Alt-tab with search (beta build).
Keycastr, Karabiner, Maccy, Rectangle, Easy Move+Resize, Whichspace make Mac OS half usable. Note that Karabiner does not work with Synergy unless the Mac is the host.

Replace nvim with helix, ranger with nnn and zsh with fish + fzf. Because who can bother to remember configs? 0-config with sane defaults is the future.

nnn
----
Use n (function in fish) to invoke nnn with auto-dir entry disabled and cd on quit. Press `td` and `ts` in nnn to display/undisplay folder sizes. I installed plugins as [instructed](https://github.com/jarun/nnn/tree/master/plugins), and many things for [live preview](https://github.com/jarun/nnn/blob/master/plugins/preview-tui#LL29), including [pistol](https://github.com/doronbehar/pistol#from-source) from Go. Press `;<Enter>` to choose which plugin to use, and `;p` for `preview-tui`. Note that previewing images with `viu` in `tmux` in `iterm` is pixelated (half-blocks) because `tmux` sucks (there's a fork with sixel I haven't tried). 

fish
----
Run "open" to open in Finder. Use `fish_add_path` to add to `$PATH` (I had to add $GOPATH/bin for Go). Press `C-E` or `<Esc>-e` to edit prompt in editor. Press `<super>-<left>` to move back in dir history. My own functions: use `mant <command>` to open man page in Skim, and `abrew` to replace `brew` (adding `arch -arm64` to `brew`).

I also made F2 in finder open iterm2.

Check `bind | rg fzf`  to see the binding in fish with fzf. Fish does not allow auto-completing hidden files (stubborn author). So fzf is the next best. 

Misc
----
Helix is awesome. `clipboard-yank` is nice.

Remember that for reverse search to work in LyX we need to start lyxserver by specifying lyxpipe in path preferences.

For Zotero, I use zotfile for file management and Better Bibtex. In zotfile preferences, be careful not to confuse between "Base directory" for linked attachment (should be a Dropbox folder), and "Data Directory location" (which should be local and synced by Zotero).

For tmux, `C-b I` the first time it starts to install plugins. Then `C-b ?` for keybindings, `C-b %` to split, `C-b <Space>` to change split layout, right-click and choose "Zoom" to temporarily zoom without moving panes, and `C-b !` to break the current pane into a new window. Custom keybind: `C-b @` to add a pane from other windows into current window. 
