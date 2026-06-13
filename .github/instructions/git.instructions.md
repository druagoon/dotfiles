---
description: "Use when staging changes, analyzing diffs, writing commit messages, creating commits, or preparing a patch or diff for review. Covers commit safety, message format, and commit message generation."
name: "Git Workflow"
---

# Git Workflow Guidelines

- Create commits only when the user explicitly requests it.
- Otherwise, keep changes uncommitted and provide a patch or diff when helpful.
- Prefer Conventional Commits style.
- Keep commit subjects concise and factual.
- Use English for the entire commit message.
- When generating a commit message, examine both staged and unstaged diffs for the target files or for the whole repository when no target is specified.
- Use the format `<type>(<optional scope>): <subject>`.
- Allowed commit types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`.
- Use an imperative, present-tense subject, do not capitalize the first letter, and do not end the subject with a period.
- Add an optional body only when the change is complex enough that a short subject is insufficient.
- In commit bodies, explain what changed and why, not how.
- When asked to output a commit message, return only the raw commit message text with no surrounding explanation or code fences.

## A complete Conventional Commit message sample

```
feat(auth): implement JWT-based session management

Replace the legacy cookie-based session store with state-less JWT tokens
to improve scalability across multi-region server deployments.

- Migrate existing user sessions to the new JWT blacklist database to
  prevent sudden mass logouts during the maintenance window.
- Add custom middleware to intercept, decode, and validate headers
  on all protected API endpoints.

BREAKING CHANGE: The `X-Session-ID` header is no longer accepted. All
clients must migrate to the `Authorization: Bearer <token>` format.

Closes #412
```
