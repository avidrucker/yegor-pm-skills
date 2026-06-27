---
name: yegor-builds
description: One build can't serve every need — use a tiered set. From Yegor Bugayenko's "Four Builds" — a Fast build (seconds, local, unit-only) for the inner loop, a Cheap build (minutes, on every PR, +integration/style), a Preflight build (the slow pre-merge gate, +mutation/load/security), and a Proper build (full regression, at release). Speed early, thoroughness late. Pairs with the 8+2 CI-maturity ladder, and with trust-based dependency versioning (pin untrusted deps to fixed versions, allow ranges for trusted ones, record the rationale). Use when setting up or fixing CI, when a test loop is too slow, when all checks are crammed into one job, when deciding what to run where, or when choosing how to pin a dependency.
version: 0.2.0
last_reviewed: 2026-06-26
---

# Yegor Builds — Tiered Builds, Fast Loop / Slow Gate

One build cannot be both fast enough to run on every save **and** thorough enough to trust a release. Trying to make a single build do both gives you the worst of each: too slow to iterate on, too shallow to gate on. Split it into **tiers**, each with a different speed/thoroughness trade-off and a different trigger.

> Speed early, thoroughness late. The developer (or agent) iterates against a build measured in **seconds**; the heavy, slow, expensive checks live at the **merge gate** and the **release**, where latency doesn't cost you a feedback loop.

## Triggers
- Setting up CI for a project, or auditing an existing pipeline.
- A test/feedback loop is too slow to iterate against ("I run the whole suite on every change").
- Every check (unit + integration + lint + security + load) is crammed into one job.
- Deciding *what* to run *where* — local vs PR vs pre-merge vs release.
- An agent needs a fast inner loop but the project only has one slow build.

## The four builds

| Build | Speed | Trigger | Contains | Purpose |
|---|---|---|---|---|
| **Fast** | seconds | local, every change | unit tests only | the inner loop — keep it instant |
| **Cheap** | minutes | every PR / push | + integration, style/lint, coverage | catch the obvious before review |
| **Preflight** | up to ~1hr | pre-merge gate | + mutation, load, security, full integration | the impartial gate — prove it before trunk |
| **Proper** | hours | at release / nightly | full regression, everything | release confidence |

The ordering is the point: **the cheaper the build, the more often it runs.** A change passes through them in sequence — it should never reach Preflight while still failing Fast.

## Core rules

- **The Fast build is sacred — keep it in seconds.** It is the loop you (or the agent) actually live in. Unit-only, no network, no containers. If it creeps past a few seconds, something heavier leaked in — move it down to Cheap or Preflight.
- **Don't cram all test types into one job.** Mutation testing, load tests, and security scans belong in Preflight/Proper, not in the loop you run on every keystroke. One mega-build punishes every iteration with release-grade latency.
- **The Preflight build is the merge gate.** This is where `yegor-merge-gate` lives: the slow, clean-environment, full-suite run that admits a change to the read-only trunk. It's allowed to be slow because it runs once per merge, not once per change.
- **Each tier is a superset of the cheaper one.** Cheap runs everything Fast runs, plus more; Preflight everything Cheap runs, plus more. A green Preflight implies a green Fast.
- **Match the build to the cost of latency.** Latency in the Fast build costs you a feedback loop (expensive, constant). Latency in Proper costs you nothing (it runs unattended at release). Push slow things down the tiers accordingly.

## The 8+2 CI-maturity ladder (self-audit)

Yegor's *8+2 Maturity Levels of Continuous Integration* gives a rung-by-rung checklist for auditing where a repo's pipeline actually is. Each rung is a prerequisite for the next — find the **lowest one you don't yet meet** and fix that first:

1. Build runs with **one command** (no manual steps).
2. Source is in **Git** (or equivalent).
3. **Master is read-only** — changes arrive only via PR (`yegor-merge-gate`).
4. Every PR gets a **mandatory review** (`yegor-review`).
5. Every change **ships with a test** (`yegor-unit-tests`, testless-PR gate).
6. A **static-analysis threshold** fails the build (`yegor-merge-gate` zero-tolerance).
7. **Pre-flight builds** — the branch is tested *merged into* master before landing.
8. **Containerized, prod-like** environment for the gate.
9. (+1) **Automated stress/load tests.**
10. (+2) **Automated security/penetration tests.**

