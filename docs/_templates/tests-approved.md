---
spec_ref: ../../docs/requirements/…/issue-{N}.md
status: approved
---

# issue-{N} — тест-кейсы

Замороженный контракт тестов. Кладём в `tests/approved/issue-{N}.md`.
Менять **только** вместе со сменой спеки (карточка / контракт).
Черновик до утверждения QA — `tests/generated/issue-{N}.md`.
Процесс: [SDD_WORKFLOW.md](../SDD_WORKFLOW.md).

## Happy path

- …

## Errors / bounds

- …

## Примечание

Менять только вместе со сменой спеки (карточка / контракт).

## Пример

```markdown
---
spec_ref: ../../docs/requirements/cards/issue-3.md
status: approved
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
Менять только вместе со сменой спеки (карточка / контракт).
```
