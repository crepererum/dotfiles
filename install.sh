#!/usr/bin/env sh

export dfdir=$(realpath $(dirname $0))

for module in $(ls $dfdir/modules); do
    echo "Install $module..."
    export mdir=$dfdir/modules/$module
    $mdir/setup.sh
done

