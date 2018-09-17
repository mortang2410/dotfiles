Dotfile 
==============

Legal disclaimer: This config is not responsible for blowing your PC up yadda yadda.  Typos abound. 

These are my dotfiles. Useful for setting up quickly on new machines.
Right now it contains my configuration for 

- vim (THE text editor) and nvim/neovim (a newer version of vim, with fewer hassles and very active development). They can mostly use the same plugins.

- tmux: a program that lets CLI applications (command line interface) run
  in the  background, as well as rearranging them on the terminal screen.

- zsh: an awesome shell, which is the interactive program that allows
  you to launch stuff / execute commands in terminals.
  `zsh` is much better than the default `bash` shell on Linux /
  MacOS, with cool tabcompletion etc. The default shell on Windows,
  `cmd`, that probably a lot of people including me learned in IT
  classes, is **horrible**, and  for many years why I hated the
  command line. Microsoft is switching to PowerShell, inspired by Bash / Zsh, but I've tried it and found it wanting for many reasons.

- urxvt: a great and lean terminal with various extensions

- weechat: great IRC client. [ Better than irssi in every way
  ](https://xkcd.com/1782/). Obviously my personal network list
  (irc.conf) is not included.

- mpv: best video player around, with lots of options.



Why use vim/nvim
---------------

Let's get right to the point, here is `nvim` running in the `urxvt` terminal as a pure text writer/reader in
distraction-free mode (with the command `:Zen`)

![Zen mode](https://camo.githubusercontent.com/cb6e158954d0ae35de742409d504115ffef87013/68747470733a2f2f692e696d6775722e636f6d2f42694b49455a592e6a7067)
    
Ok it looks cool, but how about features? Let's say, I want to
jump to the letter `.`  at the end of Holmes' sentence, `the vital
essence of the whole matter.` Now think about your favorite text
editors. You would either clumsily use the mouse, or press a huge
amount of keys to get there. In nvim, I only need to press 3 keys,
`s.w` and I'm there. What did I just do? `s` brings up the
EasyMotion plugin for nvim, which will search for the next
character. As I type `.`, nvim displays all the possible matches
as red letters, as seen below

![red letters](https://camo.githubusercontent.com/c215c324245e3099f029a401e57e47a59611f133/68747470733a2f2f692e696d6775722e636f6d2f465869556165712e6a7067)

I always kept my eyes on my target location, so as I saw the red
letter `w` pop up, I hit it like I was playing [ Typer
Shark](https://youtu.be/hcJtsrIit8M?t=10m14s). And that is just one
trivial example, made possible by vim/nvim's flexibility. [ It is like casting a *teleportation* spell](https://youtu.be/sz-9tcUq5yg?t=43s). Now think **DEEPLY** about what it means. We can teleport around like this, select and delete stuff at lightning speed. The possibilities are just endless. It's like discovering fast travel in a game and no more walking from town to town. It is just impossible for me to use other programs that don't learn from nvim/vim.

- "How to
delete everything from the cursor to the end of the current line?"
`D`. 

- "How to delete the whole current line?" `dd`. 

- "I undoed a change, and tried to redo, but accidentally inserted
  some text. Is my redo lost forever?" Nothing is ever lost in
  nvim.  Press F4 to toggle the legendary undo tree. In fact, all
  your undos are saved across sessions, so *every possible state
  since the beginning of time* of your file is remembered by nvim
  (as long as, of course, you don't use other stuff to change the
  file while nvim is not running). Realistically though, you might
  wanna prune the history unless you have unlimited storage, so I
  set the cutoff at 300 days.

These are just the tips of the icebergs. There are *hundreds* of
commands within nvim, and they can be combined to create the one
you want. And most importantly, there are countless plugins which
extend functionality for nvim/vim. For instance, snippets
(often-used code blocks by programmers) are provided by dozens of
plugins. Many plugins, like EasyMotion, provides features that
seem indispensable in hindsight. Use `:help` and `:Helptags`
prodigiously.  Finally, for all its powers, nvim starts and runs
as fast as Notepad. 

*This is what I think software should be like.* Efficient, elegant
and endlessly customizable, whether I just want a simple fullscreen
Notepad for writing a text novel, or a powerhouse development
environment for programming languages. Even this readme is being
written with vim in
[Markdown](https://guides.github.com/features/mastering-markdown/). 


## Why use zsh or the command line

Let's say, I want to edit a file called `ncm2.vim`. But I only remember it being *somewhere* in the `.vim` directory, and it is a big directory. I could do a search, then copy the result to open in `nvim`. Or I could just type `nvim .vim/**/ncm2.vim` into the terminal (using zsh as the shell) and hit Enter. And that is zsh's greatest magic: autocompletion. It autocompletes everything from program names, to program options, file paths,... and we can pick the matches we want from a menu. Any programmer knows the usefulness of good autocompletion, and zsh's autocompletion is **endlessly** customizable (and to this date, I still haven't read the whole manual for it).

In this screenshot, I want to execute a command whose name starts with
`apt`, so I type `apt` and then  `<Tab>`. zsh automatically pops up a
menu of possible choices for me to choose with arrow keys, much more
convenient than having to keep pressing `<Tab>`. I could also press `Ctrl+r` to search through all past commands if I want to.

![zsh](https://camo.githubusercontent.com/a43cfdcf299d31be8274a372d6cbe65d62e2c7be/68747470733a2f2f692e696d6775722e636f6d2f683041586e79622e706e67)

For a more complicated example, let's say my chat log text files have grown far too big, and I want to cut them in half (saving only the recent half), I can script up my own command (don't worry if you have no idea about scripting yet, just know how it is possible)
```shell
trim50() {
    for x in "$@"
    do
        integer z=$(($(wc -l <$x)/2)) ;
        sed -i -e 1,$[z]d $x ;
    done
}
```
and run `trim50 *.txt` in the log directory. That's it. In fact, this command is in my current `.zshrc`, which is the configuration file that `zsh` reads on startup.

Finally, we can run shell commands within nvim itself, to either edit or insert into the current file. The flexibility of CLI programs allow them to be combined in creative ways.

## Why use tmux

I heard you liked terminal so I put terminals inside your terminal.

![tmux](https://camo.githubusercontent.com/80cdcf36b54cb5dff64bea3f32807826ad2c0dc3/68747470733a2f2f692e696d6775722e636f6d2f76777a716461582e6a7067)

Also, you can close your terminal and tmux will still be running,
ready to view later on. This is useful for running IRC clients, torrent clients, shell scripts, encoding etc.

## Installation guide

** The rest is about installation. In my opinion, using other people's
configuration files, or borrowing parts from them, can indeed save time,
but it also means there are many options and (ingenious) workarounds in
those files that you will know nothing about. So, as with most things in
life, there is a tradeoff. If you can accept that, proceed. **

This guide is meant for Ubuntu users, but it should be the same for
other distributions, as long as one knows the equivalent packages /
package managers.  Besides, Archers and Gentoomen need no guides. ;)
People on Mac OS already have `zsh` installed by default (which was
surprising to me to find out), though they might need to update it with
[ homebrew ](https://brew.sh/). They could also use homebrew to install
`nvim`, `tmux` etc. So without loss of generality, assume we're using Ubuntu.

Firstly, `~` is your home folder, such as `/home/wilder`. Among the
programs, nvim, tmux and zsh are the most important as they affect each
other and are indispensable on any Linux server; while urxvt, weechat, mpv
are optional. In particular, urxvt is not a CLI application, so no need to install it on servers.


To download/clone this repository, call

```shell
sudo apt install git 
git clone  https://github.com/mortang2410/dotfiles ~/dotfiles
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/zsh-syntax-highlighting
```

Then copy things in `~/dotfiles` to `~`. Things to install after cloning: 

- To change the default shell to zsh, execute `chsh` in your current shell.
  You might need to log out and return for the change to take effect.

- **Important**: if you
don't like nvim and want to use vim (though I don't recommend so), then look in `.zshrc` for the line `export
EDITOR='nvim'`, and change `nvim` to `vim`. Note that I use the same .vimrc
file for both vim and nvim (technically, nvim uses init.vim, which just lazily
sources .vimrc). This **must** be done before installing the plugins for nvim/vim, as some
plugins like  LanguageClient must decide to run in nvim mode or vim mode (otherwise reinstall them).

- the programs themselves: vim/nvim, tmux, zsh, urxvt, weechat, mpv. In particular,
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
`$HOME/.local/bin/nvim` so that `$PATH` can find it. Once nvim runs,
there might be errors since plugins are missing. Just do a
`:PlugInstall` so that the plugins are automatically downloaded and
installed.  Vim oldtimers can use  `:h nvim-from-vim` to see what
have changed. Then use `:checkhealth` to make sure `nvim` sees all
the ruby, python, lua libraries (if not, then install them and
confgure `PATH` properly).


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

- By default, the `:PlugInstall` of nvim above will also install fzf (fuzzy
  finder) into `~/.fzf`. But we still need to make sure the binary `~/.fzf/bin/fzf`
  can be found in `$PATH`. For instance, by putting a symlink in `~/.local/bin`
  (assuming `~/.local/bin` is in your PATH variable). Then we can do funny
  things like `ls ~ | fzf` in the shell.

- [zathura](https://pwmt.org/projects/zathura/) for vimtex. Or use your favorite
  pdf viewer and modify vimtex opions.


I recommend reading about how [vim-plug](https://github.com/junegunn/vim-plug)
works. Do a `:PlugInstall` and `:PlugUpdate` to make sure everything is updated (before that vim / nvim might display some errors).

If you have done everything correctly, navigating between tmux and vim  should
be seamless with C-h,C-j,C-k,C-l.



![desktop](https://camo.githubusercontent.com/d015da143a73a3cfacdfcaaa7040ed475b4f34ff/68747470733a2f2f692e696d6775722e636f6d2f493835584368342e6a7067)

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

`0 :    jump to position in last file edited (when exited vim)

m<Space>     Delete all marks from the current buffer

:bd :buffer unload

"+p : paste from clipboard

"+y: yank into clipboard

s/abc/123/gc : replace with confirmation

s/\n/&\r/g : replace end-of-line with empty new line

gd: go to definition

gq : reformat text to pretty up

C-p l to open CTRLP in lines mode, then C-f to switch between modes (lines,files, buffers, MRU...). 

C-p f to open CTRLP in files mode. I use Notes for vim:CtrlP for current dir by setting max depth to 1, and fzf for deep dirs.



C-x C-f in insert mode to insert a filename with fzf.

M-x : like emacs command with fzf. 

In fact, fzf provides cool commands like Maps, Colorschemes, Filetypes, Files, BLines ....

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

To comment out blocks in vim:

    press Esc (to leave editing or other mode)

    hit ctrl+v (visual block mode)

    use the up/down arrow keys to select lines you want (it won't   highlight everything - it's OK!)

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

:Ncm2Sources

My own hackish function to look at enabled sources in ncm2.


C-x C-t  in Insert mode in Markdown: thesaurus via vim-lexical

C-x C-k as above : dictionary via vim-lexical

Zen : modified distraction free mode

Spell and Unspell for... spelling with vim-lexical.

Tmux tips
------------

dump pane: C-b P

reload config: C-b C-r

clear pane: C-b k

vi mode: C-b [, select with Space, then y to yank into system clipboard

with mouse mode on, use shift with mouse to select stuff / copy



