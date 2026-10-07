---
# DEPRECATED — используйте tests-case.md
spec_ref: ../../docs/requirements/cards/issue-{N}.md
status: approved
---

# Deprecated: шаблон `tests-approved.md`

**Канон:** [tests-case.md](tests-case.md) → файл `tests/cases/issue-{N}.md`
со frontmatter `status: draft | review | approved | cancelled`.

Раньше утверждённый контракт клали в `tests/approved/` после переноса из `tests/generated/`.
Теперь путь стабилен; SoT утверждения — `status: approved`, не папка.

Процесс: [SDD_WORKFLOW.md](../SDD_WORKFLOW.md).
