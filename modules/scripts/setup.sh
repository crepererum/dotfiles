#!/usr/bin/env bash

set -euo pipefail

# create scripts if not exist
mkdir -p "$HOME/scripts"

# link all scripts to that directory
for f in $mdir/scripts/*; do
    target="$HOME/scripts/$(basename $f)"
    rm -rf "$target"
    ln -s "$f" "$target"
done

