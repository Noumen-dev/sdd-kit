# Локальный shell (Zerobox)

Общая платформенная таблица для ролей `noumen-*`. В role skill — краткий intro роли и ссылка сюда.

Zerobox 0.3.3 — обёртка **одной** команды execute, не всего процесса агента. Сначала граница `permission_policy` (allow_listed + cwd репозитория), где это применимо.

Ставится так: `cargo install zerobox --version 0.3.3 --locked`. Без `--locked` Cargo берёт `rama-error 0.3.0`, и сборка падает: в alpha.4 ещё есть `rama_error::OpaqueError`, в 0.3.0 его перенесли.

| Хост | Что делает `zerobox` | Как звать команду |
|------|----------------------|-------------------|
| Windows, нативный | Запускает процесс напрямую. Файлы и сеть не ограничены (`get_platform_sandbox(false)` → `None`). В отчёте так и пиши. В оркестратор как sandbox не подключать. | `zerobox -- cmd /c <команда>` или полный путь к exe. Builtin PowerShell (`echo`) даёт `program not found`. |
| Linux | Закрывает запись и сеть (bubblewrap + seccomp + namespaces), пока не открыты флаги. | `zerobox -- <exe> [args]`. Запись: `--allow-write=<path>`. Сеть: `--allow-net=<host>`. |
| macOS | Та же политика по умолчанию, бэкенд Seatbelt (`sandbox-exec`). | Как на Linux. |
| WSL2 | Это Linux-бэкенд: изоляция есть. `zerobox.exe` с хоста Windows её не даёт. | Ставить и вызывать **внутри** WSL. |
