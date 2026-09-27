---
name: sdd-workflow
description: >-
  Enforces spec-driven development (SDD): GitHub issue-N slugs, requirement
  cards with WHEN/THEN/SHALL AC, Conventional Commits, Russian docs. Use when
  implementing features, fixing bugs, writing documentation, opening a PR,
  creating a карточка, JTBD, ADR, контракт, review.md, or when the user
  mentions SDD, issue-N, CONTRIBUTING, ветки, or docs/requirements.
---

# SDD workflow

Кратко: [AGENTS.md](../../../AGENTS.md).  
Полная спека: [docs/SDD_WORKFLOW.md](../../../docs/SDD_WORKFLOW.md).  
Шаблоны: [docs/_templates/](../../../docs/_templates/).

Не дублируй продуктовые спеки в карточки. Новая работа — только позадачный SDD.

## Slug = номер GitHub Issue

`task_slug` = `issue-{N}`. Не выдумывать словесный slug.

1. Создать GitHub Issue → номер `{N}`.
2. Карточка `docs/requirements/cards/issue-{N}.md` (`status: active`), ветка `{type}/issue-{N}`.

## Перед кодом

1. Есть карточка с User Story и AC? Иначе — из `docs/_templates/card-ac.md`.
2. AC: `WHEN … THEN система SHALL …` (happy path, ошибки, границы).
3. Контракт / ADR по необходимости; ссылки во frontmatter.
4. Tier L: epic + design-c4 → child cards; finding → Architect.

## Ветка и коммиты

```text
git checkout -b feat/issue-3
```

Типы: `feat` | `fix` | `docs` | `test` | `refactor` | `chore` | `ci`.  
Заголовок PR — Conventional Commits. Merge — человек.

## После кода

1. Smoke/unit.
2. `tests/generated/issue-{N}.md`; `tests/approved/` — только со спекой.
3. `status: review`; PR; `review/issue-{N}.review.md`.
4. `approve` → `status: accepted`. Без `git mv`.

## Стиль

- Ответ, комментарии, markdown — русский.
- Python: Google docstring.
