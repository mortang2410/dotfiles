
Dotfiles
==============

![current](https://github.com/mortang2410/dotfiles/assets/3200308/98c18c21-6158-4701-8821-74c624f73ce2)

Mac OS has the worst UX design.
Use Synergy + remap Ctrl and Cmd in setting + remap Ctrl and Cmd in iterm2.
Use Alt-tab with search (beta build).
Keycastr, Maccy, Rectangle make Mac OS half usable.

Replace nvim with helix, ranger with nnn and zsh with fish + fzf. Because who can bother to remember configs? 0-config with sane defaults is the future.
 
Use n (function in fish) to invoke nnn with auto-dir entry disabled and cd on quit. Run "open" to open in Finder. I also made F2 in finder open iterm2.

Check `bind | rg fzf`  to see the binding in fish with fzf. Fish does not allow auto-completing hidden files (stubborn author). So fzf is the next best. 

Helix is awesome. `clipboard-yank` is nice.

Remember that for reverse search to work in LyX we need to start lyxserver by specifying lyxpipe in path preferences.

For Zotero, I use zotfile for file management and Better Bibtex. In zotfile preferences, be careful not to confuse between "Base directory" for linked attachment (should be a Dropbox folder), and "Data Directory location" (which should be local and synced by Zotero).

For tmux, `C-b I` the first time it starts to install plugins. Then `C-b ?` for keybindings, `C-b %` to split, `C-b <Space>` to change split layout, `C-b !` to break the current pane into a new window. Custom keybind: `C-b @` to add a pane from other windows into current window.
