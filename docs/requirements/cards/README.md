# cards/ — карточки требований (стабильный путь)

Путь карточки **не меняется** при смене статуса.

- Файл: `issue-{N}.md` (`{N}` = номер GitHub Issue)
- Статус SoT: frontmatter `status: active | review | accepted | cancelled`
- Индекс (проекция): [`../registry.yaml`](../registry.yaml)
- Вердикт ревью: [`../review/issue-{N}.review.md`](../review/) — отдельный файл, карточку не двигает

Шаблон: [`docs/_templates/card-ac.md`](../../_templates/card-ac.md).
