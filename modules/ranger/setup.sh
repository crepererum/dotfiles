#!/usr/bin/env bash

set -euo pipefail

# cleanup
rm -rIf ~/.config/ranger/rc.conf

# create conf dir if not exist
mkdir -p ~/.config/ranger

# link rc.confg
ln -s $mdir/rc.conf ~/.config/ranger/rc.conf
