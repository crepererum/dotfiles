#!/usr/bin/env bash

set -euo pipefail

# create .config/htop if not exist
mkdir -p ~/.config/htop

# cleanup
rm -f ~/.config/htop/htoprc

# link htoprc
ln -s $mdir/htoprc ~/.config/htop/htoprc
