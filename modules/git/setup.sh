#!/usr/bin/env bash

set -euo pipefail

# cleanup
rm -rIf ~/.gitconfig ~/.gitignore

# link .gitconfig and .gitignore
ln -s $mdir/gitconfig ~/.gitconfig
ln -s $mdir/gitignore ~/.gitignore

# create hooks if not exist
mkdir -p ~/.githooks

# link all hooks to that directory
for f in $mdir/hooks/*; do
    t="$HOME/.githooks/$(basename $f)"
    rm -f "$t"
    ln -s "$f" "$t"
done
