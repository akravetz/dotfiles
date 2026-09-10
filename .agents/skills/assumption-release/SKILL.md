---
name: assumption-release
description: Review or simplify an implementation by finding unsupported assumptions, unreachable machinery, and unnecessary representations. Use for requested simplification or assumption-release work, not ordinary implementation or general code review.
---

# Assumption Release

Find the smallest implementation that satisfies the user's required behavior. Existing code and tests show current behavior; establish which parts are required.

Preserve the user's explicit requirements and scope. Do not change code or operational state unless the user separately asks for that work.

## Establish the evidence

Build a compact decision ledger before proposing deletions:

- required observable behavior;
- guarantees explicitly confirmed by the user;
- guarantees established by producers, schemas, storage constraints, or external contracts;
- unverified assumptions that still require a product or operational decision;
- behavior explicitly allowed to disappear.

Apply relevant decisions already made in the conversation. Do not make the user reconfirm them. Treat names, comments, types, tests, and existing branches as claims to investigate, not proof that behavior is required.

## Review the supported flow

Trace each important value through its whole path: producer, wire or storage contract, transport, cache or state container, adapter, provider, user interface, side effect, and test. Record where its shape or meaning changes and which consumer requires each translation.

For broad audits, inventory the scoped code before ranking findings: data representations, state systems and wrappers, optional fields and fallbacks, modes and branches, files and exports, and test-only seams. Complete a scope-wide evidence sweep for each relevant category; a large early finding must not hide a separate removable layer. Briefly state which categories produced no supported finding.

For every data-fetching hook in scope, compare four things explicitly: the transport or framework result, the cached data shape, the hook's returned shape, and the rendering consumer. Look for copied query-result interfaces, repeated data defaults, casts between state types, synthetic idle/pending/success/empty states, and loading/error abstractions already supplied by the underlying framework. A shared UI component requiring a translated state does not prove the translation belongs throughout the feature; keep it only at the exact consumer boundary that requires it.

Classify reachability separately:

- production-reachable;
- test-only;
- externally or dynamically loaded;
- unreachable.

Search imports, calls, assignments, registrations, dynamic loading, and framework entry points. Use configured static graph tooling when available, but verify its entry-point model before trusting deletions. Compiler unused-local checks do not establish that exported symbols or files are production-reachable.

For guards and fallbacks, identify a reachable production case. Distinguish states a generic API permits from states its actual callers produce. Check what defaults and pending results cause, and which guarantees an upstream boundary already enforces. Separate normal absence from violated guarantees.

Audit structural symptoms without speculating about who authored the code:

- a strong contract weakened to `unknown`, duplicated manually, or recovered with a cast;
- the same entity represented in several data or state models without distinct consumers;
- generic framework state translated into another state model before rendering;
- modes, jobs, versions, lifecycle phases, or recovery paths that no producer creates;
- compatibility requirements spread beyond the integration boundary that needs them;
- helpers, exports, abstractions, or seams retained only by tests;
- fallback values that hide a violated guarantee rather than handle normal absence;
- files or symbols whose names no longer describe what they contain.

Do not collapse similarly named fields or types merely because a mechanical conversion exists. Establish that they represent the same business fact and that no producer or consumer relies on the distinction; otherwise preserve the boundary or mark the proposed merge as unverified.

## Release assumptions

Produce a short, ranked list of simplifying assumptions with the largest expected reduction in total implementation and maintenance complexity. For each assumption, state what must be true, whether evidence or an earlier user decision already confirms it, the concrete code and operational machinery it would remove, and any behavior, risk, or work transferred elsewhere.

Actively identify operational guarantees that could replace application complexity, such as import cadence, manual prework, correction-and-rerun procedures, single-source constraints, or operator ownership conventions. Present these as assumptions to confirm, state the code each would remove, and make any transferred operational burden explicit.

Phrase each high-leverage unverified assumption as a direct factual question for the user. Ask only questions that repository or operational evidence cannot answer, and do not re-ask decisions already established in the conversation.

