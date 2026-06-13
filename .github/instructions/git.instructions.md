---
description: "Use when staging changes, writing commit messages, creating commits, or preparing a patch or diff for review. Covers commit safety and message format."
name: "Git Workflow"
---

# Git Workflow

- Create commits only when the user explicitly requests it.
- Otherwise, keep changes uncommitted and provide a patch or diff when helpful.
- Prefer Conventional Commits style.
- Keep commit subjects concise and factual.
- When a multi-paragraph commit message is needed, use multiple `-m` flags.
- Example: `git commit -m "feat: add automated deploy pipeline" -m "- Add CI job for image build" -m "- Add SSH-based deploy step"`
