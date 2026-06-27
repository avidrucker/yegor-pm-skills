# Philosophy 03 — Micro-tasking (≤1 hour per task)

> **Why this doc exists:** distill the XDSD/Zerocracy rule that every task must be small enough to finish in roughly an hour, and give actionable splitting rules Claude can apply.
>
> **Primary sources:**
> - Yegor Bugayenko, *Incremental Billing* (2014-10-21) — https://www.yegor256.com/2014/10/21/incremental-billing.html
> - Yegor Bugayenko, *How XDSD Is Different* (2014-04-17) — https://www.yegor256.com/2014/04/17/how-xdsd-is-different.html
> - XDSD methodology principles (xdsd.org)
> - Talk: *eXtremely Distributed Software Development* (DevTernity 2016)

---

## The principle (paraphrased)

Every task is sized so that it can be completed in under an hour, with a default budget around 30 minutes. The budget is fixed at task creation and does not change. The work is binary: done or not done. There are "thousands of tasks" in a mid-size project rather than dozens of large ones.

Yegor's framing in *Incremental Billing*: fine-grained sizing gives few-minutes progress granularity, eliminates waste from unproductive hours, and keeps motivation high because closure happens many times per day rather than once a sprint.

## Why it works

- **Forced decomposition.** You cannot start work on a 4-hour blob without first deciding how to chop it. The chopping *is* design.
- **Frequent dopamine.** Every ~1 hour you close something. Solo developers in particular need this — there's no one else to high-five.
- **Honest estimation.** A 30-minute budget is hard to wildly overshoot without noticing. A 2-week budget is trivially overshot. Constraints expose reality.
- **Easy resume.** A 1-hour task can be picked up after weeks away and finished in one sitting. A 1-week task requires re-loading context.
- **Bounded blast radius.** A single broken micro-task affects one increment. A broken 2-day task affects everything that branched off it.

## Canonical rules

### Sizing

- **Hard ceiling: 60 minutes.** A task must be doable in 1 hour of focused work.
- **Default: 30 minutes.** Use 30 as the starting estimate; only push to 60 when there's a clear reason.
- **Budget is fixed.** Once a task has a budget, the budget does not move. If reality exceeds it, you split (see below).

### When a task exceeds budget

1. Stop work.
2. Identify the unfinished sub-problem(s).
3. Create one or more puzzle comments / sub-tickets for the leftover work.
4. Close the original task with the partial deliverable.

This is the natural pairing with [Puzzle Driven Development](./philosophy_01_pdd_puzzle_driven_development.md): puzzles are how leftover work escapes a busted budget without rolling the original ticket.

### Splitting heuristics (when creating tasks)

Apply these before opening a ticket:

1. **One concern per ticket.** If the title has "and" or a comma listing two changes, split.
2. **One file, ideally.** If the work spans 3+ files, ask: is each file's change a complete sub-deliverable on its own? If yes, split per file.
3. **One commit-worthy unit.** If the work produces 5+ commits, it should have been 5 tickets.
4. **One test added/passing.** A good micro-task ships with one new test (or one updated test). If you need many tests, split.

## Actionable guidelines

### How Claude should use this when helping

- **Before starting work**, estimate. Speak the estimate out loud: "I think this is ~25 minutes." If you find yourself saying "1–3 hours" → propose a split *before writing any code*.
- **When the user says "let's just add X, Y, and Z"** — push back: "That's three tickets. Want me to open them as three?"
- **When work overruns**, stop and split rather than push through. Speak the overrun: "This is taking longer than the 30min budget — the unresolved piece is X. I'll close the current ticket with what's done and file a new ticket for X."
- **Calibrate.** Once a week, review your estimates vs reality. Are you systematically underestimating? Adjust default upward (but never past 60).

### For a solo developer

- The micro-task acts as your *commitment device*. You committed to finishing it in 30 minutes; if you don't, that's data.
- Pair micro-tasks with a visible counter ("closed today: 4"). Velocity becomes legible without ceremony.
- Don't fake it. A "closed" ticket that doesn't actually deliver something is worse than an honest 1-hour overrun.

## Pitfalls

- **Salami-slicing.** Cutting a coherent task into 6 trivial pieces just to hit the metric is gaming the system. Each ticket must be a meaningful, independently-mergeable deliverable.
- **Estimate inflation.** "I'll budget 60 minutes to be safe" defeats the discipline. Default 30, justify 60.
- **Treating discovery as a task.** "Figure out how X works" is not a micro-task; it's a spike. Spikes have their own track (small, time-boxed, output is a *document* that informs real tickets).
- **Ignoring the budget after creation.** The budget exists to be respected. If you routinely blow through it, the *estimation process* is broken, not the budgets.

## Integration with the other philosophies

- Micro-tasking + PDD = leftover work goes into puzzles, never into "we'll figure it out later."
- Micro-tasking + BDD = each ticket is a small, well-shaped complaint.
- Micro-tasking + closed-tickets-velocity = the metric has meaning because each closed ticket is a comparable unit.

## One-line summary for Claude

> Cap every task at ~60 minutes (default 30). Budget is fixed at creation. If overrun, stop, split into puzzles, close the original with what's done.
