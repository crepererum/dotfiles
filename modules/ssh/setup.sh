#!/usr/bin/env sh

# create .ssh if not exist
mkdir -p ~/.ssh

# link .ssh/config
ln -s $mdir/config ~/.ssh/config

