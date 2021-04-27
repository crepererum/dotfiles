#!/usr/bin/env bash

set -euo pipefail

# create target dir
mkdir -p ~/.config/fontconfig/conf.d

# link config files
for f in $mdir/*.conf; do
    target="$HOME/.config/fontconfig/conf.d/$(basename $f)"
    rm -rf "$target"
    ln -s "$f" "$target"
done
