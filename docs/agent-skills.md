# Скиллы роя и обнаружение инструментами

Переносимый SoT пакетов ролей — каталог **`agent-skills/`** в [sdd-kit](https://github.com/Noumen-dev/sdd-kit).  
После sync / init в consumer:

| Источник в kit | Куда в consumer |
|----------------|-----------------|
| `agent-skills/<id>/` | `agents/<id>/` **и** `.cursor/skills/<id>/` (1:1) |
| `agent-skills/_shared/` | `agents/_shared/` и `.cursor/skills/_shared/` |
| `cursor-skills/sdd-workflow/` | `.cursor/skills/sdd-workflow/` (процесс SDD) |

Формат пакета: [Agent Skills](https://agentskills.io/specification) — каталог kebab-case с `SKILL.md` (`name` = имя каталога).

## Как инструменты находят skills

| Среда | Путь | Примечание |
|-------|------|------------|
| **Cursor** | `.cursor/skills/<id>/SKILL.md` | Подхват при открытии репозитория. Глобальные `%USERPROFILE%\.cursor\skills` / `~/.cursor/skills` этим китом **не** ставятся. |
| **Fragmenta / Noumen extension library** | `agents/<id>/SKILL.md` | Библиотека расширения (ADR consumer: SoT library = `agents/`). Sync держит тексты 1:1 с зеркалом Cursor. |
| **Другие IDE / агенты** | только если поддерживают [Agent Skills](https://agentskills.io/specification) или явно настроенный путь к каталогу skills | **Не универсально.** Нет единого стандарта «положил в репо — любой IDE подхватил». Проверяй документацию конкретного инструмента. |

Процессный skill `sdd-workflow` живёт в `cursor-skills/` кита и ставится только в `.cursor/skills/` (не дублируется в `agents/`).

## Состав portable-ролей

| id | Кто зовёт |
|----|-----------|
| `noumen-analyst` | Карточка `issue-{N}` и AC |
| `noumen-architect` | Design, контракт, ADR, карта Archify |
| `noumen-dev` | Код и `tests/cases` (`draft`) |
| `noumen-qa` | Спек-фест, review, web E2E |
| `noumen-techlead` | Эскалация и merge в protected |
| `archify` | Картинка к design; зовёт Architect |
| `_shared/zerobox-shell.md` | Общая таблица Zerobox (не отдельный skill) |

## Sync

Из consumer с завендоренным китом:

```bash
node scripts/sdd-kit-sync.mjs
```

Или из clone кита: `scripts/sdd-init.sh` / `sdd-sync.sh` (тоже ставят `agent-skills` → `agents/` + `.cursor/skills/`).

Идемпотентно: повторный sync перезаписывает только файлы, которые есть в kit. Посторонние файлы в `agents/` / `.cursor/skills/` (фикстуры `*-live`, product-only пакеты) **не** удаляются.

## Zerobox и Archify

| Тема | Где |
|------|-----|
| Платформенная таблица Zerobox | `agent-skills/_shared/zerobox-shell.md` → после sync `agents/_shared/` |
| Установка Zerobox / Archify / MCP | [`docs/runbooks/dev-machine-setup.md`](runbooks/dev-machine-setup.md) |
| Archify CLI | внешний [tt-a1i/archify](https://github.com/tt-a1i/archify); исходники CLI в kit не копируются |

## Acceptance (портативный контракт)

1. WHEN пакет роли или `archify` лежит в `agents/<id>/` THEN `SKILL.md` SHALL проходить спеку agentskills.io (`name` = имя каталога).
2. WHEN тот же id есть в `.cursor/skills/<id>/` THEN текст `SKILL.md` SHALL совпадать с `agents/<id>/`.
3. WHEN sync выполнен из kit с `agent-skills/` THEN consumer SHALL получить копии в обоих путях (`agents/` и `.cursor/skills/`), включая `_shared`.
4. WHEN IDE не заявляет поддержку Agent Skills / настроенного skills-path THEN документация SHALL NOT утверждать автоматическое обнаружение skills.
