Dotfiles
==============


Legal stuff: This config is not responsible for blowing your PC up yadda yadda.
Typos abound.

To download/clone this repository, call

```shell
git clone  https://github.com/mortang2410/dotfiles

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

These are my dotfiles. Useful for setting up quickly on new machines. Right now
it contains my configuration for 

- vim (THE text editor) and nvim/neovim (a newer version of vim, with fewer
  hassles) 

- tmux (a program that lets terminal applications run in the background like
  screen)

- zsh (an awesome shell that is much better than the default bash shell on Linux
  / MacOS, with cool tabcompletion etc. ) 

- urxvt (a great and lean terminal with various extensions)

- weechat (great IRC client. [ Better than irrsi in every way
  ](https://xkcd.com/1782/) ). Obviously my personal network list (irc.conf) is
  not included.

- mpv (best video player around, with lots of options).

Things to install after cloning: 

- **Important**: if you
don't like nvim and want to use vim, then look in `.zshrc` for the line `export
EDITOR='nvim'`, and change `nvim` to `vim`. Note that I use the same .vimrc
file for both vim and nvim (technically, nvim uses init.vim, which just lazily
sources .vimrc). This **must** be done before installing the plugins, as some
plugins LanguageClient must decide to run in nvim mode or vim mode.

- the programs themselves: vim, nvim, tmux, zsh, urxvt, weechat, mpv. In particular,
  vim needs to be up-to-date, and obviously compiled with support for python3,
  ruby and all that jazz (sadly in Ubuntu 18.04 the default package sucks so you
  need to compile it yourself!). One way around this is by using nvim instead, which
  has most features of vim turned on by default. The transition to nvim was so
  painless  I now prefer it to Vim. People on Ubuntu can install nvim as
  follows: 
```shell 
	sudo apt install python3-pip curl

	curl -LO https://github.com/neovim/neovim/releases/download/nighty/nvim.appimage

	chmod u+x nvim.appimage
	
	pip3 install --user --upgrade neovim 

	pip3 install --user neovim-remote
```
then just run nvim.appimage directly. I symlink `nvim.appimage` to
`$HOME/.local/bin/nvim` so that `$PATH` can find it. Once nvim runs, there might be errors since plugins are missing. Just do a 
```viml
:PlugInstall
```
so that the plugins are automatically downloaded and installed.
Vim oldtimers can use  `:h nvim-from-vim` to see what have changed. Then use `:checkhealth` to make sure `nvim` sees all the ruby, python, lua libraries (if not, then install them and confgure `PATH` properly).

- To change the default shell to zsh, execute `chsh` in your currrent shell. You might need to log out and return for the change to take effect.

- Upon starting tmux, press `C-b I`  (`C-b` stands for `Ctrl+b`) to install tmux plugins.

- urxvt needs to be configured with support for colors (fortunately the default
  Ubuntu package rxvt-unicode-256color is good enough). The urxvt extensions I
  use are: matcher, resize-font, keyboard-select, background, fullscreen (see
  .Xresources).  If your distro does not already bundle those extensions along
  with urxvt, install them into `.urxvt/ext`. 

- [vimpager](https://github.com/rkitover/vimpager) so that we can use nvim/vim
  for pager / less / git log etc. 

- Language servers for
  [LanguageClient-neovim](https://github.com/autozimu/LanguageClient-neovim).
  Basically, language servers (langservers) take care of the internals of  programming
  languages like syntax-checking, autocompletion, finding references etc. so
  that any text editors can have access to such goodness. [ Read about them
  here](https://langserver.org/). For instance, I use
  [pyls](https://github.com/palantir/python-language-server) for python and
  [ccls](https://github.com/MaskRay/ccls) for C++. To install pyls on Ubuntu 18.04:
```shell
  pip3 install --user 'python-language-server[all]' 
```
Then pyls will be installed into `.local/bin`  (again, make sure that directory is in `$PATH`). Then LanguageClient-neovim should see pyls and automatically work. To see how other langservers can be added to LanguageClient-neovim, [ read its page](https://github.com/autozimu/LanguageClient-neovim#quick-start).

- Make sure the binary .fzf/bin/fzf (fuzzy finder) can be found in `$PATH`. For
  instance, by putting a symlink in `.local/bin` (assuming `~/.local/bin` is in your
  PATH variable). Then we can do funny things like `ls ~ | fzf` in the shell.

- [zathura](https://pwmt.org/projects/zathura/) for vimtex. Or use your favorite
  pdf viewer and modify vimtex opions.


I recommend reading about how [vim-plug](https://github.com/junegunn/vim-plug)
works. Do a `:PlugInstall` and `:PlugUpdate` to make sure everything is updated (before that vim / nvim might display some errors).

Also probably change urxvt_wallpaper2 to something less weeb. 

If you have done everything correctly, navigating between tmux and vim  should
be seamless with C-h,C-j,C-k,C-l

![desktop](https://i.imgur.com/I85XCh4.jpg)

Vim tips (messy, for personal use) 
----

gO: outline in man and help pages

gq : format by 'formatexpr'

gw : format without 'formatexpr'

:lopen to open loclist (local to window)

:copen to open quickfix (global)

,v: toggle less mode for vimpager

mx           Toggle mark 'x' and display it in the leftmost column

`x : jump to mark x. 

`0 :	jump to position in last file edited (when exited vim)

m<Space>     Delete all marks from the current buffer

:bd :buffer unload

"+p : paste from clipboard

"+y: yank into clipboard

s/abc/123/gc : replace with confirmation

gd: go to definition

gq : reformat text to pretty up

C-p l to open CTRLP in lines mode, then C-f to switch between modes
(lines,files, buffers, MRU...). 

C-p f to open CTRLP in files mode. I use Notes for vim:CtrlP for current dir by
setting max depth to 1, and fzf for deep dirs.

C-x C-f in insert mode to insert a filename with fzf.

M-x : like emacs command with fzf. 

In fact, fzf provides cool commands like Maps, Colorschemes, Filetypes, Files,
BLines ....

s: easy motion!! (overwritten vim's default s), with \\ as prefix for other
stuff

S: easy motion by 2 characters

Use SudoEdit from vim-eunuch (:h enuch)

Use Locate from fuzzy finder

Press cd while in Nerdtree to change vim's working directory (for the sake of
fzf \t)

\T : Nerdtree toggle

\t : quick find files by fzf

\b :quick find buffer by fzf

:help key-notation 

Browse old files:

:bro ol 

then we might need to hit q to make prompt appear if list is too long

Or :capture ol  , then use gf to jump to file

Tmux tips
------------

dump pane: C-b P

reload config: C-b C-r

clear pane: C-b k

vi mode: C-b [, select with Space, then y to yank into system clipboard

with mouse mode on, use shift with mouse to select stuff / copy



