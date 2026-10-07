# Тест-кейсы (канон)

Стабильный путь: `tests/cases/issue-{N}.md`.

Статус — **только** frontmatter (как у карточек):

| `status` | Смысл |
|----------|--------|
| `draft` | черновик Dev / генератор |
| `review` | на тест-фесте / сверке с AC |
| `approved` | замороженный контракт |
| `cancelled` | снято |

Путь файла **не** меняется при смене статуса. Без обязательного `git mv`.

Шаблон: [docs/_templates/tests-case.md](../../docs/_templates/tests-case.md).

Папки `tests/generated/` и `tests/approved/` — **deprecated** (см. их README). SoT — этот каталог.
Опциональная publish-проекция `status: approved` → `tests/approved/` — один релиз совместимости: `scripts/publish-approved-projection.sh`.
