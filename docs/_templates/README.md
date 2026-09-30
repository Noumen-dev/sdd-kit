# Эталоны артефактов SDD

Поставляются из [Noumen-dev/sdd-kit](https://github.com/Noumen-dev/sdd-kit).

`task_slug` = `issue-{N}` (номер GitHub Issue). Копируем файл в целевую папку и заполняем. Не коммитим заполненные черновики сюда.

| Шаблон | Куда класть |
|--------|-------------|
| [jtbd.md](jtbd.md) | `docs/ideas/issue-{N}.md` |
| [epic.md](epic.md) | `docs/requirements/cards/issue-{E}.md` (`kind: epic`, tier L) |
| [design-c4.md](design-c4.md) | `docs/design/issue-{E}.md` |
| [card-ac.md](card-ac.md) | `docs/requirements/cards/issue-{N}.md` (`status` во frontmatter) |
| [contract.md](contract.md) | `docs/contracts/issue-{N}.md` |
| [adr.md](adr.md) | `docs/adr/{nnn}-issue-{N}.md` |
| [tests-approved.md](tests-approved.md) | `tests/approved/issue-{N}.md` (черновик — `tests/generated/`) |
| [review.md](review.md) | `docs/requirements/review/issue-{N}.review.md` |
| [finding.md](finding.md) | `docs/requirements/review/issue-{N}.findings.md` |

Процесс: [SDD_WORKFLOW.md](../SDD_WORKFLOW.md) · tier L: [sdd-tier-epic-feedback.md](../sdd-tier-epic-feedback.md).
