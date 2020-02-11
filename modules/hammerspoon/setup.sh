#!/usr/bin/env bash

set -euo pipefail

# cleanup
rm -rf ~/.hammerspoon

# create config dir structure
mkdir -p ~/.hammerspoon
mkdir -p ~/.hammerspoon/Spoons

# download spoons
curl \
    --fail \
    --location \
    --output /tmp/DeepLTranslate.spoon.zip \
    https://github.com/Hammerspoon/Spoons/blob/master/Spoons/DeepLTranslate.spoon.zip?raw=true
unzip /tmp/DeepLTranslate.spoon.zip -d ~/.hammerspoon/Spoons

# link init.lua
ln -s $mdir/init.lua ~/.hammerspoon/init.lua
