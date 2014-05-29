#!/usr/bin/env sh

# cleanup
rm -rIf ~/.vimrc ~/.viminfo ~/.vim

# link .vimrc
ln -s $mdir/vimrc ~/.vimrc

# install vundle
mkdir -p ~/.vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# install YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer

