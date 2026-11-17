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

- Before declaring completion, verify behavior and design: cohesion, ownership, state lifecycles, dependency control,
  and maintainable extension paths.
  Review whether representative changes remain local and understandable through explicit contracts;
  justify necessary cross-boundary impact and check affected consumers.
  Tests alone are insufficient; assess accepted compromises against documented limits.
- Check that implementation and validation address the agreed requirements and acceptance criteria.
  Resolve material failures or report the remaining limitations accurately.

## Delivery

- Report verification results, material gaps, and any omitted checks that materially limit confidence in the result.
  Do not imply unverified success.
  For artifact-only delivery, preserve the requested format.
  Use a separate status update for material verification limits when the task permits one.
- Keep documentation task-focused, covering setup, assumptions, migration, usage, and verification when relevant.
