#!/usr/bin/env bash

set -euo pipefail

# remove old config.fish
rm -rf ~/.config/fish/config.fish

# link config.fish
mkdir -p ~/.config/fish
ln -s $mdir/config.fish ~/.config/fish/config.fish

# get fisherman
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

# install fisherman plugins
fish -c "fisher install fishpkg/fish-prompt-metro"
