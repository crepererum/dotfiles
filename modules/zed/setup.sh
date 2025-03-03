#!/usr/bin/env bash

set -euo pipefail

# create .config/zed if not exist
mkdir -p ~/.config/zed

# cleanup
rm -f ~/.config/zed/settings.json

# link settings.json
ln -s $mdir/settings.json ~/.config/zed/settings.json
