Dotfiles
==============

These are my dotfiles. Useful for setting up quickly on new machines.


A few things not included here, which you need to install
yourself, depending on your enviroment / distribution. If
you don't install them, vim will just give a few error
messages but is otherwise usable without such features.

-[vimpager](https://github.com/rkitover/vimpager) 

-Linters
for ALE, which is an awesome linting engine for
autocompletion / finding references in languages (for
instance,
[pyls](https://github.com/palantir/python-language-server)).

-Make sure the binary .fzf/bin/fzf (fuzzy finder) can be
found in PATH. For instance, by putting a symlink in
.local/bin (assuming ~/.local/bin is in your PATH
variable).

I recommend reading about how [ vim-plug ](https://github.com/junegunn/vim-plug) works. Do a :PlugUpdate to make sure everything is updated.

Vim tips
----

,v: toggle less mode for vimpager

mx    Toggle mark 'x' and display it in the leftmost column

`x : jump to mark x.

`0 :	jump to position in last file edited (when exited vim)

m<Space>     Delete all marks from the current buffer

:bd :buffer unload

"+p : paste from clipboard

"+y: yank into clipboard

s/abc/123/gc : replace with confirmation

gd: go to definition (using ALE)

gq : reformat (by ALE)

C-p l to open CTRLP in lines mode, then C-f to switch between modes (lines,files, buffers, MRU...).

C-p f to open CTRLP in files mode. I use Notes for vim:CtrlP for current dir by setting max depth to 1, and fzf for deep dirs.

M-x : like emacs command with fzf.

In fact, fzf provides cool commands like Maps, Colorschemes, Filetypes, Files ....

s: easy motion!! (overwritten vim's default s), with \\ as prefix for other stuff

S: easy motion by 2 characters

Use SudoEdit from vim-eunuch (:h enuch)

Use Locate from fuzzy finder

Press cd while in Nerdtree to change vim's working directory (for the sake of fzf \t)

\T : Nerdtree toggle

\t : quick find files by fzf

\b :quick find buffer by fzf

:help key-notation

Browse old files:

:bro ol

then we might need to hit q to make prompt appear if list is too long

Or :capture ol  , then use gf to jump to file



vim and tmux navigation between panes: use C-h,C-j,C-k,C-l



zshrc makes   vim --servername to play well with vimtex



:helpgrep something, then :copen to see results



To comment out blocks in vim MANUALLY (use gc on selection for auto-comment):



	press Esc (to leave editing or other mode)

	hit ctrl+v (visual block mode)

	use the up/down arrow keys to select lines you want (it won't 				highlight everything - it's OK!)

	Shift+i (capital I)

	insert the text you want, i.e. %

	press EscEsc



For file name omni completion in insert mode, you can use:



Ctrl-X Ctrl-F



Edit in command bar: C-f



See ex-commands' output in new buffer:

:Capture <command>



To see what linters ALE is using:

:ALEInfo



Install vimpager



vim-tex:

\ll compile

\lv view with synctex. Ctrl-click on zathura to do reverse.



F4 for undotree toggle. Double click to jump to the one you want. Persistent undos between sessions.



To select and surround: use v to enter visual mode and select abc, then S[ to surround -> [abc]




