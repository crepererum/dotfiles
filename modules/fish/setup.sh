#!/usr/bin/env bash

set -euo pipefail

# get fisherman
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

# remove old config.fish
rm -rf ~/.config/fish/config.fish

# link config.fish
mkdir -p ~/.config/fish
ln -s $mdir/config.fish ~/.config/fish/config.fish

# install fisherman plugins
fish -c "fisher nitro"
