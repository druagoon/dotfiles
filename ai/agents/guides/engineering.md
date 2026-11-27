# Engineering Guide

Apply to non-trivial design, multi-module refactoring, complex root-cause debugging, and design review.
These rules follow global preferences and never expand authorization.

## Investigation & Design

Before finalizing a non-trivial plan, refactoring, diagnosis, or review:

1. Inspect affected architecture, contracts, manifests, tests, and runtime constraints before forming conclusions.
2. Focus on the forces that actually govern the change: state and resource ownership, module coupling, failure modes, and operational constraints.
3. Compare viable approaches by change locality — what maintainers must read, edit, and verify — and define validation upfront.

## Architecture & Evolution

- Match architectural rigor to actual use (production service versus internal tool or prototype); avoid both toy scaffolding and assumed enterprise scale.
- Make state and resource ownership explicit; introduce services, async workflows, or distributed coordination only for concrete needs.
- Optimize boundaries for local reasoning: group code that changes for the same reason, isolate independently evolving behavior behind explicit contracts, and avoid sibling-feature coupling.
- Choose file and module granularity to minimize the context needed to change and verify code; never add indirection or dynamic discovery solely to avoid explicit wiring.
- Address structural debt when leaving it compromises the outcome, and treat compatibility as a trade-off rather than a veto: plan migration for justified breaking changes (with authorization) and add shims or dual paths only for concrete rollout needs.

## Dependencies & APIs

- Respect declared runtime and version constraints from manifests and lockfiles; discuss upgrades when they materially affect the design.
- Prefer mature libraries when their value outweighs maintenance, security, licensing, and dependency costs.

## Implementation

- Parse and validate untrusted inputs into typed structures at external boundaries so internal code trusts invariants; use cohesive objects for shared state/lifecycles and pure functions for stateless transforms.
- Separate complex deterministic logic from I/O or frameworks only when it meaningfully improves clarity, reuse, or testability; do not wrap simple calls in traits, protocols, or dependency injection solely to mock them.
- Preserve error context and distinguish validation, domain, dependency, and programming failures; fail fast on programming errors and broken invariants, and fail closed at trust boundaries unless recovery is intentional and safe.
- Keep functions focused with early returns for clear flow rather than redundant defensive guards; abstract only real shared invariants or concrete extension points.
- Make concurrency, cleanup, and failure behavior explicit, and check affected callers and contracts before finishing design-level changes.
