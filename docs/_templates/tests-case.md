---
spec_ref: ../../docs/requirements/cards/issue-{N}.md
status: draft
---

# issue-{N} — тест-кейсы

Стабильный путь: `tests/cases/issue-{N}.md` (без `git mv` при смене статуса).
Статус — frontmatter: `draft` | `review` | `approved` | `cancelled`.
`status: approved` — замороженный контракт; менять **только** вместе со сменой спеки (карточка / контракт).
Процесс: [SDD_WORKFLOW.md](../SDD_WORKFLOW.md).

## Happy path

- …

## Errors / bounds

- …

## Примечание

При `status: approved` менять только вместе со сменой спеки (карточка / контракт).

## Пример

```markdown
---
spec_ref: ../../docs/requirements/cards/issue-3.md
status: draft
---

# issue-3 — GET /orders фильтры

## Happy path
- status=paid → только paid; total согласован с items
- from+to в периоде → границы включительно
- без фильтров → page=1, page_size=20

## Errors / bounds
- date_from > date_to → 422
- status=unknown → 400
- page_size=101 → 400

## Примечание
При status: approved менять только вместе со сменой спеки.
```
