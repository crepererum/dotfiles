#!/usr/bin/env bash

set -euo pipefail

# cleanup
rm -rIf ~/.vimrc ~/.viminfo ~/.vim ~/.config/nvim

# create nvim config dir
mkdir -p ~/.config/nvim

# link configs
ln -s $mdir/init.lua ~/.config/nvim/init.lua

# create view dirs
mkdir -p ~/.config/nvim/view
