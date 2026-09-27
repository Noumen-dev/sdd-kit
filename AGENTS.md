# Инструкции для агента (sdd-kit)

Репозиторий / consumer ведётся **spec-driven (SDD)**. Сначала карточка в Git, потом код.

Люди: [CONTRIBUTING.md](CONTRIBUTING.md). Процесс: [docs/SDD_WORKFLOW.md](docs/SDD_WORKFLOW.md).  
Эталоны: [docs/_templates/](docs/_templates/). Skill: `.cursor/skills/sdd-workflow/SKILL.md`.

Отвечай **по-русски**. Комментарии и docs — **на русском**. Python: **Google docstring**.

## Жёсткие запреты

- Не коммитить и не пушить, пока пользователь явно не попросил.
- Не менять `tests/approved/` без одновременной смены карточки и/или контракта.
- Не переписывать продуктовые спеки репо на карточки задним числом.
- Не merge в protected автоматически (A/H: человек).
- Не писать код фичи без карточки с AC (исключение: точечный фикс с AC в том же PR).
- Не менять статус карточки через `git mv` — только `status` во frontmatter.
- Целевая ветка PR по умолчанию — `main`. Draft PR в `dev` — только если Project/владелец явно разрешил; **merge** в `dev`/`main` агенту запрещён.

## Два слоя docs

| Слой | Где | Правило |
|------|-----|---------|
| Продуктовые спеки | `docs/` продукта (архитектура, RACI, …) | Читать как контур, не резать на карточки задним числом |
| Позадачный SDD | `docs/ideas`, `docs/requirements/cards`, `docs/contracts`, `docs/adr`, `tests/*` | Новая работа только так |

## Карта артефактов

| Что | Куда | Шаблон |
|-----|------|--------|
| JTBD | `docs/ideas/issue-{N}.md` | `docs/_templates/jtbd.md` |
| Epic (tier L) | `docs/requirements/cards/issue-{E}.md` (`kind: epic`) | `docs/_templates/epic.md` |
| Design / C4 | `docs/design/issue-{E}.md` | `docs/_templates/design-c4.md` |
| Карточка + AC | `docs/requirements/cards/issue-{N}.md` | `docs/_templates/card-ac.md` |
| Реестр | `docs/requirements/registry.yaml` | — |
| Контракт | `docs/contracts/issue-{N}.md` | `docs/_templates/contract.md` |
| ADR | `docs/adr/{nnn}-issue-{N}.md` | `docs/_templates/adr.md` |
| Тесты-черновик | `tests/generated/issue-{N}.md` | → approved |
| Тесты-контракт | `tests/approved/issue-{N}.md` | `docs/_templates/tests-approved.md` |
| Ревью | `docs/requirements/review/issue-{N}.review.md` | `docs/_templates/review.md` |
| Finding | `docs/requirements/review/issue-{N}.findings.md` | `docs/_templates/finding.md` |

Статус: `active` \| `review` \| `accepted` \| `cancelled`.

AC: `WHEN … THEN система SHALL …` или `IF … THEN система SHALL …`.

## Git и slug

`task_slug` = `issue-{N}` (номер **GitHub Issue**). Не выдумывать словесный slug.

Issue → карточка `cards/issue-{N}.md` → ветка `{type}/issue-{N}` → PR (обычно в `main`).
