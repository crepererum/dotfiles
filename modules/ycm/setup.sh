#!/usr/bin/env bash

set -euo pipefail

# cleanup
rm -rIf ~/.ycm_extra_conf.py ~/.ycm_extra_conf.pyc

# link .ycm_extra_conf.py
ln -s $mdir/ycm_extra_conf.py ~/.ycm_extra_conf.py
