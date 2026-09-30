# Карточки требований

| Путь | Назначение |
|------|------------|
| [cards/](cards/) | Карточки `issue-{N}.md` — **стабильный путь** |
| [registry.yaml](registry.yaml) | Индекс (проекция); SoT статуса — frontmatter |
| [review/](review/) | Только `issue-{N}.review.md` и findings |

Статус карточки — поле `status` во frontmatter: `active` → `review` → `accepted` | `cancelled`.  
**Не** переносим файлы между папками ради статуса (без `git mv`).

Устаревшие папки `active/`, `accepted/`, `cancelled/` — только указатели; новые карточки не класть туда.

Шаблон: [docs/_templates/card-ac.md](../_templates/card-ac.md).
