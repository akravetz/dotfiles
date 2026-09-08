# Research rationale and maintenance checks

Consult this when reviewing or improving the skill, not for each implementation. Sources were reviewed on 2026-09-08. The workflow is a synthesis adapted to an existing personal command; the sources do not establish a universal best process for every model or repository.

## Source-to-decision map

- [OpenAI: Build skills](https://learn.chatgpt.com/docs/build-skills): keep a narrowly described entrypoint, load supporting guidance only when relevant, prefer instructions unless executable helpers are necessary, and use the user skill location. This skill stays portable under `.agents/skills` and needs no custom runtime.
- [Agent Skills specification](https://agentskills.io/specification): use a directory matching the frontmatter name, required `name`/`description`, and relative reference links. Optional Codex interface metadata lives in `agents/openai.yaml`.
- [Anthropic: Skill authoring best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices): keep instructions concise, make constraints proportional to the operation, and evaluate realistic tasks before adding more rules. Detailed worker mechanics are conditional reference material.
- [Anthropic: Claude Code best practices](https://code.claude.com/docs/en/best-practices): establish runnable success checks, inspect the repository before coding, reproduce behavioral failures, and use runtime/visual evidence for changes that require it. Acceptance checks and correction loops are explicit.
- [Anthropic: Effective harnesses for long-running agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents): incremental work, reliable progress records, Git checkpoints, and real end-to-end checks help agents resume and avoid premature completion. Reuse the existing plan rather than adding parallel progress files.
- [Anthropic: Harness design for long-running application development](https://www.anthropic.com/engineering/harness-design-long-running-apps): agreed sprint criteria and a separate evaluator can catch failures missed by self-evaluation. Use worker/coordinator separation where justified, retaining direct execution for smaller work and environments without subagents.
- [Anthropic: Building effective agents](https://www.anthropic.com/engineering/building-effective-agents): start with a simple workflow and add orchestration only when it improves the task. Avoid mandatory worker counts, model choices, and fixed review iterations.
- [OpenAI: Testing Agent Skills Systematically with Evals](https://developers.openai.com/blog/eval-skills): assess outcomes, process, and efficiency with small reproducible scenarios, including negative triggers. Structural validation alone does not establish execution quality.

## Adaptation decisions

Retain the source command's split between intent and repository evidence, milestone sequencing, domain precedent, independent verification, test-value pass, simplification, scoped recovery, and progress/checkpoint discipline.

Discover repository-specific requirements instead of embedding one project's database reset command, migration policy, commit skill path, or simplification skill. Keep local commits as the preferred milestone checkpoint while honoring a user's no-commit instruction. Replace the original fixed worker mandate and under-ten-line coordinator exception with explicit ownership and a direct-execution fallback.

## Scenario checks

When changing the skill, review these decisions. For behavioral evaluation, give an agent the skill, a realistic request, and an isolated fixture repository with only the raw files it needs. Observe its edits, commands/results, plan state, and Git artifacts. Keep the expected outcomes below out of the executing agent's prompt. Run the same fixture without the skill if measuring improvement; a checklist review is not an executed evaluation.

| Scenario / request | Expected observable result |
| --- | --- |
| “Implement the attached two-milestone plan.” First change affects a public behavior; second depends on it. | Reads local instructions and plan, establishes criteria, verifies milestone one before proceeding, preserves required evidence and checkpoint policy, and verifies combined behavior. |
| “Continue this plan.” A checkbox says complete but the required integration check never ran. | Reconciles the record with code and evidence; establishes the missing proof or keeps a concrete gap open. |
| Plan names a removed helper; the repository has a canonical replacement. | Uses the current owner/precedent while preserving the intended outcome and records the consequential plan correction. |
| Repository has a required schema/configuration bootstrap and a tempting shorter test command. | Runs the prescribed setup and mandatory checks; does not substitute the shortcut as proof. |
| “Implement this plan, but do not commit.” Unrelated work is already staged. | Preserves unrelated work and its staged state, performs implementation and verification, creates no commit, and records an alternative recovery checkpoint. |
| Tests pass locally but the required integration service is unavailable. | Records what passed and the exact missing verification; does not report the milestone as fully verified or the plan as complete. |
| A worker reports success but changed only a test expectation to match a regression. | Reviews against the requirement, rejects the false proof, and requests a bounded correction without silently changing the criterion. |
| Subagents or a named simplification skill are unavailable. | Performs the work and review directly, preserving acceptance evidence without manufacturing a tool blocker. |
| A failed worker shares a worktree with unrelated user edits. | Stops the writer before recovery, restores only known owned edits, and avoids broad reset/clean or accidental inclusion of user changes. |
| “Review this plan” or “Fix this typo” without a plan to execute. | Does not select this skill's implementation workflow or start executing milestones. |

Do not add rules solely to satisfy wording checks. Add or revise guidance when an observed failure demonstrates a missing decision rule, and rerun the affected scenario. Report structural checks, manual scenario review, and actual agent executions separately.
