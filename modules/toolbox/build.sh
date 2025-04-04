#!/usr/bin/env bash

set -euo pipefail

exec podman build \
    --pull=newer \
    --squash-all \
    --tag=toolbox-arch \
    .
