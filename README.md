# Noumen SDD kit

Переносимый **каркас Spec-Driven Development** для репозиториев Noumen.

Источник истины процесса: этот репозиторий.  
Продуктовые спеки (`raci-agents-7d`, C4 продукта, `src/`) **не** входят в кит.

Версия: см. [`VERSION`](VERSION).

## С чего начать / что иметь

Минимум на машине: **Git**, **Node.js LTS**, при необходимости **Go** (orchestrator в consumer).  
Полный runbook (MCP, `mcp.json`, Win/macOS/Linux): [`docs/runbooks/dev-machine-setup.md`](docs/runbooks/dev-machine-setup.md).

| Нужно | Зачем |
|-------|-------|
| **Git** + **Node.js LTS** | clone / sync |
| **Go** (если в consumer есть orchestrator) | сборка и тесты движка |
| **Docker** (опционально) | локальный Postgres в consumer |
| **Fragmenta Preview** и/или Cursor | UI и подхват skills |
| **≥1 provider CLI** | Cursor / Hermes / Claude |

В consumer с завендоренным китом:

```bash
node scripts/sdd-kit-sync.mjs
```

После sync: процессный skill в `.cursor/skills/sdd-workflow/`, portable roles (`noumen-*`, `archify`, `_shared`) — в `agents/<id>/` **и** `.cursor/skills/<id>/` (1:1).

## Что внутри

| В kit | Куда попадает в consumer |
|-------|--------------------------|
| `AGENTS.md`, `CONTRIBUTING.md` | корень |
| `docs/**` | `docs/**` |
| `tests/**` | `tests/**` |
| `cursor-skills/sdd-workflow/` | `.cursor/skills/sdd-workflow/` |
| `agent-skills/<id>/` | `agents/<id>/` **и** `.cursor/skills/<id>/` |
| `agent-skills/_shared/` | `agents/_shared/` и `.cursor/skills/_shared/` |
| `github/**` | `.github/**` |
| `scripts/sdd-init.sh`, `sdd-sync.sh` | остаются в kit (вызываются отсюда) |

Обнаружение skills: [`docs/agent-skills.md`](docs/agent-skills.md).  
Установка машины: [`docs/runbooks/dev-machine-setup.md`](docs/runbooks/dev-machine-setup.md).

## Подтянуть в репозиторий

```bash
git clone https://github.com/Noumen-dev/sdd-kit.git /tmp/sdd-kit
/tmp/sdd-kit/scripts/sdd-init.sh /path/to/your-repo   # не затирает существующие файлы
/tmp/sdd-kit/scripts/sdd-sync.sh /path/to/your-repo   # обновить = init --force
```

Либо из vendor-копии внутри consumer (если кит завендорен):

```bash
# предпочтительно в consumer Noumen-dev/agents:
node scripts/sdd-kit-sync.mjs

# или напрямую из kit:
./vendor/sdd-kit/scripts/sdd-sync.sh .
```

`sdd-init` **не** перезаписывает уже существующие файлы без `--force`.  
`sdd-sync` = force-copy файлов, которые есть в kit (шаблоны, process skill, **portable role skills**, workflow, пустые README деревьев). Заполненные `cards/issue-*.md` кит не содержит — их sync не трогает. Посторонние пакеты в `agents/` / `.cursor/skills/` не удаляются.

## После init

1. Default branch = `main`.
2. Branch protection: required check `pr-governance`.
3. Новая работа: Issue → `cards/issue-{N}.md` → ветка `{type}/issue-{N}` → PR в `main`.

Подробности: [docs/SDD_WORKFLOW.md](docs/SDD_WORKFLOW.md).
