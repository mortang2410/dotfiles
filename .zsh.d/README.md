## zsh-config

My personal `zsh` config (to be put in `~/.zsh.d`)

* Enter a version control repository and it will automatically spawn an `inotify` service, start watching your files and live stream async version control information (like git dirty status) into the righthand prompt.
* Suffix aliases for all associated filetypes are generated from the environment MIME handler (via `zsh-mime-handler`)
* When completing remote filenames, `zsh` will fetch a list of remote files and complete them (via `zsh-url-httplink`)
* Automatically extract options and their descriptions from manpages and stream them to the completion system.
* etc.

My goal is to continue adding features and deep integration with other tools. I also want this to be portable to other forms of *NIX (Mac OS is a much more distant goal, as I don't own a Mac). Currently being tested on:

* Arch Linux
  + Working
* Fedora
  + 16 x32 Working
  + 20 x64 Working
  + rawhide Working
* Ubuntu
  + 14.10 x64 Working (with minor bugs)
* FreeBSD
  + 10 Mostly working
* Raspberry pi
  + Jessie working
  + Wheezy working

And with the following zsh versions

* `zsh` 4.3 (broken)
* `zsh` 4.6 (mostly broken)
* `zsh` 5.0+
