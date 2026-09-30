# Runbook — установка машины разработчика (Win / macOS / Linux)

SoT этого runbook — **sdd-kit** (`docs/runbooks/dev-machine-setup.md` в ките).  
После `sdd-kit-sync` / `sdd-init` копия лежит в consumer: `docs/runbooks/dev-machine-setup.md`.

Что поставить, чтобы чат/граф Fragmenta и skills роя работали. Soft-fail: отсутствие части MCP/CLI **не** делает чат мёртвым.

Связанные доки: [`docs/tools/sdd-kit.md`](../tools/sdd-kit.md) (в consumer) · [`docs/agent-skills.md`](../agent-skills.md) · skill процесса [`.cursor/skills/sdd-workflow/SKILL.md`](../../.cursor/skills/sdd-workflow/SKILL.md).

---

## 1. Минимум (чат/граф не мёртв)

| Компонент | Зачем | Win | macOS | Linux |
|-----------|-------|-----|-------|-------|
| **Node.js LTS** | сборка extension, `scripts/*.mjs`, Playwright MCP | [nodejs.org](https://nodejs.org/) / winget | Homebrew / pkg | distro / nvm |
| **Go** (1.22+) | `orchestrator` (если есть в consumer) | MSI / scoop | Homebrew | distro / go.dev |
| **Git** | ветки SDD, vendor kit | Git for Windows | Xcode CLT / brew | distro |
| **Fragmenta Preview** | host extension `agents` | установщик Preview | — | — |
| **≥1 provider CLI** | Cursor **или** Hermes **или** Claude | PATH | PATH | PATH |

Без полного набора CLI чат не блокируется — достаточно одного живого провайдера.

Проверка:

```bash
node -v
go version
git --version
```

---

## 2. SDD kit

Кит завендорен в `vendor/sdd-kit/` (или clone [Noumen-dev/sdd-kit](https://github.com/Noumen-dev/sdd-kit)). Обновить процесс и role skills:

```bash
# опционально, если есть доступ к remote
git -C vendor/sdd-kit pull --ff-only

# SoT sync — один вход для Win / macOS / Linux
node scripts/sdd-kit-sync.mjs
```

| ОС | Команда |
|----|---------|
| Windows (PowerShell / cmd) | `node scripts\sdd-kit-sync.mjs` |
| Windows + Git Bash / WSL | `node scripts/sdd-kit-sync.mjs` или `./scripts/sdd-kit-sync.sh` |
| macOS / Linux | `node scripts/sdd-kit-sync.mjs` или `./scripts/sdd-kit-sync.sh` |

Sync ставит шаблоны docs/tests, `sdd-workflow`, github templates и **portable role skills** из `vendor/sdd-kit/agent-skills/` → `agents/<id>/` и `.cursor/skills/<id>/`.  
Продуктовые оверлеи (`AGENTS.md`, `registry.yaml`, product workflow и т.п.) не затираются — см. [`docs/tools/sdd-kit.md`](../tools/sdd-kit.md). Версия: `.sdd-kit/VERSION`.

---

## 3. MCP по skills

Конфиг Cursor/Fragmenta: `.cursor/mcp.json` (или user-level). Id ниже должны совпадать с `mcp_allowed` в frontmatter skills.

| Config id | Пакет / бинарь | Роли (`mcp_allowed`) | Обязательность |
|-----------|----------------|----------------------|----------------|
| `codebase-memory-mcp` | `codebase-memory-mcp` / `.exe` — install per OS | analyst, architect, dev, techlead, qa | желательно |
| `ataraxy-sem` (`sem`) | `sem` / `sem.exe mcp` | те же | желательно |
| `ataraxy-weave` (`weave`) | `weave-mcp` (часто через `cargo`) | те же | желательно |
| `playwright` | `npx -y @playwright/mcp@latest` | **только QA** | для web e2e |
| `filesystem` | `npx -y @rustmcp/rust-mcp-filesystem@…` | опционально (Architect/локальные пути) | опционально |
| `noumen` | Fragmenta Preview + mcp-proxy pipe | host Preview | для Fragmenta MCP |

---

## 4. Эталон `mcp.json` (плейсхолдеры)

Не хардкодить один User. Подставь пути своей ОС.

### Windows (PowerShell / `%LOCALAPPDATA%`)

```json
{
  "mcpServers": {
    "codebase-memory-mcp": {
      "command": "%LOCALAPPDATA%\\Programs\\codebase-memory-mcp\\codebase-memory-mcp.exe",
      "args": []
    },
    "ataraxy-sem": {
      "command": "%LOCALAPPDATA%\\Programs\\sem\\sem.exe",
      "args": ["mcp"]
    },
    "ataraxy-weave": {
      "command": "%USERPROFILE%\\.cargo\\bin\\weave-mcp.exe",
      "args": []
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest"]
    },
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@rustmcp/rust-mcp-filesystem@0.4.5",
        "--allow-write",
        "-d",
        "move_file,unzip_file,zip_files,zip_directory",
        "."
      ]
    }
  }
}
```

На Windows в JSON часто удобнее полные пути без `%VAR%` (Cursor может не раскрывать env) — замени на `C:\\Users\\<YOU>\\…`.

### macOS / Linux (`$HOME`)

```json
{
  "mcpServers": {
    "codebase-memory-mcp": {
      "command": "${HOME}/.local/bin/codebase-memory-mcp",
      "args": []
    },
    "ataraxy-sem": {
      "command": "${HOME}/.local/bin/sem",
      "args": ["mcp"]
    },
    "ataraxy-weave": {
      "command": "${HOME}/.cargo/bin/weave-mcp",
      "args": []
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest"]
    },
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@rustmcp/rust-mcp-filesystem@0.4.5",
        "--allow-write",
        "-d",
        "move_file,unzip_file,zip_files,zip_directory",
        "."
      ]
    }
  }
}
```

`noumen` (Preview + mcp-proxy) настраивается в Fragmenta host — не дублируй здесь без нужды.

Playwright в user `mcp.json` ставь только на машинах, где гоняют QA web e2e.

---

## 5. Опционально

| Инструмент | Зачем | Установка |
|------------|-------|-----------|
| Zerobox 0.3.3 | одна команда shell в skills | `cargo install zerobox --version 0.3.3 --locked` |
| Archify CLI | карты Architect | `npx skills add tt-a1i/archify -g` |
| `gh` + token | GitHub gate / `raci-e2e` | [cli.github.com](https://cli.github.com/) |

Платформенная таблица Zerobox: [`agents/_shared/zerobox-shell.md`](../../agents/_shared/zerobox-shell.md) (ставится sync из `agent-skills/_shared/`).

---

## 6. Проверка после установки

- [ ] `node -v` — LTS
- [ ] `go version` — для orchestrator (если нужен)
- [ ] `git --version`
- [ ] Fragmenta Preview открывает репо consumer
- [ ] ≥1 provider CLI отвечает (`agent` / `hermes` / `claude` — что установлено)
- [ ] MCP: хотя бы один из memory / sem / weave виден в сессии (или зафиксирован gap)
- [ ] `node scripts/sdd-kit-sync.mjs` завершается без ошибки
- [ ] `.cursor/skills/sdd-workflow/SKILL.md` читается после sync
- [ ] `agents/noumen-analyst/SKILL.md` и зеркало `.cursor/skills/noumen-analyst/` совпадают после sync
- [ ] (QA) `npx -y @playwright/mcp@latest` стартует, если нужен web e2e
