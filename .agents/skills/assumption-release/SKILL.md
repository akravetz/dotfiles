---
name: assumption-release
description: Review a proposed or existing implementation for assumptions that prevent simplification. Use for requested simplification or assumption-release reviews, not ordinary implementation or general code review.
---

# Assumption Release

Find the smallest implementation that satisfies the user's required behavior. Existing code and tests show current behavior; establish which parts are required.

Preserve the user's explicit requirements and scope. Do not change code or operational state unless the user separately asks for that work.

## Review the supported flow

Read accepted decisions, released constraints, and the intended lifetime of this work. Trace relevant producers, saved facts, events, and consumers before asking questions that source evidence can answer.

For guards and fallbacks, identify a reachable production case. Distinguish states a generic API permits from states its actual callers produce. Check what defaults and pending results cause, and which guarantees an upstream boundary already enforces. Separate normal absence from violated guarantees.

## Find deletions

Examine whether separate modes, outcomes, events, representations, or owners need distinct behavior. Consider using the normal workflow or an existing default. Check actual consumers before preserving customization, expanding behavior, or introducing compatibility work. An implementation constraint may be changeable without a new UI, API, or operating procedure.

Review tests for distinct observable behavior. Identify unsupported fixtures, duplicate assertions, and production helpers retained only for tests.

Separate deletions supported by evidence from tradeoffs that need a product or operational decision. Mark unknowns as unverified. Apply earlier decisions to related paths. For exceptional recovery, describe existing handling and the consequence of doing less; do not assume every possible failure needs its own mechanism.

## Present the smallest sufficient result

Rank findings by net code and maintenance reduction across affected systems. For each, give evidence or the missing decision, concrete deletions and necessary additions, and meaningful behavior or operational consequences. State overlaps or conflicts between findings.

Use the user's definition of simplification. Report production, test, and temporary code separately. Moving or compressing code does not establish a reduction.

Select the strongest compatible changes and compare the resulting design with the baseline. Revisit sibling paths, callers, tests, and compatibility machinery that become unnecessary. Explain which remaining complexity is required. If evidence supports no useful reduction, say so.

Do not silently relax explicit requirements or required security, privacy, compliance, data-integrity, or irreversible-action safeguards. Identify substantial constraints the user could explicitly renegotiate. Check for unsupported assumptions and hidden transfers of work to people before reporting.
