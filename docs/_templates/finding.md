---
kind: finding
parent_issue: issue-{C}
affects: []
verdict: pending
decided_by: []
---

# Finding · issue-{C}

Сигнал **от реализации к документам** (L2/L3). Кладём рядом с review или в `review/`.
Агент **не** правит epic/design сам — только этот файл + ESCALATE к Architect.
Процесс: [sdd-tier-epic-feedback.md](../sdd-tier-epic-feedback.md).

## Observed

Что увидели в коде / тестах / интеграции:

- …

## Breaks

- AC-{N} / contract … / design §…

## Proposed change

| Уровень | Что менять |
|---------|------------|
| local | child card / contract |
| parent | `docs/design/issue-{E}.md` rev N+1 |
| decision | ADR supersede |

## Impact on siblings

- issue-{X}: …

## Verdict

`pending` | `accept_local` | `revise_parent` | `new_child` | `wontfix`

**Решение (Architect / Product):** …

## Пример

```markdown
## Observed
CLI-адаптер не создаёт агента — только загружает Agent Plugin.

## Breaks
plans/02 §«Create ≠ invoke» ещё не в design issue-1.

## Proposed change
parent: design issue-1 rev 2 — добавить трёхслойную модель.

## Verdict
revise_parent — Architect A/H 2026-08-25
```
