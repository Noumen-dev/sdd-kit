---
type: HTTP | event | command | port
operation: {METHOD path | event.name | node.port}
openapi: {ссылка или —}
---

# {имя контракта}

Машиночитаемое «как вызвать». Кладём в `docs/contracts/issue-{N}.md`.
`{N}` — номер GitHub Issue. Ссылка из карточки: поле `contracts` во frontmatter.
Процесс: [SDD_WORKFLOW.md](../SDD_WORKFLOW.md).

## Input

- …

## Output

- …

## Errors

- {code}: …

## Пример

```markdown
---
type: HTTP
operation: GET /api/v1/orders
openapi: ../openapi.yaml#/paths/~1orders
---

# Список заказов (фильтры)

## Input
- status?: enum[new, paid, shipped, cancelled]
- date_from?: date (ISO-8601)
- date_to?: date (ISO-8601)
- page: int = 1
- page_size: int = 20 (max 100)

## Output
- items: Order[]
- total: int
- page: int

## Errors
- 400: невалидный период / enum
- 401: нет сессии
- 422: date_from > date_to
```
