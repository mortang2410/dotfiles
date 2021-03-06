
Dotfiles
==============

![Current desktop](https://camo.githubusercontent.com/e01ef618ce3aa66df7d425293c6154a293b16250/68747470733a2f2f692e696d6775722e636f6d2f4c6c46667869522e6a7067)

<p align="center">
 Because the terminal should feel like home.
</p>

Legal disclaimer: This config is not responsible for blowing your PC up. Many
hacks/workarounds are due to the great people of the internet.  Typos abound. 

These are my dotfiles. Useful for setting up quickly on new machines.
Right now it contains my configuration for:

- vim (THE text editor) and nvim/neovim (a newer version of vim, with fewer hassles and very active development). They can mostly use the same plugins.

- tmux: a program that lets TUI applications (text-based user interface) run
  in the  background, as well as rearranging them on the terminal screen.


- zsh: an awesome shell, which is the interactive program that allows
  you to launch stuff / execute commands in terminals.  `zsh` is much better
  than the default `bash` shell on Linux / MacOS, with cool tabcompletion etc.
  The default shell on Windows, `cmd`, that probably a lot of people including
  me learned in IT classes, is **horrible**, and  for many years why I hated
  the command line. Microsoft is switching to PowerShell, inspired by Bash /
  Zsh, but I've tried it and found it wanting for many reasons.

- urxvt: a great and lean terminal with various extensions

- weechat: great IRC client. [ Better than irssi in every way
  ](https://xkcd.com/1782/). Obviously my personal network list
  (irc.conf) is not included.

- mpv: best video player around, with lots of options.

- ranger: a terminal file manager with vim's keybindings for lightning-fast navigation.

Why use vim/nvim
---------------

Let's get right to the point, here is `nvim` running in the `urxvt` terminal as a pure text writer/reader in
distraction-free mode (with the command `:Zen`)

![Zen mode](https://camo.githubusercontent.com/cb6e158954d0ae35de742409d504115ffef87013/68747470733a2f2f692e696d6775722e636f6d2f42694b49455a592e6a7067)
    
OK it looks cool, but how about features? Well, at least we can read
text novels. :) I'm not entirely joking as `nvim` has bookmarks and jump lists by default.

More seriously, let's say, I want to jump to the letter `.`  at the
end of Holmes' sentence in the third paragraph, `the vital essence of
the whole matter.` Now think about your favorite text editors. You
would either clumsily use the mouse, or press a huge amount of keys
to get there. In nvim, I only need to press 3 keys, `s.w` and I'm
there. What did I just do?  `s` brings up the EasyMotion plugin for
nvim, which will search for the next character. As I type `.`, nvim
displays all the possible matches as red letters, as seen below

![red letters](https://camo.githubusercontent.com/c215c324245e3099f029a401e57e47a59611f133/68747470733a2f2f692e696d6775722e636f6d2f465869556165712e6a7067)

I always kept my eyes on my target location, so as I saw the red
letter `w` pop up, I hit it like I was playing [ Typer
Shark](https://youtu.be/hcJtsrIit8M?t=10m14s). And that is just one
trivial example, made possible by vim/nvim's flexibility. [ It is
like casting a *teleportation*
spell](https://youtu.be/sz-9tcUq5yg?t=43s). Now think **DEEPLY**
about what it means. We can teleport around like this, select and
delete stuff at lightning speed, or combine it with other actions.
The possibilities are just endless. It's like discovering fast travel
in a game: no more walking from town to town, and after that it is
just impossible for me to use other programs that don't learn from
nvim/vim.


- "How to delete everything from the cursor to the end of the current line?"
  `D`. "To delete the current line?" `dd`. "To delete 5 lines?" `5dd`.

- "How to indent a paragraph?" `=ap`. "To delete a paragraph"? `dap` (notice
  the mnemonic). "To delete a tag in HTML?" `dat`. "To delete everything
  in-between square brackets?" `di[`. "How about in-between curly brackets?"
  `di{`. Note how logical these commands are. I use these operations every day
  for editing things quickly.  Bonus tip: `gwap` to format the current
  paragraph.

- "But I just want to enter text normally like in Notepad?" Press `i`
  to enter a special mode call Insert, where you enter text just like
  in Notepad. Press `<Esc>` to go back to Normal mode (terribly
  named, I know), where you can do all the teleportation commands as
  above. The reason `nvim` has multiple modes is so that you can use
  the same keys to do different things, depending on your intent. To
  paraphrase a developer, true Vim fanatics sacrifice goats to the
  modal gods.

- "I undoed a change, and tried to redo, but accidentally inserted
  some text. Is my redo lost forever?" Nothing is ever lost in nvim.
  Press F4 to toggle the legendary undo tree. In fact, all your undos
  are saved across sessions, so *every possible state since the
  beginning of time* of your file is remembered by nvim (as long as,
  of course, you don't use other stuff to change the file while nvim
  is not running). **Why would anyone want to live without this killer
  feature?** Realistically though, you might wanna prune the history
  unless your name is Bezos and you have unlimited storage, so I set
  the cutoff at 300 days.

- "I just can't quit using the program!" If you mean you love it so
  much, that's awesome to hear. If you mean you *literally*  can't
  exit `nvim`, type `:quit` in Normal mode. It is probably the most
  common meme about vim/nvim: people not knowing the command to exit
  it (to be fair, the command is shown on the login screen).


These are just the tips of the icebergs. There are *hundreds* of
commands within nvim, and they can be combined to create the one
you want. And most importantly, there are countless plugins which
extend functionality for nvim/vim. For instance, snippets
(often-used code blocks by programmers) are provided by dozens of
plugins. Many plugins, like EasyMotion, provide features that
seem indispensable in hindsight. Use `:help` and `:Helptags`
prodigiously.  Finally, for all its powers, nvim starts and runs
as fast as Notepad. 

*This is what I think software should be like.* Efficient, elegant
and endlessly customizable, whether I just want a simple fullscreen
Notepad for writing a text novel, or a powerhouse development
environment for programming languages. Even this readme is being
written with nvim in the
[Markdown](https://guides.github.com/features/mastering-markdown/)
language.


## Why use zsh or the command line

Let's say, I want to edit a file called `ncm2.vim`. But I only remember it being *somewhere* in the `.vim` directory, and it is a big directory. I could do a search, then copy the result to open in `nvim`. Or I could just type `nvim .vim/**/ncm2.vim` into the `urxvt` terminal (using `zsh` as the shell) and hit Enter. And that is zsh's greatest magic: autocompletion. It autocompletes everything from program names, to program options, file paths,... and we can pick the matches we want from a menu. Any programmer knows the usefulness of good autocompletion, and zsh's autocompletion is **endlessly** customizable (and to this date, I still haven't read the whole manual for it).

In this screenshot, I want to execute a command whose name starts with
`apt`, so I type `apt` and then  `<Tab>`. zsh automatically pops up a
menu of possible choices for me to choose with arrow keys, much more
convenient than having to keep pressing `<Tab>`. I could also press `Ctrl+r` to search through all past commands if I want to.

![zsh](https://camo.githubusercontent.com/a43cfdcf299d31be8274a372d6cbe65d62e2c7be/68747470733a2f2f692e696d6775722e636f6d2f683041586e79622e706e67)

For a more complicated example, let's say my chat log text files have grown far too big, and I want to cut them in half (saving only the recent half), I can script up my own command (don't worry if you have no idea about scripting yet, just know how it is possible)

~~~shell
trim50() {
    for x in "$@"
    do
        integer z=$(($(wc -l <$x)/2)) ;
        sed -i -e 1,$[z]d $x ;
    done
}
~~~

and run `trim50 *.txt` in the log directory. That's it. In fact, this command is in my current `.zshrc`, which is the configuration file that `zsh` reads on startup.

Finally, we can run shell commands within nvim itself, to either edit
or insert into the current file. The flexibility of text-based programs
allow them to be combined in creative ways.

### But what about bash?

People coming from `bash` will wonder what `zsh` can do better, and why they
should bother. Well, it offers better autocompletion, globbing patterns, and
more. For instance, `file *(.)` will run `file` over all files, excluding
directories. How to do that in bash, is probably not common knowledge ;). Also,
take a look at how customizable zsh's completion matcher is. Mine, for
instance, quite mimics fuzzy completion.

~~~

zstyle ':completion:*' matcher-list                                      \
    '                                   m:{[:lower:]}={[:upper:]}' \
    '                                   m:{[:lower:]\-}={[:upper:]_}' \
    'r:[^[:alpha]]||[[:alpha]]=** r:|=* m:{[:lower:]\-}={[:upper:]_}' \
    'r:|?=**                            m:{[:lower:]\-}={[:upper:]_}'


~~~


## Why use tmux

I heard you liked the terminal so I put terminals inside your terminal.

![tmux](https://camo.githubusercontent.com/80cdcf36b54cb5dff64bea3f32807826ad2c0dc3/68747470733a2f2f692e696d6775722e636f6d2f76777a716461582e6a7067)

Also, you can close your terminal and tmux will still be running,
ready to view later on. This is useful for running IRC clients,
torrent clients, shell scripts, encoding etc. Also very useful for
running programs on remote servers, which often don't have a GUI
(graphical user interface).

## Why use ranger 

It can do anything, from previewing files (in the terminal!), to integrating
with vim, zsh etc. And it does everything via vim shortcuts. Even just jumping
to bookmarks in 2 key presses is enough for me to like it.  You can also write
custom python commands for it to run, and redefine every option / file
association / launchers etc. In my configuration, press `/` to quick filter,
`F` to flatten directories, `` `H ``  to search through frequently used dirs
with `fzf` (an awesome search tool which I also use for zsh and vim), `S` to
start a zsh shell in the current dir, and `<Right>` on a text file to edit with
vim. Also, it can select files from different folders for copying (press `ya`), show
all files that lie in subdirectories 3 levels deep from current dir, and search
through them with `fzf`. Those are insanely useful features, and only the tip
of the iceberg.



![ranger](https://camo.githubusercontent.com/8a58777090e5ac46500819d4f7f2c6f312c07d64/68747470733a2f2f692e696d6775722e636f6d2f475139774f32722e6a7067)


Ranger allows easy scripting in python, as it has a minimal core that one can
easily explore. In other file managers, which I shall not name, trying to
extend their functionality is much harder, and even frowned upon as developers
don't bother to consider such use cases. Meanwhile, I was able to cook up a
way to use `fzf` to search through ranger's navigation history just from poking
around the source files and the default commands. I've mentioned
[fzf](https://github.com/junegunn/fzf) twice now, but it's easier to understand
what fzf does once you see it in
[action](https://github.com/junegunn/fzf/wiki/examples).

![fzf](https://camo.githubusercontent.com/d26a278c698e88f777c1692a2b6946d1d60ffbec/687474703a2f2f646d697472796672616e6b2e636f6d2f5f6d656469612f61727469636c65732f6364675f7265636f726465642e676966)

That's why I want to use fzf in, well, everything, including ranger.  By now,
one should see that the killer feature of ranger is not within itself, but from
how well it utilizes other tools within the terminal, and provides seamless
integration between different worlds. Plus I personally dig how it makes me
feel like flying through directories with my custom commands. I am honestly
surprised that it has managed to replace my graphical file managers as well,
and in some cases offered me more features (e.g. fzf). 

## Final caveats

As you can hopefully see by this point, these programs can be
incredibly useful, *once you know how to use them*.  Before that,
what should appear clear is that they are quite **unfriendly** for
beginners. Where are buttons that we can click? How do we discover
new features? Well, technically we can click the tabs and resize
windows in tmux / nvim with the mouse, but most features don't have
buttons to represent them (I can't even begin to imagine the number
of buttons required to fully represent nvim).  And we *can* read the
manuals, but they are like references to search through, not guides
to read from beginning to end. We usually search the internet for
quickstart guides on how to use them, and what popular options people
use. We can even search within the programs with autocompletion and
help utilities etc.  to discover new stuff.  Programs like `nvim`
will never run out of commands / switches for a user to discover, and
that can be both a blessing and a curse.  It can be intimidating to
new users, before they finally understand that, hey, 80% of users
only ever use 20% of features, and there's no need for them to know
everything. Think of these programs as lovely gift boxes that keep on
giving the more one looks into them. 

Using text-based programs requires *not* intelligence, but
experience.  One must have experience with using text-based
applications, editing configuration files (which, incidentally,
`nvim` is very good at), reading the manuals and Google. There is
never going to be a world where everybody is comfortable with
learning the finer points of their tools, otherwise there wouldn't be
car mechanics and tech support. So, this is not going to be for
everybody. And `nvim` is not going to replace Visual Studio or
Notepad++ for everyone. Though people like to rationalize the effort
they spent on learning a tool, *they must also be clear-headed about
its faults*.  For instance, up until a few years ago, vim/nvim could
not handle certain programming languages very well (stuff like
autocompletion, checking syntax etc.). But now `nvim` can use [
language servers](https://langserver.org/), which take care of such
things. In fact, langservers are what inspired me to take a second
look at vim/nvim.  Additionally, Visual Studio now has a Vim mode
(though pretty basic), so there is some kind of convergence of
awesomeness happening on both sides.  With that being said, I am just
content with what I have figured out, and maybe contentment is the
best metric. Best to only learn a new tool when one feels like it,
and hopefully enjoys the journey as well. 

There is no need to read anything further until you actually want to
try it out. Even then, the installation guide is a bit rough and
unpolished. It demands some knowledge of how life in the terminal
works.

## Installation guide

**The rest is about installation. In my opinion, using other people's
configuration files, or borrowing parts from them, can indeed save
time, but it also means there are many options and (ingenious)
workarounds in those files that you will know nothing about. So, as
with most things in life, there is a tradeoff. If you can accept
that, proceed.**

This guide is meant for Ubuntu users, but it should be the same for other
distributions, as long as one knows the equivalent packages / package managers.
Besides, Archers and Gentoomen need no guides. ;) People on Mac OS already have
`zsh` installed by default (which was surprising for me to find out), though
they might need to update it with [ homebrew ](https://brew.sh/). They could
also use homebrew to install `nvim`, `tmux` etc. People on Windows can also
install these programs via the [ Windows Subsystem for Linux feature
](https://www.howtogeek.com/249966/how-to-install-and-use-the-linux-bash-shell-on-windows-10/).
**UPDATE**: I am using WSL on Windows, running Ubuntu with these same config files, and things
work pretty mostly. Just remember that file operations can be slow, antivirus software needs to be told not to scan everything, and do not edit Linux files via Windows programs (though you can call Windows programs from Linux).

So without loss of generality, assume we're using Ubuntu.

Some obvious reminders: 
- `~` or `$HOME` is your home folder, such as `/home/wilder`. 

- Use `ln` to create [ symlinks ](https://kb.iu.edu/d/abbe). Make
  sure to use the **FULL PATH** for everything with `ln`, otherwise
  you might run into some funny infinite recursion. I've been there.

### A crash course in `PATH`

Look within the `env.sh` file to edit the `PATH` variable. `PATH`
tells zsh where to look for executable files to use as commands. It 
should look something like this

~~~shell
export PATH=$HOME/.gem/ruby/2.5.0/bin:$HOME/localpath:$HOME/.local/bin:$PATH
~~~

Notice another `PATH` within the definition of `PATH`. It means the
system already has a built-in `PATH` variable, and we are simply
adding more to it.   I used to put `PATH` in the `.zshrc` file, but
then found it useful to separate such variables away from `.zshrc`,
so I created `env.sh` and tell `.zshrc` to load `env.sh` instead.
The reason for using 2 files is so that I might switch to another
shell in the future and tell that shell to load the same `env.sh`.
`PATH` is an example of an *environment variable*. Normally, when
things don't run and programs don't see each other, it's usually
because they have their environment variables set up wrong.

Try running

~~~
which ls
echo $PATH
~~~  

You will see that the command `ls`, often  used to list files in a
folder, is really just the executable file `/bin/ls`, and `/bin` is
indeed contained in `PATH`. That's how zsh sees it, and uses `ls`
as a command. Otherwise, we would have to type the full location of
the executable file every time we wish to run it.  Finally, restart
zsh whenever you edit `.zshrc` or `env.sh`.

### Compiling and installing 

On Ubuntu, we often just install programs from `apt`. For instance, `sudo apt
install wget` will install `wget`.  To build and install programs from sources
(either because you want the bleeding-edge versions or change some build options),
usually you just need to download the sources, then follow instructions in
files like `INSTALL` or `readme`. Usually, it involves 3 steps (though some may
be omitted):

-  Configuration: checking where the libraries / dependencies required are in
   your system. Usually, but not always, this is done by a `configure` file in
   the source folder, so just `cd` to the source folder and run `./configure` .
   This is where we can often set many options for the software. Again, read
   the instructions for each program. The developer might use something else
   for configuring, so there might be no `configure` file. If any dependencies
   are missing, you'll need to install them.

    
-  Compilation: turning the source code into executable binaries. Usually, this
   is done by running `make`. We can often add the flag `-j8` after `make` (so
   `make -j8`) to speed things up. There might be other make flags available,
   depending on the program.

-  Installation: putting the binaries into your system directories. Usually,
   you just need to run `sudo make install`. But **BEWARE**, this is usually
   just copying files manually into your system, and you should never actually
   do this, as you can't easily uninstall those files, and `apt` (the default
   package manager of Ubuntu) won't know about those files. A safer method
   on Ubuntu is to add `checkinstall` right after `sudo` and before the
   install command (with flags).  So often you just run `sudo checkinstall
   make install`, which will turn the program into an actual `.deb` package
   file, and installing that `.deb` file will allow `apt` to track those
   files, so that you can remove them later as a package via `apt`.
   `checkinstall` allows you to set some options for the package, such as
   its name, version etc. As an example, let's say `checkinstall`, after
   running,  creates `myprogram.deb`, then we just need to run `sudo dpkg
   -i myprogram.deb` to install it.

Each program might use different tools, such as `meson`, `cmake`, `ninja` etc.
So the actual commands and flags might vary. Again, read the instructions for
each program. For instance, a program might use `ninja install` instead of
`make install`, so you'd need to run `sudo checkinstall ninja install` instead.
By default, if you just run `sudo checkinstall`, it is the same as running
`sudo checkinstall make install` (which might not be what you want for certain programs).

### Downloading the repo

Among the programs, nvim, tmux and zsh are the most important as they
affect each other and are indispensable on any Linux server; while
urxvt, weechat, mpv are optional. In particular, urxvt is a GUI
application, so there is no need to install it on servers.


To download/clone this repository, call

~~~shell
sudo apt install git wamerican 
git clone  https://github.com/mortang2410/dotfiles ~/dotfiles
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/zsh-syntax-highlighting
~~~

Then copy things in `~/dotfiles` to `~`. There are some new font files in
`~/.fonts`, so remember to run `fc-cache -vf` to refresh the font cache (or
just restart your computer). **From this point forward, we assume all the files
are already copied to `~`.** This is important, since my configuration covers a lot of settings. Things to install after cloning: 

- To change the default shell to zsh, install zsh by `apt`. Credits to PythonNut for inspiration.
  For WSL users, `zsh` might complain about insecure directories and file
  permissions. Just run
  
  ~~~
  compaudit | xargs chmod go-w
  ~~~

  to fix it.
  To make sure all keymaps are okay with your terminal, run `zkbd` and
  follow the instructions carefully. Once it finishes, it will create a file with some names like
  `$HOME/.zsh.d/.zkbd/rxvt-unicode-256color-:0`. Then just put `source <file>` at the 
  end of `~/.zshrc` (replace `<file>` by the name of the file `zkbd` created).
  
  Then if you want to make `zsh` the default shell,
  execute `chsh` in your current shell to change to the Z shell.  You might
  need to log out and return for the change to take effect. **From this point
  forward, we assume we're using zsh to run any commands.** For instance,
  I have a `checkinstall` alias for zsh to make `checkinstall` automatically
  pick Debian/Ubuntu packages. If you're not on Ubuntu/Debian, as  I said at
  the beginning, modify the packages / package managers accordingly.


- **Important**: if you don't like nvim and want to use vim (though I
  don't recommend so), then look in `.zshrc` for the line `export
  EDITOR='nvim'`, and change `nvim` to `vim`. Note that I use the
  same .vimrc file for both vim and nvim (technically, nvim uses
  init.vim, but I tell it to just lazily source .vimrc). This
  **must** be done before installing the plugins for nvim/vim, as
  some plugins like  LanguageClient must decide to run in nvim mode
  or vim mode (otherwise just reinstall them).

- The programs themselves: vim/nvim, tmux, zsh, urxvt, weechat, mpv, ranger.
  Usually we just need to use `apt` for installation.  Some require more
  attention, and this guide will talk about them.

- In particular, vim needs to be up-to-date, and obviously compiled
  with support for python3, ruby and all that jazz (sadly in Ubuntu
  18.04 the default package sucks so you need to compile it
  yourself!). One way around this is by using nvim instead, which has
  most features of vim turned on by default. The transition to nvim
  was so painless  I now prefer it to Vim. People on Ubuntu can
  install nvim as follows: 

  ~~~shell 
  sudo apt install python3-pip curl 
  [ -f ~/.local/bin/nvim ] && rm -f ~/.local/bin/nvim  
  sudo add-apt-repository ppa:neovim-ppa/unstable
  sudo apt install neovim
  pip3 install --user --upgrade neovim 
  pip3 install --user neovim-remote
  ~~~
  
   Notice that I remove any local version of `nvim` in `.local` (otherwise we
   can't run the systemwide version from `apt`). You might have this local
   version if you've installed `nvim` by hand (or from my older guide), but if not, it's just a sanity
   check. Once nvim runs, there might be errors since plugins are missing. Just
   do a `:PlugInstall` so that the plugins are automatically downloaded and
   installed.  Vim oldtimers can use  `:h nvim-from-vim` to see what have
   changed. Then use `:checkhealth` to make sure `nvim` sees all the ruby,
   python, lua libraries (if not, then install them and configure `PATH`
   properly). I recommend reading about how
   [vim-plug](https://github.com/junegunn/vim-plug) works. Do a `:PlugInstall`
   and `:PlugUpdate` to make sure everything is updated (before that vim / nvim
   might display some errors).


- Install `tmux` via `apt` as usual. Upon starting tmux, press `C-b I`  (`C-b` stands
  for `Ctrl+b`) to install tmux plugins.

- urxvt. The default Ubuntu package rxvt-unicode-256color is good enough. But I
  use my own version, which has support for wide glyphs and emoji
  (non-colored).]
  
  ~~~ shell
  git clone https://github.com/mortang2410/rxvt-custom ~/urxvt
  sudo apt-get build-dep rxvt-unicode
  sudo apt install libxft-dev libgdk-pixbuf2.0-dev
  cd ~/urxvt/rxvt-unicode
  ./configure \
    --prefix=/usr \
    --enable-256-color \
    --enable-combining \
    --enable-fading \
    --enable-font-styles \
    --enable-iso14755 \
    --enable-keepscrolling \
    --enable-lastlog \
    --enable-mousewheel \
    --enable-next-scroll \
    --enable-perl \
    --enable-pointer-blank \
    --enable-rxvt-scroll \
    --enable-selectionscrolling \
    --enable-slipwheeling \
    --enable-smart-resize \
    --enable-startup-notification \
    --enable-transparency \
    --enable-unicode3 \
    --enable-utmp \
    --enable-wide-glyphs \
    --enable-wtmp \
    --enable-xft \
    --enable-xim \
    --enable-xterm-scroll
  make -j8
  sudo checkinstall
  ~~~

  Then install the extensions. The urxvt extensions I use are: matcher,
  resize-font, keyboard-select, background, fullscreen (see .Xresources).  If
  your distro does not already bundle those extensions along with urxvt,
  google, download and install them into `.urxvt/ext`. My repo already contains
  some extensions, if you haven't already noticed. 
  

- [vimpager](https://github.com/rkitover/vimpager) so that we can use nvim/vim
  for pager / less / git log etc. 

  ~~~shell
  git clone git://github.com/rkitover/vimpager ~/vimpager
  cd ~/vimpager
  sudo make install-deb
  ~~~  


- Language servers for
  [LanguageClient-neovim](https://github.com/autozimu/LanguageClient-neovim).
  Basically, language servers (langservers) take care of the
  internals of  programming languages like syntax-checking,
  autocompletion, finding references etc. so that any text editors
  can have access to such goodness. [ Read about them
  here](https://langserver.org/). For instance, I use
  [pyls](https://github.com/palantir/python-language-server) for
  python and [ccls](https://github.com/MaskRay/ccls) for C++. To
  install pyls on Ubuntu 18.04:

  ~~~shell
  pip3 install --user 'python-language-server[all]' 
  ~~~
  
  Then pyls will be installed into `.local/bin`  (again, make sure
  that directory is in `$PATH`). Then LanguageClient-neovim should
  see pyls and automatically work. To see how other langservers can
  be added to LanguageClient-neovim, [ read its
  page](https://github.com/autozimu/LanguageClient-neovim#quick-start).

- By default, the `:PlugInstall` of nvim above will also install fzf
  (fuzzy finder) into `~/.fzf`. But we still need to make sure the
  binary `~/.fzf/bin/fzf` can be found in `$PATH`. For instance, by
  putting a symlink in `~/.local/bin` (assuming `~/.local/bin` is in
  your PATH variable). 

- [zathura](https://pwmt.org/projects/zathura/) for vimtex. 
  
  ~~~shell
  sudo apt install zathura zathura-djvu
  ~~~

  Or use your favorite pdf viewer and modify vimtex options. I just like the
  shortcuts and minimalism of `zathura`. Anyhow, if you want to use `zathura`
  with tabs, try using `tabbed` from [suckless](https://suckless.org/). You can
  use my own version here

  ~~~shell
  sudo apt install libx11-dev libfreetype6-dev
  git clone https://github.com/mortang2410/tabbed ~/tabbed
  cd ~/tabbed
  sudo checkinstall make clean install
  ~~~

  After that, you can use `tza` (my own command) to launch tabbed zathura. Use
  `C-<tab>` to switch between tabs just like firefox.  `ranger` should also use
  `tza` as soon as `tabbed` is installed.

- ranger itself. We also need `w3m` (for previewing images) and `highlight`
  (for syntax highlighting). For previewing pdf and djvu, we need
  `djvulibre-bin` and `poppler-utils`. Install them by apt. For ranger,
  however, we probably want the [ git
  version](https://github.com/ranger/ranger), which contains many new updates
  at this time of writing. Check their page for the optional dependencies as
  well, and make sure you install them. I also use
  [fasd](https://github.com/Vifon/fasd) for autocompleting frequent dirs/files.
  It appears that the [ original repo](https://github.com/clvv/fasd) for fasd
  is dead (thanks to Vifon for the warning), so I now use Vifon's repo instead.
  When we installed `zsh`, we should have already gotten `fasd` (just try
  running it in the shell), so no need to do anything for `fasd`. For ranger,
  on Ubuntu you should have most things already installed, so it will probably
  look like this 

  ~~~shell
  sudo apt-get build-dep ranger
  sudo apt install w3m highlight atool poppler-utils djvulibre-bin checkinstall python python-urwid
  git clone https://github.com/ranger/ranger ~/ranger
  cd ~/ranger
  sudo python3 setup.py install --optimize=1 --record=install_log.txt
  sudo checkinstall python3 setup.py install --optimize=1 --record=install_log.txt
  ~~~

  Once you are ready to live with ranger as the default file manager, run 

  ~~~shell
  xdg-mime default ranger.desktop inode/directory application/x-gnome-saved-search
  ~~~

  Obviously we assume `ranger.desktop` is already in the right place, such as
  `~/.local/share/applications`. This should already be the case when we copied
  everything from `~/dotfiles` to `~`. 

You're done. Now just find some quickstart guides to see how those
programs work.

If you have set up everything correctly:
- Navigating between tmux and vim  should be seamless with C-h,C-j,C-k,C-l.

- Man pages can be viewed with nvim (try `man git`).

- We can do fuzzy completion in the shell. Try running `ls ~ | fzf` in zsh.
  Also `<C-t>` should ivoke fzf within zsh.

- Try `<Space>re` in `nvim` to quickly open `ranger` to pick a file for editing.


![desktop](https://camo.githubusercontent.com/d015da143a73a3cfacdfcaaa7040ed475b4f34ff/68747470733a2f2f692e696d6775722e636f6d2f493835584368342e6a7067)

## Misc 

- `pandoc` is important for converting between markdown, latex and html. Install the latest version by

  ~~~shell
  curl -sSL https://get.haskellstack.org/ | sh git clone
  https://github.com/jgm/pandoc ~/pandoc cd ~/pandoc stack setup stack install
  ~~~

- `rg` (ripgrep) is better than `grep`, and `fd` is better than `find`. They
  have some crazy optimizations going on, and are written in Rust, which is very interesting.
  Download their `deb` file and install them. For example:
  
  ~~~shell
  sudo apt install wget
  wget https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb -O ~/rg.deb
  sudo dpkg -i ~/rg.deb
  wget https://github.com/sharkdp/fd/releases/download/v7.1.0/fd-musl_7.1.0_amd64.deb -O ~/fd.deb
  sudo dpkg -i ~/fd.deb
  ~~~

  Then run `:Rg pattern` in `nvim`. 

- I'm also trying out `st` from suckless. This little terminal can indeed
  replace `urxvt` as most features are already taken care of by `tmux`. `tmux`
  can even select URLs and copy them into its clipboard, but the final part of
  actually launching a browser still depends on the terminal as we might be
  using `tmux` over `ssh`. Use `<M-l>` to select & copy the last URL, and
  `<M-o>` to open any URL in the clipboard.

  ~~~shell
  git clone  https://github.com/mortang2410/st ~/st
  sudo apt install libx11-dev
  cd ~/st
  make
  sudo checkinstall make clean install
  ~~~

  That said, that are 2 big drawbacks, which make me stay with `urxvt` for now:
  - `st` does not support background images. The farmer blood runs in my veins, and I must rice.

  - `st` does double-buffering, and `w3m` does not yet work on it properly.
    Technically, `st` is not at fault here, as `w3m` does render in a hackish
    way. But still I rely on `w3m` a lot, so I must patch `w3m` myself if
    I want to use `st`. 


## Windows Subsystem for Linux

So I got stuck with my Windows Surface laptop, and came to the realization that
there was no Windows replacement for the Linux software stack that I've come to
rely on. And having to install Git, Python etc. for Windows has become
a serious pain. Also, I need to use vim on the go.
Apparently the best choice today is to get Linux running on Windows
via WSL (Windows Subsystem for Linux). Basically some cool people went to work
at Microsoft, saw that their command line tools sucked, didn't fancy the
cumbersome approach of using a virtual machine, so they decided to make the
Windows kernel support Linux system calls. Kinda like the opposite direction of
WINE. Only that Microsoft has more money, Linux system calls are easily
studied, and their NT kernel already had some support for POSIX.

I have tried Cygwin, Gnu on Windows, Babun, virtual machines etc. in the past
and they were all flawed in their own terrible ways.  So I didn't have high
hopes. But the process was [ surprisingly
painless](https://docs.microsoft.com/en-us/windows/wsl/install-win10), and I
already have this guide for setting up everything quickly with all the
important reminders. :)

Now, after using WSL for a while, I see that:

- Mostly everything works fine, including everything in this guide except
  `urxvt`, which is the only GUI application used for running the command line
  tools. I suspect I can get the Linux graphical stack set up, but I have no
  need for 2 desktops.

- No crashes or egregious stability problems that I've encountered yet. Though
  to be fair, I only use command line applications. I imagine that GUI
  applications, or the `X server` of WSL, will present more graphical problems.

- The whole Linux installation is surprisingly small, even with all my tools installed (around 1.6 GB). Very nice as this laptop doesn't have so much storage. It is not *as* fast as true Linux, but it doesn't hamper my workflow.

However, there are still some drawbacks:

- Windows isn't yet efficient at writing a lot of small files the way Linux is
  (and I doubt it will ever be). And seriously, tell Windows defender to stop
  checking everything. [ Follow this guide
  ](https://medium.com/@leandrw/speeding-up-wsl-i-o-up-than-5x-fast-saving-a-lot-of-battery-life-cpu-usage-c3537dd03c74),
  except the part about turning off real-time protection, of course. Not even I am that radical about speed. 

- Linux kernel modules like `fuse` are not yet supported. (though Microsoft has
  stated it is a priority in the future) This also means tricks like `sshfs`
  mounting, or anything closely related to the Linux kernel might not be
  supported. Though this is quickly changing. Already the Insider Preview Build
  of Windows contains more enhancements than the version I have (I won't update
  soon though because Microsoft has a terrible history of [ messing up
  updates](https://www.theverge.com/2018/10/5/17940902/microsoft-windows-10-october-2018-update-deleting-documents-issues).

- Some tinkering is required to translate the clipboard and file paths between
  Windows and WSL (mainly `clip.exe`, `ClipOut.exe` and `wslpath`). 

WSL tips 
---------------

Use the `wsltty` terminal. Install by `chocolate` as instructed.

To copy a file under WSL to your Windows clipboard: `cat report.txt |
clip.exe`

To view the contents of your Windows clipboard, download from this and
put into system32 so that WSL can see it. Then Vim can operate with the
Windows clipboard ( `<Leader>v` by default).
<http://jasonfaulkner.com/ClipOut.aspx>

Don't forget about unison for syncing (see `zsync_wiki` in `.zshrc`).

Use `wslpath` to convert between Windows and WSL paths. Use it to
symlink firefox.exe to `~/.local/bin/firefox` for example.

`checkinstall` requires `fakeroot`, which doesn't work, so fix it by
running

`sudo update-alternatives --set fakeroot /usr/bin/fakeroot-tcp`



Vim tips (messy, for personal use) 
------

`:g/^\s ids/s/\\_/_/g` : set the range to be all lines containing ` ids` at the beginning, then within those lines, replace `\_` with `_`

Ranger-vim: `<leader>re` to let ranger choose file for editing.
`<leader>rp` to paste last dir open by rangervim, and `<leader>rc` to cd there directly.

To put rg results into quickfix, try\
`cex system('rg comp --hidden -nH')` 

In pandoc, try `viS` to select everything in the whole section.

In `vimtex`, use `cse` to change surrounding environment. `tse` : toggle star environment. I set `<localleader>ld` to open doc for EVERYTHING, from packages and document classes to internal commands like `\frac`. Use `<localleader>lt` to open outline / TOC, and `<localleader>lT` to close it. See `VimtexImapsList` to get the mapping in insert mode, mostly for math environment. `<m-i>` to add `\item`. Also `:h quicktex` to see how awesome it is over snippets: `<space>` to autotrigger completion and double space to jump to next `<++>`. I have the dictionary in `~/.vim/myvimtex.vim`

To filter a buffer, try `%! rg pattern`, or replace `rg` with `grep` if that's what you prefer.


`<leader>K` to open dasht for dash docsets. Has internal latex commands like `\frac`, but nothing about packages, and not as good as vimtexdoc. But dash has more docsets about other things like `bash` and `zsh`.


`<leader>fc` to cd to current file.\
`<leader>Tu` to update tags for the current file. Doesn't work sometimes so manual `:!ctags %` is okay. Also `<leader>Ta` to update tags for everything in pwd. DON'T try this on `~`.\
`<leader>Tf` to search through tags with fzf, which is useful when tags require exact name matching, eg. `recover` won't match `s:recover`.

`<C-PgDown>` to scroll in completion popup menu.\
Global marks are uppercase. Local ones are lowercase.

`vim-matchup` now provides enhancements for `%` (begin and end of matching pairs like function / endfunction), and text objects like `di%`. However, `timeoutlen` requires inputting fast for text objets. Also better motions like `g%`, `]%` etc.

Use narrow regions to edit blocks of text (useful for latex blocks in pandoc for instance). Press `<leader>nr` to open narrow region, and `<leader>et` to edit as tex. All the latex plugins work now. I also map the whole thing to `<leader>nt` for short. Update:  `pandoc-after`  automatically sets ft=tex  after `:NR`, for big Tex blocks like `begin{equation}`, but `$$` blocks still don't work yet.\
If you want to do  it more fully with preview, use a good tex file as a template and paste the code there. 

`:NR!` opens a whole new buffer. Either save it to accept changes, or just unload it to go back to original buffer. Don't quit the window though if it's your last window

Use `gx` to open link with special file handlers like `xdg-open`, and `gf` to open in vim directly. Use `Ctrl-6`, `<space>6` or `:e #` to jump to previous file.

Use `:Rg` to search within files. REALLY FAST. Just be careful that `rg` ignores some files by default (e.g. `.git` and the contents of `.gitignore`)

`Recover.vim` is awesome. Press `c` to compare with swap file, and `<leade>fR`
to finish recovery.

I now use `polyglot` for language packs. This might interfere with other
language packages, such as LatexBox vs vimtex.   

To Fzf the output of a vim command : `MyFilter <command>`

Vim debugging: 
- `ToggleVerbose`
- `vim -V20 2>&1 | tee logfile`

Use text objects: `dat`, `dit` (HTML tags), `di\[`, `di/` (where / is a text
object defined in my .vimrc) See `:h it`.

On WSL (windows), use `<Leader>y` to work with the Windows Clipboard.

Let's say you grep  
 `grep -nH pattern -ir .`  
 but then want
to open those files with vim, run  
 `vi -q <(!!)`  
 where `-q` starts quickfix from the file which is the output of the previous
command.  


Run  
 `:Capture let g:lmap`  
 To see the dictionary. Then copy
the output and then paste   
 `:Capture PP  <the_output>`  
 to
view the dictionary in pretty form  


`:Messages` to view old messages  
 The `<Leader>` key is now the
Spacebar.  


F5 : languageclient menu


`\CPATTERN` to search for `PATTERN`, case sensitive. `\c` does the
opposite.  
 `/function \([a-zA-Z0-9]\+\)/ `  
 and  

`/\vfunction ([a-zA-Z0-9]+)/`  
 both match \"function foo42oo\" .
  


Use of \"\\v\" means \"very magic\": in the pattern after it all ASCII
characters except \'0\'-\'9\', \'a\'-\'z\', \'A\'-\'Z\' and \'\_\' have
a [special](special) meaning. See `:h magic`

`<tab>` on us snippets (UltiSnips) to expand them, C-b, C-f to go back
and forward between spots  
 `:UltiSnipsEdit` to edit snippets in
\~/.vim/UltiSnips  


`zo:` open folding  
 Indent json file:   `:%!python -m json.tool`  or  `:%! pretty-js`

see the relative number lines? try `10<Down>` to go down 10 lines.  

`F3` : \"+p, paste from clipboard in normal mode and copy in visual mode
(\"+y)  
 `dap:` delete a paragraph  
 `<Space>h` : recent files
in vim  

`:Mkdir!` : create dir for current file  
 `:r <filename> ` : insert
file into current buffer, filename CAN contain spaces  


`df"` : delete until next \"   
 use `:diffthis` on 2 panes to
diff  
 `M-l` : turn off search hilighting  
 `:Voom <mode>` to see outline in markdown / latex. Use `<tab>` to switch windows, `q` to close the voom window.\
 `gO` : outline in man and help
pages  
 `gq` : format by \'formatexpr\'  
 `gw` : format without
\'formatexpr\'  
 `<Space>f` : format current paragraph  

`:lopen` to open loclist (local to window)  
 `:copen` to open
quickfix (global)  
 `,v` : toggle less mode for vimpager  
 `mx`
: Toggle mark \'x\' and display it in the leftmost column  
 `` `x `` :
jump to mark x.   
 `` `0 `` : jump to position in last file edited (when
exited vim)  
 `m<Space>` Delete all marks from the current
buffer  
 `:bd` :buffer unload  
 `"+p` : paste from
clipboard  
 `"+y:` yank into clipboard  
 `s/abc/123/gc` :
replace with confirmation  
 `s/\n/&\r/g` : replace end-of-line with
empty new line  
 `gd:` go to definition  
 `gq` : reformat text
to pretty up  
 `<Space>p l` to use fzf on lines,   
 `<Space>p f`
to open CTRLP in files mode. Then `C-f` to switch between modes
(lines,files, buffers, MRU\...). I use CtrlP for current dir by setting
max depth to 1, and fzf for deep dirs.  
   
   
 `C-x C-f `in
insert mode to insert a filename with fzf.  
 `M-x` : like emacs
command with fzf.   
 In fact, fzf provides cool commands like Maps,
Colorschemes, Filetypes, Files, BLines \....  
 `s` : easy motion!!
(overwritten vim\'s default s), with \<Space\>\<Space\> as prefix for
other stuff  
 `S` : easy motion by 2 characters  
 Use SudoWrite
from suda.vim  
 Use Locate from fuzzy finder  
 Press cd while in
 `<Space>t` : quick find files by fzf  
 `<Space>b` :quick find buffer by fzf  

`:help` key-notation   


Browse old files: `:bro ol` then we might need to hit q to make prompt
appear if list is too long Or `:Capture ol` , then use `gf` to jump to
file

vim and tmux navigation between panes: use C-h,C-j,C-k,C-l zshrc makes
vim \--servername to play well with vimtex

`:helpgrep` something, then `:copen` to see results

To comment out blocks in vim:

        press Esc (to leave editing or other mode)
        hit ctrl+v (visual block mode)
        use the up/down arrow keys to select lines you want (it won't   highlight everything - it's OK!)
        Shift+i (capital I)
        insert the text you want, i.e. %
        press EscEsc

For file name omni completion in insert mode, you can use: Ctrl-X Ctrl-F

Edit in command bar: C-f

See ex-commands\' output in new buffer: `:Capture <command>`

To see what linters ALE is using: `:ALEInfo`

Install vimpager

vim-tex:   
 `<Space>ll` compile  
 `<Space>lv` view with synctex.
Ctrl-click on zathura to do reverse.  


`F4` for undotree toggle. Double click to jump to the one you want.
Persistent undos between sessions.

To select and surround: use v to enter visual mode and select abc, then
S\[ to surround -\> \[abc\]

`:Ncm2Sources` My own hackish function to look at enabled sources in
ncm2.

`C-x C-t` in Insert mode in Markdown: thesaurus via vim-lexical  

`C-x C-k` as above: dictionary via vim-lexical  
 `Zen` : modified
distraction free mode  
 `Spell` and Unspell for ... spelling with vim-lexical.  `zg` to mark as a good word, and `]s` to move to next misspelling.


`:syntime on`  
 play around  
 `:Capture syntime report`  
 to
see what is slowing down vim  


Tmux tips
------------

dump pane: `C-b P`

reload config: `C-b C-r`

clear pane: `C-b k`

vi mode: `C-b [`, select with Space, then `y` to yank into system clipboard

with mouse mode on, use shift with mouse to select stuff / copy

Use `tmux loadb -` and `tmux saveb -` to paste into & from tmux clipboard. \

## weechat integration 

So in weechat, I set:\
`/set plugins.var.lua.urlselect.cmd.i "/exec -bg -sh echo ${url} | tmux loadb -"`\
Then just `Alt-u` or `/urlselect`, choose link then `Alt+i` to paste link into tmux's clipboard.\
Also `<Esc>yy` to use weechat-vimode to paste input line into tmux clipboard via `tmux loadb -`
`/set plugins.var.python.vimode.copy_clipboard_cmd "tmux loadb -"`




## Ranger tips



 
To use ranger as default file manager:\
`xdg-mime default ranger.desktop inode/directory application/x-gnome-saved-search`\
Don't forget to put ranger.desktop in the right folder.\

I used the function "zranger" in zsh to start ranger instead (to remember quitting position)\
`2<C-f> `: fzf on current dir, 2 levels deep\
`?` to see help\
In comands, self.quantifier or prefix stands for stuff that goes before the command, like 6 in 6X\
`sD` : sudo delete selected files via   `:shell sudo rm %p`\
`` `h `` : fzf through navigation history (this session)\
`` `H `` : fzf through fasd's history globally\
`/` : filter current dir\
`S`: start shell in current dir\
`yy` to yank then [[:extracthere]] to extract archive with atool (WARNING: no dir created, all files are just extracted)\

`yp` : yank file path\
`yd` : yank dir path\

or use `X` for shell extract (a script from .scripts) into same-named dir

I added .scripts to `$PATH`

`mkd`: makedir and cd\
`om`: sort by mtime\
`F`: toggle flat\
`:flat 1` (flat 1 level)\
`m<key>` : bookmark, and `` `<key> `` to get there\
`c-n` : new tab, and `<Tab>` to switch\
`c-w` : close tab\

`zV` .  -> shell vim . -> enter\
`+x` : add x to file\
`w` : open task window\
`W` : open log window\
`V` to enter select mode\
`uv` to deselect all\
`H`, `L` : jump back and forth in history \
`cw`,` a`,`A`,`I` : rename in different ways like vim\

`zr`: reload config, useful for root ranger (with preview disabled)


## zsh tips

`cdr` for history of directories.

Now menu selection is liveable place:

 `^F` accept-and-hold\
 ` ${key[PageDown]}` forward-word\
 `${key[PageUp]}`  backward-word\

How to capture output of command as an array delimited by newlines\
`export array_of_lines=("${(f)$(cat testing.txt )}")`

Using config from PythonNut now, with `zaw`: try `<C-x>;` for filtering autocompletion.


Run `fc` to use vim on your last command. Try `fc -2` to edit the 2nd last command.

 Emacs mode (default at startup):\
type `C-x C-v` in the command line to start vi mode (no visible indication) or
`C-x C-e` to open the command in full vim. `M-x edit-command-line` to invoke
the command manually. Bash also has `C-x C-e` for vim editing.

`d <string>` : jump to frequent dir with \<string\> by fasd

imgur to upload to imgur

I now use fzf for autocompletion: try\
`cat txt<C-t>` and `<C-r>`

sudo -Es\
= mysu

`firefox &!`\
Open firefox and detach it immediately from the terminal.\

~~~
foo=alat
print ${foo:2}
~~~ 

will yield `at `\
See more at parameter expansion \${name:offset}

Assuming I am wilder.

    touch ~/lol.c
    cd ~
    print *.c(:a)

will yield `/home/wilder/lol.c ` (see modifiers in zshexpn)

    touch ~/lol.c
    cd ~
    print *.c(:r)

will yield` lol ` (see modifiers in zshexpn)

`for x in *.png ; print $x(:r)`\
Alternatively : `for x in *.png ; print $x:r`\
Print the filename (with the extension removed) of all png files in
current dir. See that the parentheses aren\'t required.

\

`ls *.7z | xargs -n 1 7z x -y -pebooksclub.org`\
Extract 7zip files in current dir whose password is ebooksclub.org

    for x in *.7z; do
    7z x -y -pebooksclub.org -o$x:r $x    
    done  

Extract 7zip files in current dir whose password is ebooksclub.org

`print -P %D{%I:%M}`\
Print current hour and minute. Because %D, %I, %M are all special prompt
escapes and require prompt expansion (a special type of expansion,
usually found when you define PS2 and stuff), we need -P for print.

`find programming/ebooks -iname "*refer*"`\
Somehow we must use double quotes in zsh in order to use the `find`
command.

\

`ls *(.)`\
list files

`cat lol | xargs -d "\n" -n 1 touch`\
touch all files listed in lol

`DIR="$(dirname "$(readlink -f "$0")")"`\
to get current dir of a shell script (even via a symlink)
