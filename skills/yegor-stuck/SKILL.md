---
name: yegor-stuck
description: What to do when you're blocked, stuck, or tempted to grind heroically or fabricate a fix. The cut-corners protocol from Yegor Bugayenko — your duty is to REVEAL the problem, not heroically conceal it. An escalating ladder of honest, principled ways to stop being stuck (block, demand docs, reproduce-as-skipped-test, prove-absent, disable-and-ship) instead of thrashing, plus the No-Obligations rule for stale in-progress work (idle past a threshold → drop or re-scope, don't hold the slot). Use when work is impossible/too costly, when you've been grinding on the same problem, when a ticket has gone quiet for days, or when about to hack around a blocker.
version: 0.2.0
last_reviewed: 2026-06-26
---

# Yegor Stuck — Cut Corners, Don't Be a Hero

When a task turns out to be impossible, too costly, or blocked, your job is **not** to heroically grind until it works, and **not** to fabricate a fix that papers over the problem. Your job is to **reveal the problem honestly** and take the cheapest principled exit.

> "Production errors are not programmers' mistakes; **delayed and hidden tickets are.**" Being professional doesn't mean you can fix anything — it means you're honest about what you can't.

## Triggers
- You've been grinding on the same problem for a while with no progress.
- A task is turning out to be much bigger/harder than its estimate.
- You're blocked on something outside your control (an upstream answer, another ticket, a flaky external system).
- You're tempted to: fake a passing test, swallow an error, hardcode a value, comment out the assertion, or claim "done" on something that isn't.
- You can't reproduce a reported bug.

## The cut-corners ladder (cheapest principled exit first)

Take the **lowest rung that honestly applies**. Each rung is a legitimate, visible, trackable way to stop being stuck — not a hack.

1. **Block and pause.** Create an explicit blocking dependency on the ticket: "blocked by #N / waiting on X." Stop work on it; pick up the next unblocked item. The block is visible, not hidden.
2. **Demand documentation.** If you're stuck because the requirement/behavior is undefined, don't guess — file a question (as a ticket) and demand the missing spec. The ambiguity is the blocker, and it's now someone's job to resolve.
3. **Reproduce as a skipped failing test, then move on.** If it's a real bug you can reproduce but can't fix now, capture it as a **disabled/`@skip` test that proves the bug**, file the complaint, and move to the next task. The bug is now pinned down and tracked, not lost.
4. **Prove-absent and close.** If you **cannot reproduce** the reported problem, write a **passing test that proves the code behaves as designed**, attach it to the ticket as evidence, and close with "can't reproduce — here's the test showing current behavior." You've converted a vague complaint into a documented fact.
5. **Disable the feature and ship.** If the feature is broken and can't be fixed in budget, **disable it**, release the rest, and file a ticket to re-enable. A shipped product minus one feature beats a blocked product.

**Refusing to do the work at all is the last resort** — only when no rung above applies.

## Stale work — the No-Obligations rule

Taking a ticket is not a promise to finish it. The honest counterpart is that an item which has sat **in progress, idle, past a threshold** (Yegor's default: ~10 days) is no longer really being worked — it's holding a slot open and pretending to be progress. The rule: **a stale in-progress item gets dropped or re-scoped, not silently kept.**

- **Detect it.** Flag any in-progress ticket/branch with no closing deliverable and no activity for N days (≥10 as a default; shorter for fast solo loops). The signal is *time since last real movement*, not time since opened.
- **Then take a rung.** A stale item is just a quiet blocker — apply the ladder: block it (rung 1), demand the missing spec (rung 2), pin it as a skipped test (rung 3), or, if it no longer earns its slot, **drop it** (unassign / move back to the backlog) so something live can take its place.
- **Don't fake activity to keep it alive.** A token commit to reset the clock is the same dishonesty as faking green — the staleness is real information; surface it.

This pairs with WIP caps (`yegor-simba`): a stale item occupying a capped slot is exactly what must be shed before new work can start.

## The one corner you must NEVER cut

**Unit tests.** Every other corner on the ladder is fair game under pressure; skipping tests is not. (A genuine production-down emergency is the only exception — and then the disabled test is a debt repaid in the *very next* task. See `yegor-unit-tests`.)

## How Claude should use this
- **When you notice yourself thrashing** (repeated failed attempts, growing scope, "just one more try"), stop and announce which rung you're taking: "I'm blocked on X — taking rung 1, filing the block and moving on."
- **Never silently absorb a blocker.** If you can't do what was asked, say so and pick a rung. Don't quietly substitute an easier task and call it done.
- **Never fabricate green.** Faking a passing test, swallowing an exception, or hardcoding an expected value to make something "pass" is the exact failure mode this skill exists to prevent. A red/skipped test that tells the truth beats a green one that lies.
- **Reveal early.** The cost of a revealed blocker is low; the cost of a concealed one compounds. Surface it the moment you're confident you're stuck, not after an hour of grinding.

## Pitfalls
- **Hero mode.** Grinding silently to avoid admitting you're stuck. The delay is the real failure, not the difficulty.
- **Fake-it-to-green.** Bending the test/code to fake success. Cutting *this* corner is forbidden.
- **Silent scope-swap.** Quietly doing an easier adjacent thing instead of the blocked task, then reporting progress.
- **Skipping the rung's artifact.** Every rung produces a visible artifact (a block, a question ticket, a skipped test, a proof test, a disable + re-enable ticket). No artifact = the corner was cut dishonestly.

## Cross-references
- `yegor-microtasks` — overrun is a trigger to stop and split, not to grind; this skill is what "stop" looks like.
- `yegor-bdd` — rungs 3 & 4 produce the complaint-as-test (failing/disabled, or proving-absent).
- `yegor-pdd` — the leftover work from a cut corner becomes a `@todo` puzzle / ticket.
- `yegor-tickets` — every rung's artifact lives in the tracker, not in your head.
- `yegor-unit-tests` — the one corner you can't cut; the emergency disable-then-repay protocol.
- `yegor-simba` — WIP caps; a stale in-progress item is what must be shed to free a capped slot.
- `yegor-velocity` — an idle item produces no closures; staleness is the absence of the metric.

## Deep reference
- `research/philosophy_10_stuck_cut_corners.md`
- `research/philosophy_19_zero_tolerance_and_stale_tickets.md` (the No-Obligations stale-work rule)
