#!/usr/bin/env bash

set -euo pipefail

# link config.fish
mkdir -p ~/.config/fish
ln -s $mdir/config.fish ~/.config/fish/config.fish
