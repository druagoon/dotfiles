# Engineering Guide

Apply these requirements to relevant design, implementation, debugging, and review work.
They follow the host's instruction hierarchy and global preferences and do not expand authorization.

## Investigation & Design

Before finalizing a non-trivial implementation plan or beginning a non-trivial implementation:

1. Inspect affected architecture, runtime, manifests, contracts, tests, and deployment constraints.
2. Identify governing quality attributes: correctness, maintainability, extensibility, security, operability,
   performance, and migration impact.
   Review ownership, state, coupling, duplication, hidden dependencies, hard-coded policy, oversized units,
   and test seams.
3. Compare viable approaches and define validation.
   Choose the strongest design justified by requirements, evidence, operational constraints, and lifecycle cost,
   rather than diff size.

For debugging and review, inspect the relevant architecture, contracts, and evidence before forming conclusions.
Evaluate proposed fixes and recommendations against the same quality attributes and operational constraints.

## Architecture & Evolution

- Derive architecture and standards from requirements and intended use.
  Production work needs appropriate security, configuration, observability, error handling, testability,
  and operational ownership.
  Avoid toy scaffolding, speculative complexity, and an assumed enterprise scale.
- Keep responsibilities cohesive, dependencies controlled, and state and resource ownership explicit.
  Choose modules, services, asynchronous workflows, or distributed coordination for concrete needs.
- Correct structural debt the change would entrench within authorized boundaries;
  resolve authorization before expanding them.
  Honor explicit user implementation choices over default architecture preferences.
  Document trade-offs and unmet criteria; exceptions do not waive authorization, security, or data integrity.
  Verified operational constraints may also justify a scoped compromise.
- Treat compatibility as a quality attribute, not a veto.
  For justified contract evolution, plan migration, versioning or deprecation, consumer transition,
  and contract checks as needed.
  Apply authorization rules to breaking changes; add shims or dual paths only for concrete rollout needs.

## Dependencies & APIs

- Inspect manifests and lockfiles; use pinned versions and compatible APIs.
  Discuss newer versions only when material to the decision.
- Evaluate libraries against the pinned runtime, maintenance, security, license, dependency, and operational costs;
  prefer mature libraries when their value exceeds those costs.

## Implementation

- Use typed boundaries and domain objects to clarify contracts, validation, and invariants;
  cohesive objects for shared state and lifecycles; pure functions for stateless transformations.
- Separate deterministic policy from I/O, time, randomness, processes, and frameworks.
  Inject dependencies where this clarifies ownership or enables meaningful tests.
- Preserve error context; distinguish validation, domain, dependency, and programming failures.
  Fail closed at trust boundaries unless recovery is intentional and safe.
- Keep modules and functions focused, with clear data flow and guard clauses.
  Abstract real shared invariants or required extension points; name semantic states, identifiers,
  and policies when useful, keeping intrinsic literals inline.
- Make concurrency, cleanup, and failure behavior explicit.
  Follow sound project conventions; improve conflicting conventions within scope.
