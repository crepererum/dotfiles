#!/usr/bin/env sh

# cleanup
rm -rIf ~/.oh-my-zsh ~/.zshrc ~/.zsh_history

# clone oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# link zshrc
ln -s $mdir/zshrc ~/.zshrc

