#!/usr/bin/env bash

set -euo pipefail

# create .gnuppg if not exist
mkdir -p ~/.gnupg

# link .ssh/config
ln -s $mdir/gpg.conf ~/.gnupg/gpg.conf

