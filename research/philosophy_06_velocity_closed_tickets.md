# Philosophy 06 — Velocity = Closed Tickets (Not Commits, Not Hours)

> **Why this doc exists:** distill the XDSD rule that productivity is measured in closed deliverables, and give Claude clear rules for what counts and what doesn't.
>
> **Primary sources:**
> - Yegor Bugayenko, *Five Principles of Bug Tracking* (2014-11-24) — https://www.yegor256.com/2014/11/24/principles-of-bug-tracking.html
> - Yegor Bugayenko, *Let the Bug Reporter Have the Last Word* (2025-04-24) — https://www.yegor256.com/2025/04/24/dont-close-their-tickets.html
> - Yegor Bugayenko, *How XDSD Is Different* (2014-04-17) — https://www.yegor256.com/2014/04/17/how-xdsd-is-different.html
> - XDSD canonical principle: "Everyone gets paid for verified deliverables" (xdsd.org)
> - Talk: *eXtremely Distributed Software Development* (DevTernity 2016), takeaway @ 19:50

---

## The principle (paraphrased)

A project's progress is measured by the count of *closed tickets*, not by commits, lines of code, hours worked, or status reports. A closed ticket is a verified deliverable — work that has been written, reviewed, and accepted by the reporter. Nothing else counts.

The XDSD economic model — pay only for closed tasks — codifies this. If a task isn't closed, the developer earns nothing for it, regardless of effort. The principle survives outside the payment context as a measurement principle.

## Why it works

- **Resistant to gaming.** Commits can be inflated; LOC can be padded; hours can be exaggerated. A closed ticket requires *the reporter's acceptance* — it's externally verified.
- **Aligns with user-visible outcomes.** A closed ticket usually corresponds to something a user can see or test. A merged commit is a step toward an outcome, not the outcome itself.
- **Forces decomposition.** If your unit of progress is "closed ticket," you'll naturally make tickets small enough to close (→ [micro-tasking](./philosophy_03_microtasks_microtasking.md)).
- **Brutally honest for solo devs.** Counting commits flatters. Counting closed tickets exposes churn. If you committed 40 times and closed 0 tickets, you didn't ship.
- **Cumulative & comparable.** Closed-ticket counts trend cleanly over weeks/months. Hours don't (sick days, distractions). Commits don't (refactors, reverts).

## Canonical rules

### What counts as "closed"

A ticket is closed when:

1. The work it described is delivered — code merged, doc shipped, decision recorded.
2. The reporter (or, in solo case, yourself acting as reporter) has verified the deliverable.
3. The closure comment names *what* was delivered (commit hash, doc location, etc.).

### What does NOT count

- A PR merged without a corresponding closed ticket.
- A ticket closed with no deliverable ("won't fix" without justification counts as closed *only* if the won't-fix decision itself is the deliverable, with rationale).
- A self-closed ticket where you were both reporter and solver and skipped verification.
- A ticket closed as "duplicate" — that's housekeeping, not delivery (count duplicates separately).

### Closure rules (from Yegor, 2025)

- **The reporter closes.** Solver finishes, asks reporter to verify, reporter closes. This is the core trust mechanism.
- **Exceptions** (the solver may close):
  - Obvious duplicates.
  - Questions answered directly.
  - Intentional "won't fix" with documented reason.
- **Never close to make the metric look good.** Premature closure inflates velocity now and creates rework debt later — both bad.

## Actionable guidelines

### Weekly velocity check (Claude-runnable)

End of each week, compute:

```
closed_tickets_this_week = count of issues with state=closed AND closed_at in this week
commits_this_week = count of commits this week
ratio = commits_this_week / max(closed_tickets_this_week, 1)
```

Healthy ratios:

- **2–6 commits per closed ticket**: normal. Small tickets shipping cleanly.
- **>10**: churn signal. You're committing without closing. Investigate: are tickets too big? Are you working without tickets?
- **0 closed tickets**: critical signal. A week of work that produced no verified deliverable is a week to review honestly.

### Daily counter (for solo work)

- At end of each working session, count tickets closed today. Aim for ≥1.
- If you close 0 for two days running, re-read your active tickets and check whether they're sized correctly. The fix is almost always to split.
- Don't manufacture closures. The metric only works if every closure represents a real deliverable.

### Title every closure with the deliverable

Closure comments should follow the pattern:

> Closed by [link to commit / doc / decision]. Outcome: [one sentence].

Bad closures: "done", "fixed", just clicking the close button with no comment.

### How Claude should use this when helping

- **When the user asks "how's the project going?"**, lead with closed-ticket count over the relevant window, not commit count or LOC.
- **When proposing work**, frame it as "this will close ticket #N" — make the unit visible.
- **When the user is about to commit without a ticket**, ask: "What ticket does this close? If none, want to open one first?"
- **When reviewing a stale project**, count open vs closed over the last month. If open is climbing faster than closed, the project is accumulating debt, not progressing.
- **When the user wants to celebrate progress**, point to the closure trend over weeks. It's the cleanest, most honest measure.

### For a solo developer

The metric is your truth-teller. Specifically:

1. **No closure, no progress.** A productive-feeling day with 0 closures is a day that produced no verified delivery — recognize this honestly.
2. **Closure is the dopamine hit.** Schedule work so each session aims at a closure. If a session can't close a ticket, the ticket was too big.
3. **The graph is the report.** A simple weekly bar chart of closures is more useful than any written status update. The graph either trends up or it doesn't.

## Pitfalls

- **Closure inflation.** Closing tickets prematurely or splitting trivially just to bump the count. Symptom: closed tickets that get reopened, or closures with no deliverable comment.
- **Open-forever tickets.** The opposite — letting tickets linger. A ticket open >30 days should either be closed (with partial deliverable) or explicitly escalated to a parent epic.
- **Hidden work.** Coding without tickets. The closure metric only works if all real work is filed.
- **Counting noise.** Duplicates, spam, housekeeping closures. Filter the metric to "real" closures (closed with a deliverable comment).

## Integration with the other philosophies

- + [Micro-tasking](./philosophy_03_microtasks_microtasking.md): small tickets close more often → cleaner velocity trend.
- + [Ticket-as-conversation](./philosophy_04_tickets_ticket_as_conversation.md): if it's not a ticket, it can't be counted.
- + [BDD](./philosophy_02_bdd_bug_driven_development.md): the reporter who validates closure was the one who filed the complaint.

## One-line summary for Claude

> Velocity is closed tickets per week, full stop. Commits don't count. Hours don't count. Lines don't count. Reporter verifies, closure comment names the deliverable.
