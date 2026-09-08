---
name: implement-plan
description: Execute or resume an existing ExecPlan or multi-step implementation plan through verified milestones, targeted review, recovery checkpoints, and living plan updates. Use when asked to implement a plan, carry out a plan file, or continue its remaining milestones. Do not use just to create or critique a plan, or for an isolated edit without a plan.
---

# Implement Plan

Carry the existing plan through implementation and observable verification. Continue across milestones until the requested scope is complete or a specific dependency, decision, or permission prevents further progress. Scale the process to the work; a small milestone needs a small brief and focused proof.

## Authority and scope

The user's current instructions set the task and authorization. The plan supplies intended outcomes, scope, dependencies, accepted decisions, and acceptance criteria. The target repository supplies current architecture, established implementations, local instructions, and executable checks. External systems supply their actual current state.

Resolve stale implementation details using repository evidence while preserving the intended behavior. Record consequential corrections in the plan's existing decision and affected implementation sections. Do not quietly weaken an acceptance criterion or decide an unresolved product/API tradeoff just to make the implementation pass.

Use the target repository's tools, plan format, migration/recovery policy, generated-file workflow, and commit conventions. Discover these locally; this skill assumes no framework, directory layout, installed companion skill, or database command.

## Establish the starting point

1. Locate the plan from the request or conversation. Read it completely, along with applicable repository instructions and any required plan-writing rules. If no unambiguous plan can be found, ask for its location; do not invent a replacement assignment.
2. Inspect the branch, current commit, working tree, staged changes, and relevant recent history. Distinguish already completed work from unchecked work using code and available verification evidence, not checkboxes alone. Preserve unrelated changes, including changes already staged by the user.
3. Start at the first incomplete milestone whose prerequisites are satisfied, respecting the plan's order. Check the relevant baseline before changing behavior when doing so will distinguish existing failures from regressions. If prerequisites are broken, determine whether repairing them is in scope; do not label unrelated failures as caused by this work without evidence.
4. Locate the code that owns the behavior and its closest accepted precedent. Prefer the existing domain mechanism over a similar-looking generic abstraction. Inspect only the relevant docs, implementation, tests, and callers; follow links when necessary instead of loading the entire repository.
5. Resolve ordinary choices from this evidence and proceed. Ask only when an answer changes scope, correctness, compatibility, ownership of overlapping edits, or authorization and cannot be inferred. Continue independent authorized work while an answer is pending.

## Prepare the next milestone

Keep a concise brief in the existing plan or task state:

- Outcome and boundaries: what must change, what is excluded, and any prerequisite.
- Owner and precedent: relevant modules/files, intended reuse, and justified differences.
- Acceptance evidence: for each criterion, the observable result and the command or interaction that will demonstrate it.
- Execution needs: required environment, local validation commands, data or generated-artifact steps, and relevant recovery constraints.

Phrase behavioral criteria as real input/condition → caller/user/system outcome. A UI criterion may need a browser interaction; a cross-layer change may need an integration check; compilation alone cannot establish either. Cover a relevant rejection/failure path when it is part of the changed contract.

Identify the recovery baseline before editing. In Git repositories, prefer a normal local commit after each verified milestone, before starting the next, when allowed by the user's instructions and repository policy. Do not turn a no-commit request into a blocker: preserve a scoped patch or equivalent local checkpoint outside tracked source and record the baseline instead. A source checkpoint does not reverse database changes or external side effects.

## Implement, review, verify

