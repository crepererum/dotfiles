#!/usr/bin/env bash

set -euo pipefail

export dfdir=$(realpath $(dirname $0))

if [ ! -z "$1" ]; then
    modules=$(echo $1 | sed "s/,/ /g")
else
    modules=$(ls $dfdir/modules)
fi

for module in $modules; do
    echo "Install $module..."
    export mdir=$dfdir/modules/$module
    $mdir/setup.sh
done

