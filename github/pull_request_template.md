## Карточка

- Issue: #
- `task_slug`: `issue-{N}` (N = номер Issue выше)
- Путь: `docs/requirements/cards/issue-{N}.md` (`status` во frontmatter)
- Ветка: `{type}/issue-{N}`

## Соответствие AC

| AC | Как проверено |
| -- | ------------- |
| 1  |               |
| 2  |               |

## Чеклист

- [ ] База PR — **`main`** (прод, приоритетнее `dev`). Вливание в защищённую ветку делает человек
- [ ] Заголовок PR — Conventional Commits (`feat:`, `fix:`, `docs:`, …)
- [ ] Карточка `issue-{N}.md` в Git, AC в формате WHEN/THEN/SHALL
- [ ] `tests/approved/` не менялся **или** менялся вместе со спекой/контрактом
- [ ] Прогнаны релевантные тесты / smoke репозитория
- [ ] Контракт и ADR приложены, если решение касается API/портов/архитектуры
- [ ] Merge в `main` сделает человек (не авто-merge)

Процесс: [CONTRIBUTING.md](CONTRIBUTING.md) · [docs/SDD_WORKFLOW.md](docs/SDD_WORKFLOW.md)
