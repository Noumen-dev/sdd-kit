---
name: archify
description: >-
  Карта системы через Archify (skill+CLI, не MCP): typed JSON → validate/deliver
  → HTML рядом с design. Use when нужна architecture, workflow, sequence,
  dataflow или lifecycle диаграмма, вызов /archify, или Architect дополняет
  docs/design/issue-{E}.md картинкой.
license: MIT
compatibility: >-
  Agent Skills (agentskills.io). Upstream: npx skills add tt-a1i/archify -g
  (tt-a1i/archify, MIT). Исходники в sdd-kit не копировать. Не MCP.
metadata:
  author: noumen
  purpose: system-map
  upstream: https://github.com/tt-a1i/archify
  version: "1.0"
---

# archify

Ты строишь **проверяемую картинку** к design-документу. Источник правды — markdown с Mermaid. JSON и HTML Archify — производный вид рядом с ним.

Upstream: [tt-a1i/archify](https://github.com/tt-a1i/archify). В `sdd-kit` дерево Archify не класть. Это не MCP. Процесс SDD (slug, карточки, ветки) — из kit / `sdd-workflow`; здесь не дублировать.
## Куда писать

Для эпика `{E}`:

| Артефакт | Путь |
|----------|------|
| SoT | `docs/design/issue-{E}.md` (C4 + Mermaid) |
| IR | `docs/design/issue-{E}.archify.json` |
| HTML | `docs/design/issue-{E}.archify.html` |

Несколько типов у одного эпика: `docs/design/issue-{E}.{type}.archify.json` и такой же `.html`. `{type}` — одно из `architecture`, `workflow`, `sequence`, `dataflow`, `lifecycle`.

## Какой тип в какую секцию SoT

| Тип Archify | Секция `docs/design/issue-{E}.md` |
|-------------|-----------------------------------|
| architecture | Context и Container |
| sequence | Sequence |
| workflow | Поток процесса в том же design |
| lifecycle | State machine, если она есть в design |
| dataflow | Только sidecar; в SoT вторую карту данных не заводить |

Mermaid в design пишется первым. JSON Archify — новый текст по этой схеме, не копия Mermaid внутрь IR.

## Вызов

Установка на машине пользователя (один раз, глобально):

```bash
npx skills add tt-a1i/archify -g
```

Из каталога установленного skill:

```bash
node bin/archify.mjs validate <type> <candidate.json> --quality showcase --json
node bin/archify.mjs deliver <type> <candidate.json> <output.html> --quality showcase --json
```

Ненулевой код — это провал. При падении `deliver` последний удачный HTML не затирать. Если CLI нет на машине, оставить SoT markdown и прямо написать, что HTML не собран.

## Границы

- Владелец вызова в рое — **Architect** (`/noumen-architect`). Остальные роли читают HTML.
- Карту не класть в library `agents/` как SoT диаграммы.
- Не выдумывать узлы, которых нет в design или в рабочем репо.
- Ответ по-русски. Пути — относительно корня рабочего репо.
