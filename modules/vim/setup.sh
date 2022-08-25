#!/usr/bin/env bash

set -euo pipefail

# cleanup
rm -rIf ~/.vimrc ~/.viminfo ~/.vim ~/.config/nvim

# create nvim config dir
mkdir -p ~/.config/nvim

# link configs
ln -s $mdir/init.vim ~/.config/nvim/init.vim

# create view dirs
mkdir -p ~/.config/nvim/view

# install vim-plug (nvim)
mkdir -p ~/.config/nvim/autoload
curl -fLo ~/.config/nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qa
