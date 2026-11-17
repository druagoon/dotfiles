# Verification & Delivery Guide

Apply these requirements when changing behavior, contracts, configuration, builds, or documentation, or defining tests,
validation, or acceptance criteria.
They follow the host's instruction hierarchy and global preferences and do not expand authorization.

## Validation Strategy

- Define validation before implementation or the relevant checks begin.
  Base it on affected behavior, contracts, boundaries, failure paths, and operational risk.
- Scale checks to risk: formatting, linting, typing, contracts, integration,
  and target-runtime validation as applicable.
- Use deterministic tests to verify changed behavior, contracts, boundaries, and meaningful failure paths.
  Add or update tests where existing coverage leaves a material gap.
  Keep assertions independent of implementation details.
  For changes without executable behavior, use appropriate document, configuration,
  or build validation instead of artificial behavior tests.

## Design & Completion Review

- For changes that affect software design, review the affected module boundaries, ownership, lifecycles, dependencies,
  and consumers before declaring completion.
  Review whether representative changes remain local and understandable through explicit contracts;
  justify necessary cross-boundary impact and check affected consumers.
  Tests alone are insufficient; assess accepted compromises against documented limits.
- Check the result against the agreed requirements and acceptance criteria.
  If a criterion fails, continue authorized work to address it.
  If a failed criterion cannot be addressed, identify it and report the task as incomplete.
  When a check cannot be run, state what remains unverified.

## Delivery

- Keep documentation task-focused, covering setup, assumptions, migration, usage, and verification when relevant.
