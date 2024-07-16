#!/usr/bin/env bash

set -euo pipefail

# cleanup
rm -rIf ~/.config/jj

# link files
mkdir -p ~/.config/jj
ln -s $mdir/config.toml ~/.config/jj/config.toml
