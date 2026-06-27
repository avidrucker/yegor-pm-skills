---
name: yegor-projections
description: Forecast from measured delivery rate, not from a spec-derived guess. From Yegor Bugayenko's "How to Estimate Software Cost" — up-front estimates are dishonest because software has no fully-knowable finish line; instead make projections from observed velocity ("we close ~N tickets/week, ~M remain, so ~M/N weeks") and re-issue them as the rate is re-measured. A projection is a falsifiable forecast with an as-of date, not a promise. Use when asked "how long will this take", when tempted to estimate a whole feature up front, or when re-forecasting a roadmap.
version: 0.1.0
last_reviewed: 2026-06-26
---

# Yegor Projections — Forecast From Velocity, Not From Vibes

When someone asks "how long will this take?", the honest answer is not a number pulled from staring at a spec — it's a **projection from measured delivery rate**. You don't know how long the work is; you *do* know how fast tickets have actually been closing. Divide one by the other.

> An estimate is a promise about an unknowable future. A projection is a forecast from observed data, stamped with an as-of date and revised every time the data changes. Quote the projection, never the promise.

## Triggers
- Asked "how long will this take?" / "when will it be done?" / "how much will it cost?"
- Tempted to estimate a whole feature or roadmap up front from the spec.
- Re-forecasting a roadmap, or a deadline conversation.
- A stakeholder wants a date and you only have a backlog and a spec.

## Core rules

- **Don't estimate the whole from the spec.** A spec is never complete enough to estimate honestly — the unknowns are exactly what you haven't specced. Refuse the "stare at the requirements and guess a date" move.
- **Project from measured velocity.** The forecast is arithmetic, not intuition: `weeks ≈ open tickets ÷ tickets-closed-per-week` (use the recent measured rate from `yegor-velocity`). No velocity history yet? Then you can't project — say so, and gather a week or two of data first.
- **A projection has an as-of date and a range.** "As of this week, at ~3 closed/week with ~18 open, that's ~6 weeks — re-checked weekly." Not a single hard date. The date moves as the rate and the backlog move; that's a feature, not a failure.
- **Re-issue the projection as data arrives.** Every time velocity is re-measured or the backlog changes, the forecast updates. A projection is a living number, not a one-time commitment.
- **The micro-estimates stay small and bounded.** Individual tasks still get ≤60min estimates (`yegor-microtasks`) — those are checkable and short-horizon. Projections are for the *aggregate*; never inflate a micro-estimate into a whole-project promise.

## For solo / AI-augmented work

- **You already have the data.** Closed tickets per week is the velocity signal (`yegor-velocity`); the open count is the backlog. The projection is one division an agent can compute from the tracker — no guessing required.
- **Don't let the agent promise a date.** When asked "how long", Claude should project from the rate, not assert a confident deadline. "At the current close rate this is ~N weeks as of today" — with the inputs shown — beats "about two weeks" pulled from nowhere.
- **Show the arithmetic.** A projection is trustworthy because it's checkable: state the open count, the rate, and the division. The reader can verify it and watch it move.
- **Re-project, don't defend.** If reality diverges, the answer is a fresh projection from the new rate — not defending the old number. The honesty is in revising.

## How Claude should use this
- **When asked "how long":** project, don't promise. "You've got ~18 open and you're closing ~3/week, so ~6 weeks as of today — I'll re-check as the rate moves." Never a bare date from the spec.
- **When there's no velocity data:** refuse to fake one. "There's no close-rate history yet, so any date would be a guess. Let's measure a week or two first, then I can project."
- **When re-forecasting:** recompute from the latest rate and backlog, and say what changed. "Rate dropped to ~2/week and scope grew to ~22 open, so the projection moved from 6 to ~11 weeks."

## Pitfalls
- **Spec-derived dates.** Quoting a deadline from reading the requirements instead of from the measured rate.
- **Single hard dates.** A projection is a range with an as-of date; a bare date hides its own uncertainty.
- **Stale projections.** Quoting last month's forecast after the rate changed — re-issue it.
- **No-data projections.** Producing a number when there's no velocity history; say "can't project yet" instead.
- **Inflating micro-estimates.** Turning a 30-minute task estimate into a whole-feature promise.

## Cross-references
- `yegor-velocity` — supplies the measured close-rate that every projection divides by.
- `yegor-microtasks` — the short-horizon ≤60min estimates; projections are the aggregate forecast, not these.
- `yegor-spikes` — when the backlog itself is unknown, a spike sizes it before any projection is possible.
- `yegor-tickets` — the projection and its inputs are written in the tracker, not promised verbally.

## Deep reference
`research/philosophy_14_projections_no_estimates.md`
