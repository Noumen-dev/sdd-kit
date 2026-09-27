# Как участвовать (SDD)

Процесс: [docs/SDD_WORKFLOW.md](docs/SDD_WORKFLOW.md).  
Эталоны: [docs/_templates/](docs/_templates/).  
Агенты: [AGENTS.md](AGENTS.md), skill `.cursor/skills/sdd-workflow/SKILL.md`.

Сначала требование в Git, потом код. Issue/PR — фасад; карточка, контракт, тесты и review.md — SoT.

## Что не делаем

- Не коммитим напрямую в protected без review.
- Не меняем `tests/approved/` без смены карточки/контракта.
- Не режем продуктовые спеки на карточки задним числом.
- Не двигаем карточку `git mv` ради статуса — только `status` во frontmatter.
- Merge в protected — **человек** (не авто-merge).

## Поток коротко

1. Issue по шаблону → номер `{N}`.
2. Карточка `docs/requirements/cards/issue-{N}.md` (`status: active`, User Story + AC WHEN/THEN/SHALL).
3. При необходимости контракт и ADR (ссылки во frontmatter).
4. Спек-фест QA.
5. Черновик тестов → `tests/generated/`; QA → `tests/approved/`.
6. Ветка `{type}/issue-{N}`, код, прогон.
7. `status: review`.
8. PR (обычно в `main`), Conventional Commits.
9. `issue-{N}.review.md` → `approve` ⇒ `status: accepted`.
10. Merge — человек.

## Slug и ветки

```text
Issue #3  →  issue-3  →  feat/issue-3  →  docs/requirements/cards/issue-3.md
```

Типы: `feat`, `fix`, `docs`, `test`, `refactor`, `chore`, `ci`.

## Коммиты / заголовок PR

[Conventional Commits](https://www.conventionalcommits.org/): `feat:`, `fix:`, `docs:`, …

## Чеклист PR

- [ ] База — `main` (или явно согласованный `dev` только как draft, без merge агентом)
- [ ] Карточка `issue-{N}.md` в Git
- [ ] AC WHEN/THEN/SHALL
- [ ] `tests/approved/` не трогали без спеки
- [ ] Merge сделает человек
