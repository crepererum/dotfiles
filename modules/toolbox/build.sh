#!/usr/bin/env bash

set -euo pipefail

exec podman build \
    --squash-all \
    --tag=toolbox-arch \
    .
