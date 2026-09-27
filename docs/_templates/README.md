# Эталоны артефактов SDD

`task_slug` = `issue-{N}` (номер GitHub Issue). Копируем файл в целевую папку и заполняем.

| Шаблон | Куда класть |
|--------|-------------|
| [jtbd.md](jtbd.md) | `docs/ideas/issue-{N}.md` |
| [epic.md](epic.md) | `docs/requirements/cards/issue-{E}.md` (`kind: epic`) |
| [design-c4.md](design-c4.md) | `docs/design/issue-{E}.md` |
| [card-ac.md](card-ac.md) | `docs/requirements/cards/issue-{N}.md` |
| [contract.md](contract.md) | `docs/contracts/issue-{N}.md` |
| [adr.md](adr.md) | `docs/adr/{nnn}-issue-{N}.md` |
| [tests-approved.md](tests-approved.md) | `tests/approved/issue-{N}.md` |
| [review.md](review.md) | `docs/requirements/review/issue-{N}.review.md` |
| [finding.md](finding.md) | `docs/requirements/review/issue-{N}.findings.md` |

Процесс: [SDD_WORKFLOW.md](../SDD_WORKFLOW.md) · [sdd-tier-epic-feedback.md](../sdd-tier-epic-feedback.md).
