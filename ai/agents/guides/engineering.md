# Engineering & Architecture

## Core Philosophy & Architecture

- **Architectural Target:** Focus strictly on "Mid-Sized Enterprise Systems." Categorically reject hyper-scale over-engineering and premature distribution (e.g., microservices or complex distributed transactions) unless forced by hard physical isolation or extreme traffic constraints.
- **Pragmatic & Just-Enough Design:** Avoid inventing extra entities, components, or abstractions without clear necessity. Balance security, maintainability, and observability against limited R&D and DevOps resources.
- **Production-Ready Defaults:** Skip the "demo/toy" phase. Directly provide modern, production-grade scaffolding and architectural skeletons aligned with mid-sized best practices.

## Implementation Guidelines

- **Pattern Selection:** Prioritize high-cohesion, low-coupling "Modular Monoliths" or clean, well-structured "Monorepos".
- **Compatibility:** Add backward compatibility or legacy workarounds _only_ when explicitly requested.
- **Library-First Implementation:** When a mature, popular, actively maintained third-party library already solves the problem well, prefer using that dependency over hand-rolled implementation. Inspect project manifests and lockfiles first, verify compatibility with the pinned version, and only implement manually when no suitable dependency exists or the dependency cost, security risk, license, or complexity is not justified.
- **Typed Boundaries:** Prefer explicit types and contracts for public boundaries and non-trivial internal logic. In Python, use type annotations, `Protocol`, `TypedDict`, `dataclass`, Pydantic models, or equivalent structures when they clarify behavior. In Rust and shell scripts, make inputs, outputs, and failure modes explicit.
- **Error Handling:** Do not swallow errors silently. Preserve useful context, distinguish business errors from external dependency failures and programming errors, and choose fail-fast behavior unless recovery is intentional and safe.
- **Testable Design:** Keep core logic easy to unit test by separating it from I/O, network calls, time, randomness, process execution, and global mutable state. Inject or wrap those dependencies when doing so improves determinism and maintainability.
- **Elegant Code Structure:** Write elegant implementation code that prioritizes extensibility, maintainability, robustness, and readability. Avoid deeply nested control flow; prefer clear decomposition, guard clauses, and straightforward data flow.
- **Reusable Shared Abstractions:** Extract shared or cross-cutting behavior into common functions, classes, modules, libraries, or typed abstractions when doing so reduces duplication and improves maintainability. Keep abstractions purposeful and avoid ceremony that does not clarify ownership or reuse.
- **Complexity Control:** Keep functions and modules focused. Avoid oversized functions, excessive parameters, deep nesting, and tangled branching; split code into cohesive units when it improves clarity or testability.
- **Early Returns:** Prefer early returns and guard clauses unless a single-exit structure is necessary for correctness, resource management, transaction handling, or clearer control flow.
- **Named Semantic Values:** During implementation, avoid hard-coded scalar values—including strings, numbers, and booleans—when they represent identifiers, states, thresholds, defaults, policies, or other domain semantics. Prefer constants, class constants, instance attributes, enums, typed configuration, or explicit parameters according to ownership and variability. Keep literals inline only when they are intrinsic language idioms or when naming them would not improve clarity, safety, or maintainability.
- **Pattern-Guided Extensibility:** Prefer established design patterns—such as factory, strategy, observer, or singleton—when they provide a clear extension point, reduce expected future modifications, and keep complexity proportionate to the problem. Do not introduce patterns speculatively or for ceremony alone. When the maintainability benefit versus added complexity is uncertain, present the concrete alternatives and trade-offs, then ask the user to choose before implementation.
- **User-Directed Exceptions:** When the user explicitly requests a specific approach or temporary supporting implementation, follow that request even if it introduces otherwise unnecessary components or abstractions. Keep the exception narrowly scoped, explain material trade-offs, and do not generalize or extend it beyond the requested use case.

## Documentation Standards

- **Conciseness:** Keep documentation concise, task-relevant, and focused.
- **Context & Verification:** Include assumptions, setup, usage, and verification steps when relevant or when mitigating risk/ambiguity.
- **Estimates:** Avoid time or cost estimates unless explicitly requested.
