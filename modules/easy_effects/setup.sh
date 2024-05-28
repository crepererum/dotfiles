#!/usr/bin/env bash

set -euo pipefail

targets=("$HOME/.config" "$HOME/.var/app/com.github.wwmm.easyeffects/config")

for target in ${targets[@]}; do
    # cleanup
    path="$target/easyeffects"
    rm -rf "$path"
    mkdir -p "$target"
    cp -R "$mdir/easyeffects" "$path"
done
