---
name: yegor-microtasks
description: Apply Yegor-style microtasking by keeping work bounded to small, independently finishable units with a hard 60-minute ceiling and a practical 30-minute default. Use when Codex is estimating, planning, starting implementation, reviewing a large-looking ticket, handling scope creep, or noticing that active work is running longer than its original budget.
---

# Yegor Microtasks

## Overview

Use this skill to keep work small enough to finish cleanly. A task should have one concern, one clear deliverable, and a fixed budget: default to about 30 minutes and never exceed 60 minutes.

The original Claude Code source remains in `skills/yegor-microtasks/`. This Codex port keeps the behavior and removes Claude-specific wording.

## Sizing Rule

- Treat 60 minutes as a hard ceiling.
- Use 30 minutes as the default target unless there is a concrete reason for more.
- Fix the budget when the task is created; do not silently expand it after work starts.
- If the task cannot plausibly fit, split before coding.

State the sizing judgment briefly before starting substantial work, for example: "This looks like one 30-minute test/docs slice" or "This is three deliverables; I should split it first."

## Split Before Work

Split a proposed task when any of these are true:

- The title contains multiple outcomes joined by "and" or comma-separated changes.
- The work spans several subsystems and each subsystem could land independently.
- The expected change would naturally produce several commits.
- The task needs several unrelated tests.
- The code site or scope is unknown; route discovery to a spike instead.
- The task combines design decisions with implementation; separate architect mode from courier work.

Each resulting ticket should be independently mergeable and meaningful. Do not split into trivial pieces just to increase ticket count.

## Overrun Protocol

When work runs past its budget:

1. Stop expanding the current task.
2. Name what is already complete and what remains.
3. Convert leftover implementation sub-problems into tracked follow-up work; for code-site deferrals, use `yegor-pdd` puzzle comments.
4. Close or hand off the original task only with the deliverable it actually completed.
5. Record the estimation miss if the project tracks calibration.

Do not push through by silently redefining the task. The budget is a control surface, not a guess to ignore.

## Backlog Review Checklist

When reviewing issues or planning a batch:

- Flag anything that cannot fit inside 60 minutes.
- Prefer one concern, one code area, and one test/evidence target per ticket.
- Convert "figure out how X works" into a bounded spike with a written output.
- Keep blocked or external-dependency work separate from executable courier work.
- Pull the smallest unblocked high-impact item next.

## Pitfalls

- Salami-slicing: splitting coherent work into meaningless fragments.
- Estimate inflation: defaulting every task to 60 minutes "just in case".
- Discovery disguised as implementation: research should be a spike, not a microtask.
- Chat-only leftovers: if unfinished work remains, capture it in the tracker or a PDD puzzle.
- Self-approval drift: finishing a small task still requires the project's normal tests, review, and close protocol.

## Source References

Use the original Claude skill for deeper details until all Codex ports exist: `skills/yegor-microtasks/SKILL.md`. For rationale, read `research/philosophy_03_microtasks_microtasking.md`.
