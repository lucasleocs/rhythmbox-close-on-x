#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DEST_DIR="${HOME}/.local/share/rhythmbox/plugins/close-on-x"

mkdir -p "$DEST_DIR"
for file in close-on-x.plugin close-on-x.py; do
    install -m 0644 "$SOURCE_DIR/$file" "$DEST_DIR/$file"
done

echo "Installed Close on X to:"
echo "  $DEST_DIR"
echo
echo "Now open Rhythmbox and enable:"
echo "  Menu -> Plugins -> Close on X"
