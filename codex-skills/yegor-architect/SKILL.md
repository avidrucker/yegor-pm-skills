---
name: yegor-architect
description: "Separate architect mode from courier mode: design in writing first, then execute the accepted design without redesigning midstream. Use when Codex is starting fuzzy work, encountering a design question during implementation, reviewing whether a change matches an agreed design, decomposing work into courier tasks, or resolving who decides a technical/design conflict."
---

# Yegor Architect

## Overview

Use this skill to keep design authority and implementation delivery separate. Architect mode writes the design and decomposes the work. Courier mode implements the accepted design. Do not mix them in one session unless the user explicitly reopens the design.

The original Claude Code source remains in `skills/yegor-architect/`. This Codex port keeps the architect/courier discipline and removes Claude-specific wording.

## Two Modes

**Architect mode**

- Output: written design in the issue, spec, ADR, or project-approved design artifact.
- Forbidden: implementation branches, production code edits, PRs that deliver the solution.
- Done when: a competent courier can implement without more design questions.

**Courier mode**

- Output: code, tests, docs, or other deliverables that implement the accepted design.
- Forbidden: redesigning, expanding scope, or second-guessing the issue while delivering.
- Done when: the deliverable satisfies the accepted design and project close criteria.

Name the mode before acting. If the mode is ambiguous, stop and state the choice.

## When To Use Architect Mode

Use architect mode when:

- The task is fuzzy, broad, or has multiple plausible designs.
- The code site, interface, data model, or ownership boundary is unclear.
- A user asks for a plan, architecture, design, decomposition, or decision.
- A courier hits a new design question during implementation.
- A PR appears to match code style but violate the accepted design.

Architect mode should produce written decisions, not code.

## Architect Deliverables

For substantial work, produce:

1. **Scope status:** 4-8 product or subsystem items with rough completion state.
2. **Current issues:** 4-8 concrete problems already affecting development.
3. **Risks:** 4-8 future problems with probability and impact.

For a narrow ticket, scale this down to the smallest useful written design: goal, constraints, chosen approach, rejected alternatives, and courier-ready tasks.

## Architect Rules

- One architect decides. Others provide input, but the architect owns the call.
- Requirements are the architect's boss. If the requirement is silent, amend it instead of arguing from authority.
- Decisions live in durable text: issue comments, specs, ADRs, or project docs.
- Decompose complex work into bounded courier tasks, usually no more than 60 minutes each.
- The architect enforces design only by filing bugs and reviewing code.
- Add independent reviewers in proportion to risk. High-stakes calls need more eyes.
- The architect is accountable for bad calls. Fix them with documented requirement/design changes.

## Courier Rules

- Do not begin delivery until the design is accepted.
- Implement the design as written.
- Prefer fast, clean delivery over creative reinterpretation.
- If the design is wrong, stop delivery and reopen architect mode in a new issue/comment.
- If a sub-problem is deferred, create a tracked puzzle or follow-up using the project's convention.

## Mid-Implementation Design Questions

When courier work uncovers a design question:

1. Stop before broadening the implementation.
2. Preserve the current partial deliverable only if it is still valid.
3. Record the question in the tracker or design artifact.
4. Create a bounded follow-up if the current slice can still close without it.
5. Re-enter architect mode in a separate session or issue.

Do not silently redesign while coding.

## PR And Change Review

Separate two checks:

1. **Courier check:** Does this implement the accepted design?
2. **Architect check:** Was the accepted design correct?

If the courier check fails, request changes on the PR. If the architect check fails, file or update a design issue; do not bury a design reversal inside a PR review.

## Solo-Agent Tactics

- Say the mode explicitly: "Architect mode" or "Courier mode."
- Use separate artifacts where practical: issue/spec for design, branch/editor for delivery.
- Let yesterday's accepted design win until you formally reopen it.
- Treat redesign urges as a signal to stop, write the question down, and split work.

## Pitfalls

- Designing forever. Cap architect mode to the smallest decision that unblocks delivery.
- Two architects. If two sessions disagree, reopen the written design instead of letting both proceed.
- Courier creativity. Clever work outside the accepted design is a defect, not initiative.
- Verbal design. "We discussed it" is not architect output.
- Architect coding without an explicit hat switch.

## Source References

Use the original Claude skill for deeper details: `skills/yegor-architect/SKILL.md`. For rationale, read:

- `research/philosophy_05_architect_then_courier.md`
- `research/philosophy_21_architect_authority.md`