> The ladder is diagnostic, not aspirational: an AI agent can walk a repo and report the lowest missing rung (branch protection? one-command build? a static-analysis gate?) rather than chasing the top.

## Trust-based dependency versioning

A reproducible build also depends on how you pin dependencies — and the honest answer isn't "pin everything" or "float everything," but **pin by trust**:

- **Untrusted deps → fixed versions.** For a small/sporadic/low-reputation library, pin an exact version. You don't trust it to honour semver, so you take the breakage on *your* schedule, not theirs. A fixed pin is a defence against a surprise upstream change.
- **Trusted deps → ranges/dynamic.** For a high-reputation library with a disciplined release history (follows semver, active, broadly used), allow a range (`^`, `~>`, `>=`). You trust it to ship safe minor/patch updates, so you get fixes automatically without a recursive version conflict.
- **Record the trust rationale.** The pin is a *decision*, so it lives in the tracker/docs like any other (`yegor-tickets`): "pinned `foo` to 1.2.3 — small team, sporadic releases, don't trust semver" / "`bar` on `^3` — well-run project, follows semver." A pin with no reason is a future mystery.
- **Avoid both failure modes.** Pinning everything forever is a *time bomb* (you never get security fixes until something forces a painful mass-upgrade); floating everything is *dependency hell* (a transitive minor bump breaks you with no warning). Trust-based pinning is the middle path.

> Solo + agent: an AI agent can audit `pom.xml`/`package.json`/`deps.edn`, flag deps that are fixed-pinned with no recorded reason or floated despite being low-trust, and propose the trust classification — turning version strategy into a checkable decision rather than a habit.

## For solo / AI-augmented work

- **Give the agent a Fast build to live in.** An agent iterating against a 10-minute build burns the loop on waiting. A seconds-long unit build is the single biggest lever on agent throughput — wire it first.
- **Slow checks at the gate, not the loop.** Mutation/load/security run once, at Preflight, when the change is otherwise done. Don't make the agent pay release-grade latency on every iteration.
- **You don't need all four named jobs.** Solo, the minimum is *two distinct speeds*: a seconds-long local unit build and a slower pre-merge gate. The four-tier model is the target, not a day-one requirement.

## How Claude should use this
- **When a loop is slow:** "The suite you're iterating against runs everything — let's split out a Fast unit-only build (seconds) and move the integration/load tests to the pre-merge gate."
- **When auditing CI:** walk the 8+2 ladder and name the lowest missing rung. "Master isn't read-only yet (rung 3) — that's the next thing to fix, before worrying about mutation tests."
- **When all checks are one job:** "These are crammed into one build. Tier them: Fast (unit) → Cheap (PR) → Preflight (gate) → Proper (release)."

## Pitfalls
- **One mega-build.** Every check in a single job, so the inner loop pays release-grade latency.
- **A slow Fast build.** Integration/network/containers leaking into the seconds-long loop until it's no longer seconds.
- **Aspirational laddering.** Chasing rung 10 (security scans) while rung 3 (read-only master) is still unmet.
- **Gate-grade checks in the loop.** Running mutation/load tests on every save instead of once at Preflight.

## Cross-references
- `yegor-merge-gate` — the Preflight build *is* the gate; this skill says what runs there and what runs earlier.
- `yegor-unit-tests` — the Fast build is the unit suite; it must be able to fail and run in seconds.
- `yegor-review` — rung 4 of the ladder; review is part of admission, the build is the other part.
- `yegor-microtasks` — small changes keep each tier fast; a 60-minute change doesn't bloat the gate.
- `yegor-tickets` — a dependency pin is a recorded decision, not a silent habit.
- `yegor-merge-gate` — a floated low-trust dep is exactly the kind of surprise the zero-tolerance gate exists to catch.

## Deep reference
- `research/philosophy_12_four_builds_ci_maturity.md`
- `research/philosophy_24_dependency_trust.md` (trust-based version pinning)
