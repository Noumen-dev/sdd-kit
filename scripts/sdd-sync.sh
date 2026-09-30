#!/usr/bin/env bash
# Обновляет consumer до содержимого кита (force-copy файлов из kit).
# Заполненные cards/issue-*.md кит не содержит — они не затрагиваются.
set -euo pipefail

DEST="${1:-.}"
KIT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
exec "$KIT_ROOT/scripts/sdd-init.sh" --force "$DEST"
