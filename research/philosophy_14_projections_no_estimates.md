# Philosophy 14 — Projections, Not Estimates

> **Why this doc exists:** capture Yegor's argument that up-front software
> estimates are dishonest and should be replaced by *projections* from observed
> delivery rate, and translate it for a solo developer working with AI agents,
> where the agent can compute the projection directly from the tracker instead
> of asserting a confident deadline.
>
> **Primary sources:**
> - Yegor Bugayenko, *How to Estimate Software Cost* (2015-06-02) — https://www.yegor256.com/2015/06/02/how-to-estimate-software-cost.html
> - Yegor Bugayenko, *Shift-M/44* (2020) — projections vs estimates — https://www.yegor256.com/shift-m/2020/44.html
> - Related: *Velocity* (philosophy_06) — supplies the measured rate.

---

## The principle (paraphrased)

Asking "how long will this take?" or "how much will it cost?" up front assumes a
finish line you can fully see from the start. Software doesn't have one — the
unknowns are precisely the parts you haven't specified yet, so an estimate
derived from the spec is a guess dressed as a commitment.

The honest alternative is a **projection**: don't estimate the unknowable size of
the work; measure the *rate* at which work is actually completing, and divide.
If the team closes ~3 tickets per week and ~18 remain, the projection is ~6
weeks — *as of today*, at *this* rate, with *this* backlog. Re-measure the rate,
re-issue the projection. Yegor frames the better question as not "how long" but
"how much working software per dollar (or per week)" — a rate, which you can
observe, rather than a duration, which you can't.

## Why it works

- **It forecasts from data you have, not data you don't.** You cannot know the
  total work, but you can measure the close rate. A projection is built entirely
  from observed quantities (open count, recent velocity), so it's checkable.
- **It's falsifiable and self-correcting.** A projection carries an as-of date and
  updates when reality diverges. There's no "the estimate was wrong" — there's
  just a newer projection from a newer rate.
- **It removes the dishonesty.** A spec-derived date pretends to certainty it
  doesn't have. A projection wears its uncertainty on its sleeve (a range, an
  as-of date) and is therefore trustworthy.

## Canonical rules

- **Don't estimate the whole from the spec** — the unknowns are what you haven't
  specced.
- **Project from measured velocity** — `weeks ≈ open ÷ closed-per-week`, using the
  recent measured rate.
- **A projection has an as-of date and a range** — not a single hard date.
- **Re-issue as data arrives** — the forecast is a living number.
- **No velocity history → can't project** — say so; gather a week or two first.
- **Keep micro-estimates separate** — ≤60min task estimates (philosophy_03) are
  short-horizon and checkable; don't inflate one into a whole-project promise.

## Translating for solo + AI work

- **The data is already in the tracker.** Closed-per-week (philosophy_06) is the
  rate; the open count is the backlog. The projection is one division — an agent
  computes it, no intuition required.
- **Don't let the agent promise a date.** "At the current close rate this is ~N
  weeks as of today" — with inputs shown — beats a confident "about two weeks"
  from nowhere.
- **Show the arithmetic.** A projection earns trust by being checkable: state the
  open count, the rate, and the division so the reader can verify and watch it
  move.
- **Re-project, don't defend.** When reality diverges, produce a fresh projection
  from the new rate rather than defending the old number. The honesty is in
  revising.

## Actionable guidelines

### How Claude should use this

- **When asked "how long":** project, don't promise — "~18 open, closing ~3/week,
  so ~6 weeks as of today; I'll re-check as the rate moves." Never a bare
  spec-derived date.
- **When there's no velocity data:** refuse to fake one — "no close-rate history
  yet, so any date is a guess; let's measure a week or two first."
- **When re-forecasting:** recompute from the latest rate/backlog and say what
  changed.

## Pitfalls

- **Spec-derived dates** — a deadline from reading requirements, not from the
  measured rate.
- **Single hard dates** — hiding uncertainty instead of giving a range + as-of
  date.
- **Stale projections** — quoting an old forecast after the rate changed.
- **No-data projections** — inventing a number with no velocity history.
- **Inflating micro-estimates** — turning a 30-minute task estimate into a
  whole-feature promise.

## Integration with the other philosophies

- + [Velocity](./philosophy_06_velocity_closed_tickets.md): supplies the measured
  close-rate every projection divides by.
- + [Microtasks](./philosophy_03_microtasks_microtasking.md): the short-horizon
  ≤60min estimates; projections are the aggregate forecast, not these.
- + Spikes (`yegor-spikes`): when the backlog itself is unknown, a spike sizes
  it before any projection is possible.
- + [Tickets](./philosophy_04_tickets_ticket_as_conversation.md): the projection
  and its inputs are written down, not promised verbally.

## One-line summary for Claude

> Don't quote a date from the spec — project from the measured rate: open tickets
> ÷ tickets-closed-per-week, with an as-of date and a range, re-issued whenever
> the rate or backlog moves. No velocity history yet means you can't project —
> say so and measure first.
