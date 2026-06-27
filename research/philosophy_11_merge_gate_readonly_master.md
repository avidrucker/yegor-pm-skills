# Philosophy 11 — Read-Only Master & the Merge Gate

> **Why this doc exists:** capture Yegor's rule that the trunk branch is
> read-only, that no author blesses their own merge, and that you never merge
> into a broken master — and translate it for a solo developer working with AI
> agents, where the "author who must not self-bless" is often Claude.
>
> **Primary sources:**
> - Yegor Bugayenko, *Master Branch Must Be Read-Only* (2014-07-21) — https://www.yegor256.com/2014/07/21/read-only-master-branch.html
> - Yegor Bugayenko, *Rultor, a Merging Bot* (2014-07-24) — https://www.yegor256.com/2014/07/24/rultor-automated-merging.html
> - Yegor Bugayenko, *We Don't Merge into a Broken Master Branch* (2025-04-19) — https://www.yegor256.com/2025/04/19/dont-merge-into-broken-master.html
> - Related: *Continuous Integration Is Dead* (2014-10-08) — https://www.yegor256.com/2014/10/08/continuous-integration-is-dead.html

---

## The principle (paraphrased)

The trunk branch (master/main) is **read-only**: nobody — not even the repo
owner — pushes to it by hand. Every change enters through an **automated gate**
(Yegor's is `rultor`) that merges the branch into a fresh, clean environment,
runs the **full** test suite, and pushes to the trunk **only if everything is
green**. If the build fails, the branch is rejected and bounced back to the
author.

Two consequences follow:

1. **The author never blesses their own merge.** Writing the change and admitting
   it to the trunk are separate roles. The impartial gate decides admission, not
   the person who wrote it.
2. **You never merge into a broken master.** When the build is red, the *only*
   change allowed in is the one that fixes the build. Stacking features on a red
   trunk makes every subsequent failure ambiguous.

## Why it works

- **"Green CI" is meaningless if people can bypass it.** Yegor's core point: no
  matter how good your CI is, it does nothing unless the trunk is read-only. A
  direct push is an un-gated change.
- **A clean-environment full run catches "works on my machine."** The gate merges
  into a fresh checkout/container, so environmental luck can't sneak a red change
  in.
- **Impartiality.** The author is the worst judge of their own work's readiness.
  An automated gate (and an independent reviewer) has no ego in it.
- **A red trunk is a stop-the-line event.** Refusing all changes but the fix keeps
  failures attributable and the trunk releasable at all times.

## Canonical rules

- **Master is read-only** — branch protection on; no direct pushes.
- **Author never self-blesses** — a separate gate proves green before merge.
- **The gate runs the full suite in a clean environment** — not a partial or
  local pass.
- **Never merge into a broken master** — when red, accept only the build-fix.
- **Build-fixes ship alone** — the trunk repair is its own isolated PR, filed as
  a complaint and merged first.

## Translating for solo + AI work

The team-era mechanism (a merge bot like rultor) is optional; the *discipline*
translates directly:

- **CI is the impartial gate.** Solo, it's tempting to push to main directly
  "because it's just me." Don't. Protect the branch; let CI be the gate you can't
  argue with.
- **An author-agent must not merge its own PR unchecked.** If Claude wrote the
  change, Claude doesn't also declare it done and merge it. The gate is a passing
  CI run **and/or** an independent review pass (e.g. `/code-review`, or a second
  agent). This is the automation-era form of "no self-blessing": the writer and
  the admitter are different actors.
- **Red trunk halts new work.** If `main` is red, the next action is to fix the
  build — in its own branch — before starting or merging anything else.

## Actionable guidelines

### How Claude should use this

- **Before proposing a merge:** assert *the gate is green*, not *I wrote it so
  it's ready*. "CI is passing on this branch — safe to merge."
- **When master is red:** refuse to layer new work. "Master's build is broken —
  the only change I'll merge now is the fix. Filing the broken-build bug first."
- **When asked to merge your own work:** name the gate. "I wrote this, so I
  shouldn't bless it — let's get CI green and an independent review before it
  lands."

## Pitfalls

- **"Green on my machine"** standing in for the gate.
- **Self-merge** — author pushing their own work to the trunk with no impartial
  check.
- **Stacking on red** — merging features while master is broken.
- **Bundling the build-fix** into a feature PR instead of shipping it isolated and
  first.

## Integration with the other philosophies

- + [Review](./philosophy_08_review_serious_code_reviewer.md): the independent
  review is half the gate; the reviewer rejects, the automated gate enforces
  green.
- + [BDD](./philosophy_02_bdd_bug_driven_development.md): a broken master is a
  complaint; the build-fix is its dedicated change.
- + [Velocity](./philosophy_06_velocity_closed_tickets.md): only gated-and-merged
  work counts as closed.
- + [Tickets](./philosophy_04_tickets_ticket_as_conversation.md): the
  broken-build bug and its fix live in the tracker.

## One-line summary for Claude

> The trunk is read-only and you never bless your own merge — an impartial gate
> (clean-environment full test run + independent review) admits changes. Never
> merge into a broken master; the only change allowed on red is the isolated
> build-fix.
