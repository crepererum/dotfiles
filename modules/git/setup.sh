#!/usr/bin/env sh

# cleanup
rm -rIf ~/.gitconfig ~/.gitignore

# link .gitconfig and .gitignore
ln -s $mdir/gitconfig ~/.gitconfig
ln -s $mdir/gitignore ~/.gitignore
git clone https://github.com/alberthier/git-webui.git ~/.git-webui

