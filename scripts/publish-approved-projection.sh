#!/usr/bin/env bash
# Временная publish-проекция: копирует tests/cases/issue-*.md со status: approved
# в tests/approved/ (compat на один релиз). SoT остаётся tests/cases/.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CASES="$ROOT/tests/cases"
DEST="$ROOT/tests/approved"

if [[ ! -d "$CASES" ]]; then
  echo "нет $CASES" >&2
  exit 1
fi

mkdir -p "$DEST"
copied=0
for f in "$CASES"/issue-*.md; do
  [[ -f "$f" ]] || continue
  # frontmatter status: approved (первая встреченная строка status:)
  status="$(awk '/^---$/{c++; next} c==1 && /^status:/{print $2; exit}' "$f" || true)"
  if [[ "$status" == "approved" ]]; then
    base="$(basename "$f")"
    cp "$f" "$DEST/$base"
    echo "project: $base"
    copied=$((copied + 1))
  fi
done

echo "готово: скопировано $copied файл(ов) в tests/approved/ (SoT = tests/cases/)"
