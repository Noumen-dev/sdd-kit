---
name: sdd-workflow
description: >-
  Enforces spec-driven development (SDD) in this Noumen agents extension repo:
  GitHub issue-N slugs, requirement cards with WHEN/THEN/SHALL AC, Git Flow
  without the dev branch, Conventional Commits, Russian docs. Use when
  implementing features, fixing bugs, writing documentation, opening a PR,
  creating a карточка, JTBD, ADR, контракт, review.md, or when the user
  mentions SDD, issue-1, issue-3, CONTRIBUTING, ветки, or docs/requirements.
---

# SDD workflow

Проектные правила (кратко): [AGENTS.md](../../../AGENTS.md).
Полная спека: [docs/SDD_WORKFLOW.md](../../../docs/SDD_WORKFLOW.md).
Шаблоны копировать из [docs/_templates/](../../../docs/_templates/).

Не дублируй продуктовые спеки (`raci-agents-7d.md` и др.) в карточки. Новая работа — только позадачный SDD.

## Slug = номер GitHub Issue

`task_slug` = `issue-{N}`. Не выдумывать `mt5-gap-finder`.

1. Создать GitHub Issue (появится номер, например 3).
2. Карточка `docs/requirements/cards/issue-3.md` (`status: active`), ветка `feat/issue-3`.

```text
Issue #1  →  issue-1  →  feat/issue-1
Issue #3  →  issue-3  →  fix/issue-3
```

## Перед кодом

1. Есть ли карточка `docs/requirements/cards/issue-{N}.md` с User Story и AC?
   - Нет → создать из `docs/_templates/card-ac.md`. Не начинать код.
   - Баг без карточки → завести Issue, затем карточку `issue-{N}` с AC на фикс.
2. AC полные? Happy path, ошибки, границы. Формат: `WHEN … THEN система SHALL …`.
3. Нужен контракт порта/API? `docs/contracts/issue-{N}.md` + ссылка во frontmatter `contracts`.
4. Спорное архитектурное решение? `docs/adr/{nnn}-issue-{N}.md` + `adr` во frontmatter. ADR утверждает человек.
5. Большая задача (tier L): epic + design-c4 → child cards. Обратная связь: finding → Architect. См. [sdd-tier-epic-feedback.md](../../../docs/sdd-tier-epic-feedback.md).

## Ветка и коммиты

```text
git checkout -b feat/issue-3   # от main: это прод, приоритетнее dev
```

Типы: `feat` | `fix` | `docs` | `test` | `refactor` | `chore` | `ci`.

Коммит и заголовок PR:

```text
feat(factory): Gap Finder заполняет пропуски баров
fix(orchestrator): healthz отдаёт service tag
docs: карточка issue-3 status active
```

Запрещено: авто-merge и прямой push в защищённую ветку (здесь прод — `main`, он приоритетнее `dev`; имя `dev` само по себе не запрет); commit без явной просьбы пользователя.

## После кода

1. Прогнать релевантный smoke/unit ([docs/07_acceptance.md](../../../docs/07_acceptance.md)).
2. Тест-кейс — `tests/cases/issue-{N}.md` (`status: draft`). Смена на `status: approved` — только вместе со спекой (без `git mv`).
3. В карточке выставить `status: review` (путь `cards/` не менять); при желании обновить `registry.yaml`.
4. PR **в `main`**, шаблон `.github/pull_request_template.md`, в теле ссылка на Issue #{N}.
5. Ревьюер пишет `docs/requirements/review/issue-{N}.review.md` (`approve` | `changes_requested` | `blocked`).
6. `approve` → в карточке `status: accepted`. `changes_requested` → `status: active`. Без `git mv`.

## Стиль

- Ответ пользователю, комментарии, markdown — русский.
- Python: Google docstring.
- Код хорошо аннотировать, без шума и без «умных» переименований вне задачи.

## Источник

Скилл поставляется из [Noumen-dev/sdd-kit](https://github.com/Noumen-dev/sdd-kit).
Установка машины (MCP/deps): [docs/runbooks/dev-machine-setup.md](../../../docs/runbooks/dev-machine-setup.md).
Обнаружение skills: [docs/agent-skills.md](../../../docs/agent-skills.md).

### Как подтянуть sdd-kit

Источник: https://github.com/Noumen-dev/sdd-kit → `vendor/sdd-kit/`.
Работает на **Windows, macOS и Linux** (нужны `git` и `node` в PATH). Из корня репо:

```bash
# 1) обновить vendor (если есть доступ к remote kit)
git -C vendor/sdd-kit pull --ff-only

# 2) разложить процесс + portable roles в это репо
node scripts/sdd-kit-sync.mjs
```

Альтернатива на macOS / Linux / WSL / Git Bash: `./scripts/sdd-kit-sync.sh` (вызывает тот же mjs).

| ОС | Как запускать |
|----|----------------|
| Windows (PowerShell / cmd) | `node scripts\sdd-kit-sync.mjs` |
| Windows + Git Bash / WSL | `node scripts/sdd-kit-sync.mjs` или `./scripts/sdd-kit-sync.sh` |
| macOS / Linux | `node scripts/sdd-kit-sync.mjs` или `./scripts/sdd-kit-sync.sh` |

После sync читай этот файл заново. Sync ставит `sdd-workflow` и **portable roles** из `vendor/sdd-kit/agent-skills/` в `agents/<id>/` и `.cursor/skills/<id>/`. Посторонние пакеты (например `*-live`) не удаляются. Product overlays из skip-списка не затираются. Версия: `.sdd-kit/VERSION`.

Из clone чистого кита: `scripts/sdd-sync.sh` / `sdd-init.sh`.
