# Verification & Delivery Guide

Apply these requirements when changing behavior, contracts, configuration, builds, or documentation, or defining tests,
validation, or acceptance criteria.
They follow the host's instruction hierarchy and global preferences and do not expand authorization.

## Validation Strategy

- Define validation before implementation or the relevant checks begin.
  Base it on affected behavior, contracts, boundaries, failure paths, and operational risk.
- Scale checks to risk: formatting, linting, typing, contracts, integration,
  and target-runtime validation as applicable.
- Add or update deterministic tests for changed behavior, contracts, boundaries, and meaningful failure paths,
  without coupling tests to implementation details.
  For changes without executable behavior, use appropriate document, configuration,
  or build validation instead of artificial behavior tests.

## Design & Completion Review

- Before declaring completion, verify behavior and design: cohesion, ownership, state lifecycles, dependency control,
  and maintainable extension paths.
  Tests alone are insufficient; assess accepted compromises against documented limits.
- Check that implementation and validation address the agreed requirements and acceptance criteria.
  Resolve material failures or report the remaining limitations accurately.

## Delivery

- Report verification results, unperformed checks, and material gaps; do not imply unverified success.
- Keep documentation task-focused, covering setup, assumptions, migration, usage, and verification when relevant.
