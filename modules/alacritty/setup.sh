#!/usr/bin/env bash

set -euo pipefail

# remove old alacritty.yml
rm -rf ~/.config/alacritty/alacritty.yml

# link config.fish
mkdir -p ~/.config/alacritty
ln -s $mdir/alacritty.yml ~/.config/alacritty/alacritty.yml
