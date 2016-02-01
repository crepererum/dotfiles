#!/usr/bin/env sh

# cleanup
rm -rIf ~/.vimrc ~/.viminfo ~/.vim ~/.config/nvim

# create nvim config dir
mkdir -p ~/.config/nvim

# link .vimrc and nvimrc
ln -s $mdir/vimrc ~/.vimrc
ln -s ~/.vimrc ~/.config/nvim/init.vim

# create view dirs
mkdir -p ~/.vim/view
mkdir -p ~/.config/nvim/view

# install vim-plug (vim)
mkdir -p ~/.vim/autoload
curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qa

# install vim-plug (nvim)
mkdir -p ~/.config/nvim/autoload
curl -fLo ~/.config/nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qa

# install YouCompleteMe
#cd ~/.vim/bundle/YouCompleteMe
#./install.sh --clang-completer

