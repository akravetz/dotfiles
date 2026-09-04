---
name: assumption-release
description: Audit a proposed implementation for defensive complexity. Use when the user asks which assumptions could simplify a design, requests an assumption-release pass, or wants the smallest sufficient solution after an implementation has been proposed. Do not use for ordinary implementation or review work that does not ask for simplification.
---

# Assumption Release

Treat the current proposal as the defensive baseline. Find the unverified constraints that make it complex, and determine what can be removed if those constraints do not apply.

Preserve the user's explicit requirements and scope. Do not change code or operational state unless the user separately asks for that work.

## Analysis

1. Identify the implicit constraints, unverified risks, and edge cases that caused the proposal to add complexity.
2. Produce a short list of simplifying assumptions. Rank it by expected reduction in total complexity, including implementation, rollout, and ongoing operations. Do not rank only by likelihood.
3. For each assumption, state:
   - What must be true
   - What evidence or user answer can confirm it
   - The exact code, branches, states, abstractions, migration steps, compatibility logic, retries, or fallbacks it removes
   - The expected reduction in complexity
   - The work, risk, or responsibility that moves to business operations or another system
   - Whether it is compatible with higher-ranked assumptions
4. Distinguish assumptions from recommendations. Mark an assumption as unverified until evidence confirms it.
5. Select the strongest mutually compatible assumptions. Rewrite the proposal as the smallest sufficient solution under those assumptions. Compare it with the original proposal and state which defensive parts remain necessary.

Do not silently relax explicit requirements or required security, privacy, compliance, data-integrity, or irreversible-action safeguards. If one of these requirements causes substantial complexity, identify it as a requirement that the user could explicitly choose to renegotiate.

Before giving the result, check for wishful assumptions, hidden transfers of work to people, conflicts between assumptions, and machinery that the smaller design no longer needs. Refine the result once.

When repository or operational evidence can answer a question, inspect that evidence before asking the user. Ask only the minimum factual questions needed to confirm or reject the assumptions with the largest effect.
