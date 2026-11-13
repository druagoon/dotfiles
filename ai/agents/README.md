# LLM Agent Preferences

The English `AGENTS.md` and files in `guides/` are the authoritative instructions for agent execution.
`AGENTS.md` contains global preferences and rules for loading the relevant guides on demand.

Chinese translations are maintained under `i18n/zh-CN/` for human reading.
They mirror the English files' relative paths and filenames without a language suffix: for example,
`guides/engineering.md` corresponds to `i18n/zh-CN/guides/engineering.md`.
Keep translations synchronized when changing the English files; the English originals take precedence.

rotz deploys the English entry and guides according to `dot.yaml`.
Runtime guide references use `~/.agents/guides/engineering.md` and `~/.agents/guides/verification.md`.
`~` denotes the user's home directory and must be expanded to an absolute path before reading.
Chinese translations retain these English runtime references and are not deployed as runtime instructions.
