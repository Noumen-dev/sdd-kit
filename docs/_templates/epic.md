---
kind: epic
task_slug: issue-{E}
title: {заголовок эпика}
github_issue: {E}
tier: L
status: active
design_ref: ../design/issue-{E}.md
children: []
---

# issue-{E} — {заголовок эпика} (Epic)

`tier: L`. Декомпозиция на child issues (`issue-{C}`) с `parent: issue-{E}`.
Путь: `docs/requirements/cards/issue-{E}.md`. Статус — frontmatter `status` (не `git mv`).
Design pack: [design-c4.md](./design-c4.md) → `docs/design/issue-{E}.md`.
Процесс: [sdd-tier-epic-feedback.md](../sdd-tier-epic-feedback.md).

**User Story:** Как …, я хочу …, чтобы …

## Out of scope

- …

## Критерии «эпик done»

1. WHEN design pack `approved` THEN Architect SHALL …
2. WHEN все child issues имеют `status: accepted` THEN …
3. WHEN integration smoke пройден THEN …

## Children (чеклист декомпозиции)

- [ ] issue-{C1} — …
- [ ] issue-{C2} — …

## Changelog design

| Rev | Дата | Что изменилось | Issue / finding |
|-----|------|----------------|-----------------|
| 1 | … | draft | — |
