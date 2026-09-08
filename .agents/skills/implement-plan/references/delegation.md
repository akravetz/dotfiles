# Delegated milestone execution

Read this when using a subagent for an implementation milestone. Use only delegation allowed by the current environment and task instructions. A single implementer with targeted review is the default shape; parallel workers are useful only for independent work with clear ownership and an integration point.

## Ownership

The coordinating agent owns milestone selection, acceptance criteria, integration, independent verification, living plan updates, and checkpoints. The implementation worker owns its scoped source, tests, generated artifacts, required documentation, focused checks, and corrections.

While a worker is editing, the coordinator should prepare verification, investigate a separate bounded question, or review relevant contracts. Do not duplicate the worker's implementation or concurrently edit its files. If local takeover becomes necessary, stop or explicitly transfer ownership first; there is no arbitrary line-count exception to shared-file ownership.

Serialize changes to shared state such as the Git index, the plan, generated clients, or a test database. Separate worktrees isolate source edits; they do not isolate databases, ports, or external resources. Coordinate these separately.

## Worker brief

Give the worker the minimum context needed to implement correctly:

```text
Implement [milestone] from [plan path] in [target workspace].
Scope/outcome: [behavior and exclusions].
Ownership: [files/modules and shared-state constraints].
Local instructions: [required instruction/docs paths].
Precedent: [semantic owner, existing implementation, intended reuse/differences].
Acceptance: [criteria and expected observable evidence].
Validation: [commands, environment/setup, required integration checks].
Baseline: [current checkpoint, known failures, unrelated dirty work].
Recovery: [relevant migration or external-state rules].

Implement only this scope, preserving unrelated edits. Run focused validation,
review test value, and simplify your changes. Do not commit, mutate shared state,
or launch additional workers unless this brief explicitly assigns that work.
Report changed files, criteria satisfied, commands/results, unverified gaps,
material surprises, and a concise draft plan update.
```

Include a failing reproduction when known. Do not paste an entire conversation or assert that the proposed implementation is already correct. Adapt the brief to the milestone; omit fields that add no useful information.

## Review and correction

Inspect the returned diff and actual validation evidence. Test the integrated result yourself against the agreed criteria. Where an independent reviewer would add confidence, give it the requirement, diff, and relevant raw context; ask it to find concrete violations with evidence, without feeding it a desired verdict. A reviewer is advisory and does not replace executable checks.

Return corrections to the owning worker with the failed criterion, observed result, expected behavior, relevant file/line or command output, and the smallest acceptable correction. Reuse that worker while it can make progress. Use a fresh worker only when the previous one is unavailable or a specific failure justifies a clean context.

Do not accept a worker's success summary without examining its artifacts. If a worker reports it could not verify a criterion, retain that gap until the coordinator establishes it or reports the specific blocker.
