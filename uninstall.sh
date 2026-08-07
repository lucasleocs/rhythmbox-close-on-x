#!/usr/bin/env bash
set -euo pipefail

DEST_DIR="${HOME}/.local/share/rhythmbox/plugins/close-on-x"

if [[ -d "$DEST_DIR" ]]; then
    rm -rf "$DEST_DIR"
    echo "Removed:"
    echo "  $DEST_DIR"
else
    echo "Close on X is not installed at:"
    echo "  $DEST_DIR"
fi

echo
echo "Restart Rhythmbox if it is currently open."
