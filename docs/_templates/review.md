---
verdict: approve | changes_requested | blocked
mr_iid: {n}
---

# Review · issue-{N}

Отчёт ревью. Кладём в `docs/requirements/review/issue-{N}.review.md`
(карточка в той же папке: `issue-{N}.md`).
`{N}` — номер GitHub Issue.
Вердикты: `approve` | `changes_requested` | `blocked`.
Процесс: [SDD_WORKFLOW.md](../SDD_WORKFLOW.md).

## Соответствие AC

| AC | Статус | Замечание |
| -- | ------ | --------- |
| 1  | pass / fail / n/a | … |

## Замечания

- …

## Пример

```markdown
---
verdict: changes_requested
mr_iid: 966
---

# Review · issue-3

## Соответствие AC

| AC | Статус | Замечание |
| -- | ------ | --------- |
| 1  | pass   | статус-фильтр ок |
| 2  | pass   | период ок |
| 3  | pass   | сброс ок |
| 4  | fail   | query не пишется при смене статуса |

## Замечания
- Синхронизировать `status` с URL до push history
- Добавить e2e на deep-link
```
