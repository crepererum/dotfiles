#!/usr/bin/env bash

set -euo pipefail

# cleanup
rm -rIf ~/.config/base16-shell

# clone
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
