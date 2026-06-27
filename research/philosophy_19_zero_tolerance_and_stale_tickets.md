# Philosophy 19 — Zero-Tolerance Quality Bar & the No-Obligations Stale-Work Rule

> **Why this doc exists:** capture two of Yegor's strictness rules — a
> zero-tolerance static-analysis gate (any single violation fails the build) and
> the No-Obligations principle (taking a task isn't a promise; stale work gets
> dropped, not held) — and translate them for a solo developer working with AI
> agents, where both reduce to cheap mechanical checks an agent can self-enforce.
> Enhances `yegor-merge-gate` (the quality bar) and `yegor-stuck` (stale work).
>
> **Primary sources:**
> - Yegor Bugayenko, *Strict Control of Java Code Quality* (2014-08-13) — https://www.yegor256.com/2014/08/13/strict-code-quality-control.html
> - Yegor Bugayenko, *Don't Aim for Quality, Aim for Speed* (2018-03-06) — https://www.yegor256.com/2018/03/06/speed-vs-quality.html
> - Yegor Bugayenko, *No Obligations* (2014-04-13) — https://www.yegor256.com/2014/04/13/no-obligations-principle.html

---

## Part 1 — The zero-tolerance quality bar (→ merge-gate)

Aggregate every static-analysis check you have and make the bar **binary**: any
single violation fails the whole build. No warnings-only mode, no severity
downgrade, no per-rule allowlist accumulating "known issues". Warnings are
errors.

It feels harsh, and developers resist it — but the alternative is worse. A gate
that lets "just one warning" through isn't a gate; it's a suggestion. Warnings
accumulate: a hundred suppressed ones become a backdrop nobody reads, and the
real defect hides among them. Predictability comes from the bar being absolute.

This dovetails with *Don't Aim for Quality, Aim for Speed* (philosophy_11's
sibling argument): put the developer and the gate in deliberate conflict. The
developer (or agent) optimizes purely for **speed** — close tickets fast — while
the **project's automated gate**, not the developer's conscience, enforces
quality. An uncompromising, zero-tolerance gate is exactly what lets you trust a
fast-moving agent: it can't lower quality even if it tries, because the bar is
binary and impartial.

For an agent the rule is one boolean: *did the linter/analyzer exit non-zero? →
reject.* No judgment call, no "is this warning important?" — non-zero means stop.

## Part 2 — No Obligations: stale work gets dropped (→ stuck)

Accepting a task is **not** a promise to deliver it. In Yegor's framing a worker
may decline or quietly stop on any task with no penalty — but after a threshold
of non-delivery (his default: ~10 days) the manager reassigns it, and incomplete
work delivers nothing. The deadline-by-staleness is the only accountability; no
status nagging in between.

Translated to the discipline these skills encode: an item that has sat **in
progress, idle, past a threshold** with no closing deliverable is not progress —
it's a held-open slot masquerading as work. The honest move is to **drop or
re-scope it**, not keep it on life support.

- The signal is *time since last real movement*, not time since the ticket was
  opened.
- A stale item is just a quiet blocker — apply the `yegor-stuck` ladder (block,
  demand spec, pin as a skipped test) or drop it back to the backlog.
- Faking activity (a token commit to reset the clock) is the same dishonesty as
  faking a green test (philosophy_10). The staleness is real information.

This pairs tightly with SIMBA's WIP caps (philosophy_13): a stale item occupying
a capped slot is precisely what must be shed before new work can start.

## Why they work

- **A binary bar can't rot.** The moment a gate admits exceptions, the exceptions
  compound; zero-tolerance is the only stable equilibrium.
- **Speed/quality separation lets the agent move fast.** If the gate is absolute,
  you don't have to trust the author's self-restraint — you trust the gate. That
  is what makes a fast agent safe.
- **Dropping stale work keeps the board honest.** A ticket that's been "in
  progress" for three weeks lies about the project's state; surfacing and
  shedding it restores the truth and frees a slot.

## Canonical rules

- **Zero-tolerance gate** — any single lint/static-analysis violation fails the
  build; warnings == errors; no allowlist.
- **Speed for the dev, quality for the gate** — the project enforces quality
  automatically, not the author's conscience.
- **Taking a task isn't a promise** — no penalty for stopping honestly.
- **Stale in-progress work is dropped or re-scoped** — idle past ~N days with no
  deliverable → shed it; don't fake activity to keep it alive.

## Translating for solo + AI work

- **The agent self-blocks on a dirty linter.** Before proposing a merge, the
  agent runs the analyzer; non-zero exit → it does not propose the merge. No
  human in the loop for the boolean.
- **The agent flags its own stale branches.** A branch idle past the threshold
  with no closing deliverable gets surfaced ("this has been open 12 days with no
  movement — drop it, or which rung do we take?"), not silently carried.
- **Don't game either gate.** No `// NOLINT` blanket suppressions to pass the
  bar; no empty commits to reset staleness.

## Pitfalls

- **Warning creep** — "just one warning" or a growing allowlist until the bar is
  fiction.
- **Trusting conscience over the gate** — leaving quality to the author instead of
  automating it.
- **Zombie tickets** — in-progress items idle for weeks, held open instead of
  dropped.
- **Faked activity** — token commits to reset the staleness clock.

## Integration with the other philosophies

- + [Merge gate](./philosophy_11_merge_gate_readonly_master.md): the
  zero-tolerance bar is the static-analysis half of the gate (rung 6 of the
  CI-maturity ladder, philosophy_12).
- + [Stuck](./philosophy_10_stuck_cut_corners.md): a stale item is a quiet
  blocker; the ladder is how you exit it honestly.
- + [SIMBA](./philosophy_13_simba_wip_caps_evidence.md): a stale item is what the
  WIP cap forces you to shed before starting new work.
- + [Velocity](./philosophy_06_velocity_closed_tickets.md): an idle item produces
  no closures — staleness is the absence of the metric.

## One-line summary for Claude

> Make the quality gate binary — any single lint/static-analysis violation fails
> it, no allowlist — so a fast-moving agent can't lower quality even by accident.
> And treat taking a task as no promise: an in-progress item idle past ~10 days
> with no deliverable gets dropped or re-scoped, never kept alive with faked
> activity.
