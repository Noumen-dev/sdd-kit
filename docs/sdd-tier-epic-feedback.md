# SDD: tier'ы и обратная связь (кратко)

Дополнение к [SDD_WORKFLOW.md](./SDD_WORKFLOW.md). Шаблоны: [_templates/](_templates/).

## Tier'ы

| Tier | Пример | Артефакты |
|------|--------|-----------|
| **S** | hotfix | `card-ac` |
| **M** | фича, 1–2 PR | card + contract/ADR? + tests + review |
| **L** | эпик | epic → design-c4 → child cards; finding → Architect A/H |

## Обратная связь код → docs

1. Локальное расхождение → правка child-карточки + contract/tests.
2. Граничное → `issue-{N}.findings.md`, Architect A/H; агент **не** переписывает design сам.
3. `tests/approved` менять только вместе со спекой/контрактом.
