---
name: yegor-microtasks
description: Cap every task at ~60 minutes (default 30). Budget is fixed at creation. If overrun, stop, split leftover work into @todo puzzles, close the original with what's done. Use when estimating, planning, starting work, or when a task is running longer than budgeted.
version: 0.1.0
last_reviewed: 2026-05-23
---

# Yegor Micro-tasking

Cap every task at ~60 minutes (default 30). Budget is fixed at creation. If overrun, stop, split leftover work into puzzles, close the original with what's done.

## Triggers
- About to estimate work
- About to start a task
- Realizing a task is taking longer than budgeted
- Reviewing the backlog and seeing big-looking tickets

## The sizing rule
- **Hard ceiling: 60 minutes.**
- **Default: 30 minutes.**
- **Budget is fixed at creation.** Once a task has a budget, it does not move.

## Splitting heuristics (apply BEFORE opening a ticket)
1. **One concern per ticket.** If the title contains "and" or comma-separated changes → split.
2. **Ideally one file.** Spanning 3+ files → ask: is each file's change a complete sub-deliverable? If yes, split per file.
3. **One commit-worthy unit.** If the work would produce 5+ commits → should have been 5 tickets.
4. **One test added or passing.** Needing many new tests → split.

## When a task exceeds budget
1. Stop work.
2. Identify the unfinished sub-problem(s).
3. Create puzzle comments (`@todo #N:Mm`) for the leftover work.
4. Close the original task with the partial deliverable.

## Rules for Claude

**Before starting work:**
- Estimate out loud: "I think this is ~25 minutes."
- If the estimate exceeds 60 minutes, propose a split BEFORE writing any code.

**When the user says "let's just add X, Y, and Z":**
- Push back: "That's three tickets. Want me to open them as three?"

**When work overruns:**
- Stop and split rather than push through. Announce: "This is taking longer than the 30min budget. The unresolved piece is X. I'll close the current ticket with what's done and file a new ticket for X."

**Weekly calibration:**
- Compare estimates to reality. Systematic underestimation → adjust default upward, but never past 60.

## Pitfalls
- Salami-slicing: cutting coherent work into 6 trivial pieces to game the metric. Each ticket must be a meaningful, independently mergeable deliverable.
- Estimate inflation: "I'll budget 60 minutes to be safe" defeats the discipline. Default 30, justify 60.
- Treating discovery as a task: "Figure out how X works" is a spike, not a micro-task. Spikes produce documents that inform real tickets.
- Ignoring the budget after creation: the budget exists to be respected. Routinely blowing past it means the *estimation process* is broken, not the budgets.

## Cross-references
- `yegor-pdd` — overrun's leftover work goes into `@todo` puzzles.
- `yegor-velocity` — small tickets → cleaner closure cadence.
- `yegor-architect` — architect's job is to decompose into ≤60min units for couriers.

## Deep reference

`research/philosophy_03_microtasks_microtasking.md`
