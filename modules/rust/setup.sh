#!/usr/bin/env bash

set -euo pipefail

# curl https://sh.rustup.rs -sSf | sh

cargo install --force bingrep exa fd-find skim ripgrep tokei
