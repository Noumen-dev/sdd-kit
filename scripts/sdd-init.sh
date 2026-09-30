#!/usr/bin/env bash
# Устанавливает каркас Noumen SDD kit в целевой репозиторий.
# Без --force не перезаписывает уже существующие файлы.
set -euo pipefail

FORCE=0
DEST="."

usage() {
  cat <<'EOF'
Использование: sdd-init.sh [--force] [DEST]

  --force   перезаписать файлы, которые уже есть в DEST
  DEST      корень consumer-репозитория (по умолчанию .)

Копирует:
  AGENTS.md, CONTRIBUTING.md, README.md (только если нет / при --force)
  docs/**, tests/**
  cursor-skills/** → .cursor/skills/**
  agent-skills/** → agents/** и .cursor/skills/** (portable roles, 1:1)
  github/** → .github/**
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --force) FORCE=1; shift ;;
    -h|--help) usage; exit 0 ;;
    -*)
      echo "неизвестный флаг: $1" >&2
      usage >&2
      exit 2
      ;;
    *)
      DEST="$1"
      shift
      ;;
  esac
done

KIT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [[ ! -d "$DEST" ]]; then
  echo "DEST не существует: $DEST" >&2
  exit 1
fi
DEST="$(cd "$DEST" && pwd)"

copy_file() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [[ -e "$dst" && "$FORCE" -ne 1 ]]; then
    echo "skip (exists): $dst"
    return 0
  fi
  cp "$src" "$dst"
  echo "write: $dst"
}

echo "kit:  $KIT_ROOT (VERSION=$(cat "$KIT_ROOT/VERSION" 2>/dev/null || echo unknown))"
echo "dest: $DEST"
echo "force=$FORCE"

# Корневые файлы процесса (README кита в consumer не затираем без --force —
# у продукта свой README; копируем только AGENTS/CONTRIBUTING).
copy_file "$KIT_ROOT/AGENTS.md" "$DEST/AGENTS.md"
copy_file "$KIT_ROOT/CONTRIBUTING.md" "$DEST/CONTRIBUTING.md"

# Указатель для Claude Code
if [[ -f "$KIT_ROOT/CLAUDE.md" ]]; then
  copy_file "$KIT_ROOT/CLAUDE.md" "$DEST/CLAUDE.md"
fi

# docs/ и tests/
while IFS= read -r -d '' src; do
  rel="${src#"$KIT_ROOT/"}"
  copy_file "$src" "$DEST/$rel"
done < <(find "$KIT_ROOT/docs" "$KIT_ROOT/tests" -type f -print0)

# процессный skill → .cursor/skills
if [[ -d "$KIT_ROOT/cursor-skills" ]]; then
  while IFS= read -r -d '' src; do
    rel="${src#"$KIT_ROOT/cursor-skills/"}"
    copy_file "$src" "$DEST/.cursor/skills/$rel"
  done < <(find "$KIT_ROOT/cursor-skills" -type f -print0)
fi

# portable role skills → agents/ и .cursor/skills/ (1:1, включая _shared)
if [[ -d "$KIT_ROOT/agent-skills" ]]; then
  while IFS= read -r -d '' src; do
    rel="${src#"$KIT_ROOT/agent-skills/"}"
    copy_file "$src" "$DEST/agents/$rel"
    copy_file "$src" "$DEST/.cursor/skills/$rel"
  done < <(find "$KIT_ROOT/agent-skills" -type f -print0)
fi

# github → .github
while IFS= read -r -d '' src; do
  rel="${src#"$KIT_ROOT/github/"}"
  copy_file "$src" "$DEST/.github/$rel"
done < <(find "$KIT_ROOT/github" -type f -print0)

# Метка версии кита в consumer (удобно для sync)
mkdir -p "$DEST/.sdd-kit"
if [[ "$FORCE" -eq 1 || ! -e "$DEST/.sdd-kit/VERSION" ]]; then
  cp "$KIT_ROOT/VERSION" "$DEST/.sdd-kit/VERSION"
  echo "write: $DEST/.sdd-kit/VERSION"
else
  echo "skip (exists): $DEST/.sdd-kit/VERSION"
fi
cat > "$DEST/.sdd-kit/SOURCE" <<EOF
repo=https://github.com/Noumen-dev/sdd-kit
version=$(cat "$KIT_ROOT/VERSION")
synced_at=$(date -u +%Y-%m-%dT%H:%M:%SZ)
EOF
echo "write: $DEST/.sdd-kit/SOURCE"

echo "готово: SDD kit установлен в $DEST"
