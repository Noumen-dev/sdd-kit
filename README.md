# sdd-kit — переиспользуемый SDD Noumen

SoT процесса Spec-Driven Development для репозиториев Noumen/Fragmenta.  
**Не** содержит продукт (`src/`, оркестратор, `raci-agents-7d.md`).

Источник процесса: выжимка из репо [`Noumen-dev/agents`](https://github.com/Noumen-dev/agents).

## Что внутри

| Путь | Назначение |
|------|------------|
| `docs/_templates/` | Эталоны JTBD, card-ac, contract, ADR, review, … |
| `docs/{ideas,requirements,contracts,adr,design}/` | Пустые деревья + README |
| `tests/{generated,approved}/` | Черновики и утверждённые тесты |
| `AGENTS.md` | Правила для агентов |
| `CONTRIBUTING.md` | Правила для людей |
| `docs/SDD_WORKFLOW.md` | Полный процесс |
| `cursor-skills/sdd-workflow/` | Skill (agentskills.io) → копировать в `.cursor/skills/` |
| `github/` | Issue/PR templates + лёгкий `pr-governance` → копировать в `.github/` |
| `scripts/sdd-init.sh` / `sdd-sync.sh` | Установка / обновление в consumer-репо |

## Установка в другой репо

Из корня **consumer**-репозитория:

```bash
# клон kit рядом или как submodule
git clone https://github.com/Noumen-dev/sdd-kit.git /tmp/sdd-kit
/tmp/sdd-kit/scripts/sdd-init.sh .
```

`sdd-init.sh` копирует шаблоны, skill, GitHub templates и заготовки docs/tests (не затирает существующие файлы без `--force`).

Обновление managed-файлов из новой версии kit:

```bash
/tmp/sdd-kit/scripts/sdd-sync.sh .
```

## Правила (кратко)

- `task_slug` = `issue-{N}` (номер GitHub Issue)
- Сначала карточка с AC (`WHEN … THEN система SHALL …`), потом код
- Ветка `{type}/issue-{N}`; Conventional Commits
- Статус карточки — frontmatter `status`, не `git mv`
- Merge в protected — человек (A/H)

## Layout после init в consumer

```text
.
├── AGENTS.md
├── CONTRIBUTING.md
├── .cursor/skills/sdd-workflow/SKILL.md
├── .github/ISSUE_TEMPLATE/ …
├── docs/_templates/ …
└── tests/ …
```
