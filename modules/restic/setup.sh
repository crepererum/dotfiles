#!/usr/bin/env bash

set -euo pipefail

# remove old files
rm -f ~/.config/containers/systemd/restic.container
rm -f ~/.config/containers/systemd/restic.env
rm -f ~/.config/containers/systemd/restic.entrypoint
rm -f ~/.config/containers/systemd/restic.exclude
rm -f ~/.config/containers/systemd/restic.timer

# link/copy files
mkdir -p ~/.config/containers/systemd
mkdir -p ~/.config/systemd/user
ln -s $mdir/restic.env ~/.config/containers/systemd/restic.env
ln -s $mdir/restic.timer ~/.config/systemd/user/restic.timer
cp $mdir/restic.entrypoint ~/.config/containers/systemd/restic.entrypoint
cp $mdir/restic.exclude ~/.config/containers/systemd/restic.exclude

# assemble config
container_file="$HOME/.config/containers/systemd/restic.container"
cp $mdir/restic.container "$container_file"

echo "" >> "$container_file"
echo "[Container]" >> "$container_file"

for f in $mdir/secrets/*; do
    s="$(basename "$f")"
    echo "register secret: $s"
    podman secret create --replace "$s" "$f"
    echo "Secret=$s,type=mount" >> "$container_file"
done

# reload systemd
systemctl --user daemon-reload
systemctl --user enable --now restic.timer
