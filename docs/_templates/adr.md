# ADR-{nnn}: {решение}

Архитектурное решение. Кладём в `docs/adr/{nnn}-issue-{N}.md`.
`{N}` — номер связанного GitHub Issue. Ссылка из карточки: поле `adr` во frontmatter.
Процесс: [SDD_WORKFLOW.md](../SDD_WORKFLOW.md).

## Context

…

## Decision

…

## Alternatives

- …

## Consequences

- + …
- − …

## Bounds

…

## Links

- карточка: …
- контракт: …

## Пример

```markdown
# ADR-017: Фильтры заказов в URL query

## Context
Нужно шарить отфильтрованный список и переживать F5 без потери состояния.

## Decision
Хранить фильтры только в query (`status`, `from`, `to`). Локальный state — зеркало URL.

## Alternatives
- sessionStorage — не шарится ссылкой
- отдельный «сохранённый вид» на бэке — избыточно для MVP

## Consequences
- + шаринг и deep-link из коробки
- − длинные URL; нужна валидация enum/дат на входе

## Bounds
Только список заказов ЛК. Другие гриды — отдельные ADR.

## Links
- карточка: requirements/cards/issue-3.md
- контракт: contracts/issue-3.md
```
