#!/usr/bin/env bash

set -euo pipefail

# remove old alacritty.toml
rm -rf ~/.config/alacritty/alacritty.toml

# link config
mkdir -p ~/.config/alacritty
ln -s $mdir/alacritty.toml ~/.config/alacritty/alacritty.toml
