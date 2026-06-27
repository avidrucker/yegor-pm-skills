# Philosophy 18 — Multi-Metric Velocity: The Scorecard & Anti-Gaming Validators

> **Why this doc exists:** capture Yegor's argument that the problem with
> developer metrics was never *measuring* — it was measuring the wrong thing
> (lines of code) — and his multi-dimensional alternative, then translate it for
> a solo developer working with AI agents, where every dimension is derivable
> from git + the tracker the agent already operates. Enhances `yegor-velocity`,
> which kept a single headline number (closed tickets).
>
> **Primary source:**
> - Yegor Bugayenko, *To Measure or Not to Measure: Individual Performance Metrics* (2020-06-23) — https://www.yegor256.com/2020/06/23/individual-performance-metrics.html
> - Related: *Hits-of-Code* (2014-11-14) — https://www.yegor256.com/2014/11/14/hits-of-code.html (why SLoC misleads)

---

## The principle (paraphrased)

Most "measure developers" debates throw out measurement entirely because the
common metric — lines of code — is actively harmful (it shrinks on a good
refactor and inflates from vendored code). Yegor's point: the metric was wrong,
not the act of measuring. Replace the one bad number with a **scorecard** of
several honest dimensions, each with a validator that resists gaming:

- features delivered, PRs merged, bugs fixed, bugs reported, releases shipped,
  uptime/MTBF, **cost-of-PR** (time-to-merge), docs published, mentee/review
  results.

The headline for these skills remains **closed tickets per week** (philosophy_06);
the scorecard *supplements* it when one number hides the story (a slow week of
hard tickets reads identically to a lazy week).

## Why it works

- **One number is easy to misread.** Closed-count alone can't distinguish "few
  but hard" from "lazy", or "many but trivial" from "productive". A few extra
  dimensions disambiguate.
- **Every dimension is already in the data.** PRs merged, merge timestamps, bug
  labels, doc paths, review events — all live in git and the tracker. No new
  instrumentation, and an agent can compute the whole scorecard.
- **Validators keep counts honest.** A raw count invites gaming (split tickets to
  inflate "closed"; open trivial bugs to inflate "reported"). Pairing each count
  with a validator — most reduce to "a *second actor* validated it" — turns the
  metric from a vanity number into evidence. This is the no-self-blessing rule
  (philosophy_11) applied to measurement.

## The scorecard

| Dimension | Source | Anti-gaming validator |
|---|---|---|
| Tickets closed (headline) | tracker | closure names a deliverable; `closed_by` = reporter |
| PRs merged | git/host | merged via the gate, not self-merged |
| Bugs fixed | tracker label | linked to a test that failed before the fix |
| Bugs reported | tracker label | a valid complaint, not a duplicate |
| **Cost-of-PR** = open→merge time | host timestamps | lower better; a long tail flags stuck/oversized work |
| Docs published | git docs paths | a real doc/section, not a stub |
| Reviews done | host review events | substantive findings/approval, not rubber-stamp |

**Cost-of-PR is the highest-signal addition.** It's a pure timestamp subtraction,
and a *growing* Cost-of-PR is an early warning that work is sprawling or stuck —
visible before the closed-count drops. Track the trend, not a single value.

## Canonical rules

- **Closed tickets stay the headline** — the scorecard supplements, never
  replaces.
- **Every count needs a validator** — usually "a second actor confirmed it".
- **All dimensions are git/tracker-derivable** — no new instrumentation.
- **Watch Cost-of-PR's trend** — a rising open→merge time is an early stuck/sprawl
  signal.
- **Don't dilute** — bring in extra dimensions only when the single number hides
  something.

## Translating for solo + AI work

- **The agent computes the scorecard.** Counts and timestamps come from `gh`/git;
  the agent assembles the dashboard on request.
- **Lead with the headline, escalate to dimensions on demand.** "Closed 4 this
  week" first; "but Cost-of-PR doubled and three were hard bugs" only when the
  single number would mislead.
- **Validators map onto existing discipline.** `closed_by != opener` is the
  reporter-closes rule (philosophy_02); merged-by-gate is the merge gate
  (philosophy_11); bug-fixed-needs-a-proving-test is the warranty rule
  (philosophy_16). The scorecard reuses gates you already have.

## Pitfalls

- **Raw counts without validators** — invites gaming (ticket-splitting,
  trivial-bug-spam).
- **Replacing the headline** — a seven-column dashboard nobody reads beats no
  metric, but the close-rate is still the spine.
- **Reading Cost-of-PR pointwise** — one slow PR isn't a signal; the trend is.
- **Re-introducing LOC** — the original sin; lines are not a dimension here.

## Integration with the other philosophies

- + [Velocity](./philosophy_06_velocity_closed_tickets.md): the headline this
  scorecard supplements.
- + [SIMBA](./philosophy_13_simba_wip_caps_evidence.md): "every count needs a
  validator" is "every claim links to evidence".
- + [Merge gate](./philosophy_11_merge_gate_readonly_master.md): the validators
  are no-self-blessing applied to metrics.
- + [Projections](./philosophy_14_projections_no_estimates.md): the measured
  close-rate is exactly what a projection forecasts from.

## One-line summary for Claude

> Keep closed-tickets-per-week as the headline, but supplement it with a small
> git/tracker-derived scorecard — PRs merged, bugs fixed/reported, Cost-of-PR
> (open→merge time), docs — where every count carries an anti-gaming validator
> (usually "a second actor confirmed it"). Cost-of-PR's rising trend is the
> earliest stuck/sprawl warning.
