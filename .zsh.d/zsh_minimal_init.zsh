#!/usr/bin/zsh
# this file should be run exactly once immediately after this repo is cloned
# and whenever changes are made to files in modules

for file in ~/.zsh.d/modules/*.zsh; do
  echo zcompiling ${file}...
  zcompile -U $file
done

for file in ~/.zsh.d/modules_minimal/*.zsh; do
  echo zcompiling ${file}...
  zcompile -U $file
done

echo changing to .zsh.d directory...
cd ${${0:A}%/*}

echo git submodule init...
git submodule init

echo git submodule update...
git submodule update --init --recursive

echo git fetch...
git fetch --all

echo ensuring link...
ln -s ~/.zsh.d/.zshrc_minimal ~/.zsh.d/.zshrc 2> /dev/null
ln -s ~/.zsh.d/.zshrc_minimal ~/.zshrc 2> /dev/null
