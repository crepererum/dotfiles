#!/usr/bin/env bash

set -euo pipefail

# cleanup
rm -rIf ~/.gitattributes ~/.gitconfig ~/.gitignore ~/.config/git

# link files
mkdir -p ~/.config/git
ln -s $mdir/gitattributes ~/.config/git/attributes
ln -s $mdir/gitconfig ~/.config/git/config
ln -s $mdir/gitignore ~/.config/git/ignore
