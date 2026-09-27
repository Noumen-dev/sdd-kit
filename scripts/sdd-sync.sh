#!/usr/bin/env bash
set -euo pipefail
DEST="${1:-.}"
KIT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
exec "$KIT_ROOT/scripts/sdd-init.sh" --force "$DEST"
