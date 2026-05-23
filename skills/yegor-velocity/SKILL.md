---
name: yegor-velocity
description: Velocity is closed tickets per week, full stop. Commits don't count. Hours don't count. Lines don't count. Reporter verifies; closure comment names the deliverable. Use when reviewing progress, answering "how's it going", or measuring productivity.
version: 0.1.0
last_reviewed: 2026-05-23
---

# Yegor Velocity = Closed Tickets

Velocity is closed tickets per week, full stop. Commits don't count. Hours don't count. Lines don't count. Reporter verifies; closure comment names the deliverable.

## Triggers
- User asks "how's the project going?"
- Weekly review
- Reviewing a stale project
- Tempted to celebrate based on commits or LOC

## What counts as "closed"
1. The work described is delivered (code merged, doc shipped, decision recorded).
2. The reporter (or yourself acting as reporter) verified the deliverable.
3. The closure comment names what was delivered (commit hash, doc location, etc.).

## What does NOT count
- PR merged without a closed ticket.
- Ticket closed with no deliverable.
- Self-closed without verification.
- Duplicate-marked closures (housekeeping, not delivery).

## Closure rules (Yegor 2025)
- **Reporter closes.** Solver finishes → asks reporter to verify → reporter closes.
- **Exceptions:** obvious duplicates, direct-answer questions, "won't fix" with documented reason.
- **Never close to inflate the metric.** Creates rework debt; both ends-of-week bad.

## Weekly velocity check

```
closed_this_week = count of issues where state=closed
                   AND closed_at in this week
                   AND has a deliverable-naming closure comment
commits_this_week = count of commits this week
ratio = commits / max(closed, 1)
```

| Ratio | Signal |
|---|---|
| 2–6 commits per closed ticket | Normal — small tickets shipping cleanly. |
| > 10 | Churn — committing without closing. Investigate sizing or working without tickets. |
| 0 closed | Critical — a week of work with no verified deliverable. Review honestly. |

## Closure comment format

> Closed by [link to commit/doc/decision]. Outcome: [one sentence].

Bad closures: "done", "fixed", just clicking the close button.

## Rules for Claude

**When the user asks "how's progress?":**
- Lead with closed-ticket count over the relevant window.
- Not commit count, not LOC.

**When proposing work:**
- Frame as "this will close ticket #N." Make the unit visible.

**When the user is about to commit without a ticket:**
- Ask: "What ticket does this close? If none, want to open one first?"

**When reviewing a stale project:**
- Count open vs closed over the last month. If open is climbing faster than closed → the project is accumulating debt, not progressing.

## Solo developer rituals
1. **No closure, no progress.** A productive-feeling day with 0 closures = no verified delivery.
2. **Closure is the dopamine hit.** Schedule sessions to aim at a closure.
3. **The graph is the report.** A weekly bar chart of closures beats any written status update.

## Pitfalls
- Closure inflation (premature close, trivial split). Symptom: closed tickets that get reopened, or closures with no deliverable comment.
- Open-forever tickets (>30 days → close with partial deliverable or escalate to a parent epic).
- Hidden work (coding without tickets). The metric only works if all real work is filed.
- Counting noise (duplicates, spam). Filter to "real" closures with deliverable comments.

## Cross-references
- `yegor-microtasks` — small tickets close more often, cleaner velocity trend.
- `yegor-tickets` — if it's not a ticket, it can't be counted.
- `yegor-bdd` — the reporter who validates closure was the one who filed the complaint.

## Deep reference

`research/philosophy_06_velocity_closed_tickets.md`