1. **Choose ownership.** For a substantial milestone, use a bounded implementation subagent when available, permitted, and useful for isolating context or separating implementation from review. Follow [delegation.md](references/delegation.md) when delegating. Otherwise implement directly with the same review and evidence requirements. Do not invent a delegation requirement for a trivial edit or block because a subagent/companion skill is unavailable.
2. **Implement one milestone.** Make the smallest cohesive change satisfying its criteria. Include required callers, tests, generated artifacts, and documentation; avoid speculative abstractions or adjacent cleanup. Remove code made obsolete by this change when the plan requires it, preserving compatibility the plan still promises.
3. **Prove the changed behavior.** For a behavioral bug, reproduce the original failure first when feasible, preferably with an existing or focused regression test. A new test must protect a distinct observable contract and fail for the intended reason, not merely a broken fixture or missing import. Reuse existing coverage when sufficient. Skip new tests that only inventory fields, mirror branches, or assert generated prose unless those exact values are the stable contract. Follow explicit repository testing requirements.
4. **Review the actual diff.** Apply the repository's review criteria. Compare implementation and tests with every acceptance criterion, trace changed behavior through relevant callers/boundaries, and investigate concrete likely failures. A worker's report is a lead, not proof. Keep review focused on actionable correctness, integration, compatibility, and maintenance issues caused by this change.
5. **Simplify the changed code.** Remove unnecessary indirection, duplication, speculative fallbacks, stale names, and redundant tests introduced by this work. Preserve required behavior, data integrity, and compatibility. Use an applicable repository simplification process when available; otherwise perform this pass directly. Do not make a particular named skill a prerequisite.
6. **Verify the integrated result.** Run the cheapest checks that collectively establish the criteria, plus all required repository checks. Use the prescribed setup/reset/sync before tests affected by schema or configuration changes. Inspect actual exit status and output; zero discovered tests or a skipped suite is not a pass. Exercise the running behavior when unit checks cannot establish the outcome, using the repository's browser/API tools where available.
7. **Correct and recheck.** Fix root causes, then rerun checks invalidated by the correction. In delegated mode, return bounded feedback to the owning worker. Do not suppress failures, relax assertions, or change expected behavior without a requirement-based reason. Repeat broad checks only when required or when later changes invalidate the evidence.

Verification belongs to the actual integrated state. Independently run the decisive acceptance checks after delegated edits; reuse trustworthy unchanged lower-level results where appropriate instead of blindly repeating every command. If formatting, hooks, generated files, or another writer changes relevant code after a check, reassess and rerun affected verification.

## Failures and recovery

Keep a failed or unverified criterion open; do not advance a dependent milestone until its prerequisites are verified. Distinguish an implementation failure, a demonstrated baseline failure, an unavailable environment, and an unresolved requirement. Record the concrete evidence, what remains unproven, and the next useful action. A required check that cannot run is a verification gap, not completed work.

Do not repeat an unchanged failing command or restart workers indefinitely. Each retry should test a new hypothesis or apply a specific correction. If attempts stop producing useful evidence, narrow the reproduction, inspect the boundary that fails, or use a fresh bounded review when permitted. Escalate the specific missing decision or capability if no authorized route remains.

Before replacing a failed worker or reverting its changes, stop it and confirm it is no longer writing. Restore only known task-owned changes against the recorded baseline; preserve unrelated/staged user work. Do not use broad reset/clean operations. If ownership cannot be separated safely, retain the diff and ask for the smallest necessary decision. For data/external state, use the target's documented recovery procedure; a Git revert is not operational recovery.

## Record, checkpoint, continue

After verification, update the existing plan's living sections with milestone status, commands/interactions and results, material decisions or surprises, and remaining gaps. Do not add a second progress system or rewrite the plan wholesale. Distinguish implemented, verified, and checkpointed states where they differ.

When creating a milestone commit:

- Follow the target repository's required pre-commit sequence and message conventions. Do not substitute a focused check for a mandatory check unless the repository or user allows it.
- Stage only task-owned changes and the plan update; inspect the complete staged diff and run `git diff --cached --check`. Existing staged user changes must not enter the commit; isolate task-owned hunks or use a separate worktree/index when appropriate.
- If hooks change files or fail, inspect the changes, fix the cause, rerun affected checks, and stage only the intended result before retrying. Confirm the resulting commit contains the intended milestone.

Continue with the next incomplete milestone. Before a context handoff, leave enough durable state to resume: current milestone, last verified checkpoint, unfinished changes, exact remaining checks, blocker/decision if any, and next action. On resume, reconcile that record with Git and the working tree before editing.

At the end, check that the milestones work together and that the overall acceptance criteria are met. Report the delivered behavior, decisive verification results, checkpoint(s), and any concrete limitation. Never claim checks, commits, pushes, deployments, or completion that did not occur. Perform remote publication or shared-state mutations only within the user's existing authorization; do not ask again for an action already authorized.

For maintenance of this skill, its research rationale and scenario checks are in [research-and-validation.md](references/research-and-validation.md). They are not required reading during ordinary plan execution.
