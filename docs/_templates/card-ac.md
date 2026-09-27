---
task_slug: issue-{N}
title: {заголовок}
tier: S | M | L-child
stack: frontend | backend | extension | factory | orchestrator
github_issue: {N}
status: active
parent:
design_ref:
contracts: []
adr: []
---

# issue-{N} — {заголовок}

`{N}` — номер GitHub Issue (Issue #3 → `issue-3`). Не выдумывать словесный slug.
`tier`: **S** — только эта карточка; **M** — фича; **L-child** — часть эпика (`parent: issue-{E}`, `design_ref`).
Карточка: `docs/requirements/cards/issue-{N}.md`. Статус — поле `status` (`active` | `review` | `accepted` | `cancelled`), путь не меняем.
Процесс: [SDD_WORKFLOW.md](../SDD_WORKFLOW.md) · tier L + feedback: [sdd-tier-epic-feedback.md](../sdd-tier-epic-feedback.md).

**User Story:** Как …, я хочу …, чтобы …

#### Acceptance Criteria

1. WHEN … THEN система SHALL …
2. WHEN … THEN система SHALL …
3. IF … THEN система SHALL …

## Пример

```markdown
---
task_slug: issue-3
title: Фильтры списка заказов
stack: frontend
github_issue: 3
status: active
contracts: [../../contracts/issue-3.md]
adr: []
---

# issue-3 — Фильтры списка заказов

**User Story:** Как менеджер, я хочу фильтровать заказы по статусу и периоду, чтобы быстрее находить нужные.

#### Acceptance Criteria

1. WHEN выбран статус THEN список SHALL показать только заказы с этим статусом
2. WHEN задан период дат THEN список SHALL ограничить заказы датой создания в периоде
3. WHEN фильтры сброшены THEN список SHALL вернуться к состоянию по умолчанию
4. WHEN URL шарится THEN фильтры SHALL восстановиться из query-параметров
```
