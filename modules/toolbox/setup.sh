#!/usr/bin/env bash

set -euo pipefail

# https://gitlab.com/fedora/ostree/sig/-/issues/57
podman system reset --force
mkdir -p ~/.config/containers
rm -rf ~/.config/containers/storage.conf
ln -s $mdir/storage.conf ~/.config/containers/storage.conf

# build toolbox image
pushd $mdir
./build.sh
popd

# toolbox config
rm -rf ~/.config/containers/toolbox.conf
ln -s $mdir/toolbox.conf ~/.config/containers/toolbox.conf
