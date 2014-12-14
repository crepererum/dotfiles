#!/usr/bin/env sh

# cleanup
rm -rIf ~/.vimrc ~/.viminfo ~/.vim

# link .vimrc and .nvimrc
ln -s $mdir/vimrc ~/.vimrc
ln -s ~/.vimrc ~/.nvimrc

# create view dirs
mkdir -p ~/.vim/view
mkdir -p ~/.nvim/view

# install vim-plug
mkdir -p ~/.vim/autoload
curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qa

# install YouCompleteMe
#cd ~/.vim/bundle/YouCompleteMe
#./install.sh --clang-completer

