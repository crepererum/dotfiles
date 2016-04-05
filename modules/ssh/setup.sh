#!/usr/bin/env bash

set -euo pipefail

# create .ssh if not exist
mkdir -p ~/.ssh

# link .ssh/config
ln -s $mdir/config ~/.ssh/config

