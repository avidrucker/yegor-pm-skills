---
name: yegor-velocity
description: Apply Yegor-style velocity discipline by measuring progress primarily as verified closed tickets per time window, not commits, hours, or lines of code. Use when Codex is reviewing project progress, answering "how is it going?", checking stale work, interpreting productivity, forecasting from measured closure cadence, or pushing back on misleading activity metrics.
---

# Yegor Velocity

## Overview

Use this skill to measure delivery, not activity. The headline metric is verified closed tickets per week. Commits, hours, and lines of code are supporting evidence at best; they are not velocity.

The original Claude Code source remains in `skills/yegor-velocity/`. This Codex port keeps the behavior and removes Claude-specific wording.

## What Counts

Count a ticket as velocity only when:

- The described work has a delivered outcome: code merged, doc shipped, decision recorded, or issue answered.
- The reporter or responsible verifier accepted the outcome, or the project explicitly allows self-verification for that ticket type.
- The closure comment names the deliverable: commit, PR, document, decision, proof, or follow-up.

Do not count:

- PRs merged without a closed ticket.
- Tickets closed with no deliverable.
- Duplicate, spam, or pure housekeeping closures.
- Self-closed work when the project requires reporter verification.

## Progress Review

When asked about progress:

1. Pick the time window: week, month, sprint, or project-specific cadence.
2. Count closed tickets in that window.
3. Filter out non-delivery closures.
4. Check closure comments for named deliverables.
5. Compare open-ticket growth against closed-ticket flow.
6. Lead with the closed-ticket count, then explain qualifiers.

Useful signals:

- 0 verified closures in a week means no verified delivery, even if many commits happened.
- Many commits per closure suggests churn, oversized tickets, or coding without ticket discipline.
- Open tickets growing faster than closures means the project is accumulating debt.

## Closure Comment Shape

Prefer:

```text
Closed by <commit/PR/doc link>. Outcome: <one sentence naming what changed>.
```

Reject vague closures such as "done", "fixed", or a silent close with no artifact.

## Scorecard

Closed tickets stay the headline. Use a small scorecard only when the headline hides important context:

- Tickets closed: validated by deliverable-naming close comments.
- PRs merged: validated by the project's merge gate, not self-blessing.
- Bugs fixed: validated by a proving test or repro evidence.
- Bugs reported: validated by complaint shape, not duplicates.
- Cost of PR: open-to-merge time; watch the trend, not one datapoint.
- Docs published: validated by a real document or section, not a stub.
- Reviews done: validated by substantive findings or explicit approval.

Every count needs a validator. Raw counts invite gaming.

## Planning Use

For forecasts, use measured closure cadence:

- "At the current rate of N verified closures per week, M open tickets implies roughly M / N weeks."
- Include the as-of date and window used.
- Do not promise based on the size of the spec alone.

Route deeper forecasting to `yegor-projections` when that Codex port is available.

## Pitfalls

- Closure inflation: closing tiny or premature tickets to make the graph look good.
- Hidden work: coding without tickets, which makes real progress invisible.
- Counting commits as progress.
- Treating duplicate closures as delivery.
- Letting old tickets stay open forever instead of closing with a partial deliverable, escalation, or documented non-result.

## Source References

Use the original Claude skill for deeper details until all Codex ports exist: `skills/yegor-velocity/SKILL.md`. For rationale, read `research/philosophy_06_velocity_closed_tickets.md` and `research/philosophy_18_multi_metric_velocity.md`.
