#!/usr/bin/env bash

set -euo pipefail

# cleanup
rm -rIf ~/.gitconfig ~/.gitignore

# link .gitconfig and .gitignore
ln -s $mdir/gitconfig ~/.gitconfig
ln -s $mdir/gitignore ~/.gitignore
git clone https://github.com/alberthier/git-webui.git ~/.git-webui

