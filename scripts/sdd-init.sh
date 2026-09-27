#!/usr/bin/env bash
set -euo pipefail
FORCE=0
DEST="."
while [[ $# -gt 0 ]]; do
  case "$1" in
    --force) FORCE=1; shift ;;
    -*) echo "Неизвестный флаг: $1" >&2; exit 2 ;;
    *) DEST="$1"; shift ;;
  esac
done
KIT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST="$(cd "$DEST" && pwd)"
copy_file() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [[ -e "$dst" && "$FORCE" -ne 1 ]]; then
    echo "skip (exists): $dst"; return 0
  fi
  cp "$src" "$dst"; echo "write: $dst"
}
echo "sdd-init: kit=$KIT_ROOT → dest=$DEST (force=$FORCE)"
copy_file "$KIT_ROOT/AGENTS.md" "$DEST/AGENTS.md"
copy_file "$KIT_ROOT/CONTRIBUTING.md" "$DEST/CONTRIBUTING.md"
while IFS= read -r -d '' f; do
  rel="${f#"$KIT_ROOT/"}"
  copy_file "$f" "$DEST/$rel"
done < <(find "$KIT_ROOT/docs" "$KIT_ROOT/tests" -type f -print0 2>/dev/null)
copy_file "$KIT_ROOT/cursor-skills/sdd-workflow/SKILL.md" "$DEST/.cursor/skills/sdd-workflow/SKILL.md"
while IFS= read -r -d '' f; do
  rel="${f#"$KIT_ROOT/github/"}"
  copy_file "$f" "$DEST/.github/$rel"
done < <(find "$KIT_ROOT/github" -type f -print0)
echo "sdd-init: готово"