Before applying an unverified simplifying assumption, pause for the user's answer unless the user explicitly requested autonomous judgment. If all useful assumptions are already confirmed, say so explicitly and continue without an unnecessary pause.

## Find deletions

Examine whether separate modes, outcomes, events, representations, or owners need distinct behavior. Consider using the normal workflow or an existing default. Check actual consumers before preserving customization, expanding behavior, or introducing compatibility work. An implementation constraint may be changeable without a new UI, API, or operating procedure.

Review tests for distinct observable behavior. Identify unsupported fixtures, duplicate assertions, and production helpers retained only for tests.

Prefer removing an unnecessary representation over making its mapper cleaner. Prefer generated or validated boundary contracts over parallel handwritten response types. Keep unavoidable compatibility at the narrowest edge instead of shaping the internal design around it.

Separate deletions supported by evidence from tradeoffs that need a product or operational decision. Mark unknowns as unverified. Apply earlier decisions to related paths. For exceptional recovery, describe existing handling and the consequence of doing less; do not assume every possible failure needs its own mechanism.

## Use scouts on broad reviews

For a broad cross-cutting review, use a small number of read-only subagents when delegation is available and authorized. Divide work by evidence question rather than directory, such as production reachability, contracts and fallbacks, or duplicate state and lifecycle machinery.

The primary agent owns the decision ledger and synthesis. Give scouts the ledger and raw artifacts, but not suspected findings or intended answers when independence matters. Require file and symbol evidence, production versus test reachability, uncertainty, and the machinery each finding would remove. Do not let multiple agents independently edit the same dependency graph; integrate edits through one owner. A final skeptical scout may challenge proposed deletions for missed dynamic or external consumers.

Use one agent when the surface is small or the work cannot be partitioned cleanly. Delegation is overhead, not evidence of rigor.

## Apply an authorized simplification

When the user explicitly authorizes changes, implement the strongest compatible, evidence-supported deletions first. Work in cohesive, behavior-preserving clusters and verify each cluster in proportion to risk.

After every deletion, revisit its callers, sibling paths, types, adapters, fixtures, exports, constants, and compatibility code. Removing one layer often makes another unnecessary. Repeat until a complete pass finds no new removable machinery. Static analysis and compilation may also reveal that an apparently unused exported type must remain nameable; retain such proven requirements.

Do not optimize for raw line count. Count removed production machinery, tests, and temporary code separately. Compression, relocation, or a new abstraction is not a deletion. Stop when remaining complexity has a reachable producer, a distinct consumer, or an explicit requirement.

## Present the smallest sufficient result

Rank findings by net code and maintenance reduction across affected systems. For each, give evidence or the missing decision, concrete deletions and necessary additions, and meaningful behavior or operational consequences. State overlaps or conflicts between findings.

Use the user's definition of simplification. Report production, test, and temporary code separately. Moving or compressing code does not establish a reduction.

Select the strongest compatible changes and compare the resulting design with the baseline. Revisit sibling paths, callers, tests, and compatibility machinery that become unnecessary. Explain which remaining complexity is required. If evidence supports no useful reduction, say so.

Do not silently relax explicit requirements or required security, privacy, compliance, data-integrity, or irreversible-action safeguards. Identify substantial constraints the user could explicitly renegotiate. Check for unsupported assumptions and hidden transfers of work to people before reporting.

## Learn from feedback

Treat user corrections during the task as updates to the decision ledger and apply them to related paths. When the user asks to improve durable instructions, generalize only recurring reasoning failures, not project politics or one-off preferences. Capture each candidate as: observed behavior, human correction, general principle, scope or counterexample, repository evidence, and a realistic eval case.

For a requested skill evaluation, use an independent agent on a clean historical or synthetic snapshot. Provide the skill, a realistic request, and raw artifacts without the expected answer. Compare its evidence-backed findings with a human-reviewed baseline, then make only narrow instruction changes supported by misses or false positives.
