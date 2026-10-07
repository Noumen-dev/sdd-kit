# Инструкции для агента

Этот репозиторий ведётся **spec-driven (SDD)**. Сначала карточка в Git, потом код.
Люди: [CONTRIBUTING.md](CONTRIBUTING.md). Организация разработки: [docs/SDD_WORKFLOW.md](docs/SDD_WORKFLOW.md).
Эталоны: [docs/_templates/](docs/_templates/). Операционный скилл: `.cursor/skills/sdd-workflow/SKILL.md`.

Отвечай пользователю **по-русски**. Комментарии в коде и документация — **на русском**. Python: **Google docstring**.

## Жёсткие запреты

- Не вливать в защищённую ветку. Защита — не имя `dev`. Прод здесь — `main`, она приоритетнее `dev`. PR в `main`. Вливает человек.
- Не коммитить и не пушить, пока пользователь явно не попросил.
- Не менять тест-кейс со `status: approved` без одновременной смены карточки и/или контракта.
- Не переписывать продуктовые спеки на карточки задним числом.
- Не merge в `main` автоматически (A/H: человек).
- Не писать код фичи без карточки с AC (исключение: явно запрошенный точечный фикс с AC в том же PR).
- Не менять статус карточки через `git mv` между папками — только `status` во frontmatter.

## Два слоя docs

| Слой | Где | Правило |
|------|-----|---------|
| Продуктовые спеки | собственные docs продукта (не из кита) | Читать как контур продукта, не резать |
| Позадачный SDD | `docs/ideas`, `docs/requirements/cards`, `docs/contracts`, `docs/adr`, `tests/*` | Новая работа только так |

## Карта артефактов

| Что | Куда | Шаблон |
|-----|------|--------|
| JTBD | `docs/ideas/issue-{N}.md` | `docs/_templates/jtbd.md` |
| Epic (tier L) | `docs/requirements/cards/issue-{E}.md` (`kind: epic`) | `docs/_templates/epic.md` |
| Design / C4 | `docs/design/issue-{E}.md` | `docs/_templates/design-c4.md` |
| Карточка + AC | `docs/requirements/cards/issue-{N}.md` | `docs/_templates/card-ac.md` |
| Реестр (проекция) | `docs/requirements/registry.yaml` | — |
| Контракт | `docs/contracts/issue-{N}.md` | `docs/_templates/contract.md` |
| ADR | `docs/adr/{nnn}-issue-{N}.md` | `docs/_templates/adr.md` |
| Тест-кейс | `tests/cases/issue-{N}.md` | `docs/_templates/tests-case.md` (`status: draft\|review\|approved\|cancelled`) |
| Ревью | `docs/requirements/review/issue-{N}.review.md` | `docs/_templates/review.md` |
| Finding | `docs/requirements/review/issue-{N}.findings.md` | `docs/_templates/finding.md` |

Статус карточки — **frontmatter** `status: active | review | accepted | cancelled`. Путь `cards/issue-{N}.md` стабилен. Опционально обновить `registry.yaml`.
Статус тест-кейса — **frontmatter** `status: draft | review | approved | cancelled`. Путь `tests/cases/issue-{N}.md` стабилен (без `git mv`).

AC писать так: `WHEN … THEN система SHALL …` или `IF … THEN система SHALL …`.

## Git и slug

`task_slug` = `issue-{N}`, где `{N}` — номер **GitHub Issue** (не выдумывать словесные slug).

Порядок: сначала Issue (появится номер) → карточка `cards/issue-3.md` → ветка `feat/issue-3`.

PR только в `main`. Заголовок PR: Conventional Commits (`feat:`, `fix:`, `docs:`, …), описание можно по-русски.

## Большие задачи (tier L)

1. Epic + design pack (C4): шаблоны [epic.md](docs/_templates/epic.md), [design-c4.md](docs/_templates/design-c4.md) → [sdd-tier-epic-feedback.md](docs/sdd-tier-epic-feedback.md).
2. Декомпозиция на child issues (`parent`, `design_ref` в card-ac).
3. Обратная связь из кода — [finding.md](docs/_templates/finding.md), гейт Architect A/H; агент **не** правит design сам.

Мелкие задачи: tier S/M — карточка + AC как раньше.

## Откуда этот файл

Процессный каркас поставлен из [Noumen-dev/sdd-kit](https://github.com/Noumen-dev/sdd-kit).  
Продуктовый стек и ссылки на доменные спеки добавляйте **ниже** этого блока или в отдельном разделе consumer-репо — `sdd-sync` перезапишет только файлы из кита.
