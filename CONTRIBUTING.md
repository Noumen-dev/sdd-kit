# Как участвовать в проекте

Организация разработки (основной документ): [docs/SDD_WORKFLOW.md](docs/SDD_WORKFLOW.md).
Эталоны файлов: [docs/_templates/](docs/_templates/).
Агенты (Cursor / Claude): [AGENTS.md](AGENTS.md), скилл `.cursor/skills/sdd-workflow/SKILL.md`.

Сначала требование в Git, потом код. Issue и PR — фасад; карточка, контракт, тесты и review.md — источник истины.

## Что не делаем

- Не вливаем сами в защищённую ветку. Защита — не имя `dev`. Прод — `main`, он приоритетнее `dev`.
- Не открываем Pull Request с базой `dev`. Целевая ветка — **`main`**.
- Не меняем `tests/approved/` без одновременной смены карточки и/или контракта.
- Не переписываем продуктовые спеки «на карточки» задним числом. Новая работа — позадачный SDD.
- Не двигаем карточку `git mv` ради смены статуса — только `status` во frontmatter.

## Поток коротко

1. Issue по шаблону (идея / фича / баг / ADR) — так появляется номер `{N}`. Не придумывать slug.
2. Карточка: `docs/requirements/cards/issue-{N}.md` (`status: active`, User Story + AC WHEN/THEN/SHALL).
3. При необходимости контракт (`docs/contracts/issue-{N}.md`) и ADR, ссылки во frontmatter.
4. Спек-фест: полнота AC (happy path, ошибки, границы).
5. Черновик тестов → `tests/generated/issue-{N}.md`; QA утверждает → `tests/approved/`.
6. Ветка `{type}/issue-{N}`, код, прогон тестов/smoke.
7. В карточке `status: review` (путь тот же).
8. PR/MR **в `main`**, заголовок Conventional Commits, заполненный шаблон.
9. `issue-{N}.review.md` с вердиктом. `approve` → `status: accepted`; иначе `status: active`.
10. Merge в `main` делает **человек** (не авто-merge).

## Slug и ветки

`task_slug` всегда `issue-{N}`, где `{N}` — номер GitHub Issue. Словесные slug не используем.

```text
Issue #1  →  issue-1  →  feat/issue-1  →  docs/requirements/cards/issue-1.md
Issue #3  →  issue-3  →  fix/issue-3
```

Типы веток: `feat`, `fix`, `docs`, `test`, `refactor`, `chore`, `ci`.
База ветки и PR: `main`.

## Коммиты и заголовок PR

[Conventional Commits](https://www.conventionalcommits.org/):

```text
feat(scope): краткое описание
fix(scope): краткое описание
docs: карточка issue-3 status active
```

Допустимые типы: `feat`, `fix`, `docs`, `test`, `refactor`, `chore`, `ci`, `perf`, `revert`.
Описание можно на русском. Workflow `.github/workflows/pr-governance.yml` проверяет **заголовок PR**. Имя базы `dev` само по себе проверку не роняет.

## Чеклист Pull Request

- [ ] База PR — `main`, не `dev`
- [ ] Есть карточка `docs/requirements/cards/issue-{N}.md` (N = номер Issue)
- [ ] AC покрыты кодом и/или тестами
- [ ] `tests/approved/` не менялся **или** менялся вместе со спекой
- [ ] Прогнаны релевантные smoke/unit репозитория
- [ ] Если нужен ADR/контракт — файлы и ссылки в карточке на месте

## Настройки GitHub (админ репо)

1. Default branch = `main`.
2. Branch protection на `main`: required review + required check `pr-governance`.
3. Прямой push в `main` выключен.

## Обновление процесса из кита

```bash
git clone https://github.com/Noumen-dev/sdd-kit.git /tmp/sdd-kit
/tmp/sdd-kit/scripts/sdd-sync.sh .
```
