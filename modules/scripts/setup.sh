#!/usr/bin/env bash

set -euo pipefail

# create scripts if not exist
mkdir -p ~/scripts

# link all scripts to that directory
for f in $mdir/scripts/*; do
    ln -s $f ~/scripts/$(basename $f)
done

