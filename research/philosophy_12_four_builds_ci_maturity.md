# Philosophy 12 — Tiered Builds & the CI-Maturity Ladder

> **Why this doc exists:** capture Yegor's argument that a single build can't
> serve every need — you want a tier of builds, each trading speed against
> thoroughness — and pair it with his 8+2 rung-by-rung CI-maturity checklist,
> then translate both for a solo developer working with AI agents, where a
> seconds-long inner-loop build is the single biggest lever on agent throughput.
>
> **Primary sources:**
> - Yegor Bugayenko, *Four Builds* (2025-04-12) — https://www.yegor256.com/2025/04/12/four-builds.html
> - Yegor Bugayenko, *8+2 Maturity Levels of Continuous Integration* (2016-08-01) — https://www.yegor256.com/2016/08/01/continuous-integration-maturity.html
> - Related: *Continuous Integration Is Dead* (2014-10-08) — https://www.yegor256.com/2014/10/08/continuous-integration-is-dead.html (see philosophy_11)

---

## The principle (paraphrased)

No single build can be both fast enough to run on every change and thorough
enough to trust a release. A build optimised for speed skips the slow,
expensive checks (mutation testing, load tests, security scans); a build
optimised for thoroughness is too slow to iterate against. The resolution is to
run **several builds**, each at a different point on the speed/thoroughness
curve, triggered at a different moment:

1. **Fast** — seconds, runs locally on every change, unit tests only. The inner
   loop the developer (or agent) lives in.
2. **Cheap** — minutes, runs on every PR/push, adds integration tests, style/
   lint, and coverage. Catches the obvious before a human looks.
3. **Preflight** — up to about an hour, runs as the **pre-merge gate**, adds
   mutation testing, load tests, security scans, full integration. The impartial
   gate that admits a change to the read-only trunk.
4. **Proper** — hours, runs at release (or nightly), full regression — every
   test there is. Release confidence.

The cheaper the build, the more often it runs. A change flows through the tiers
in order and should never reach a slow tier while still failing a cheap one.

## Why it works

- **Latency is charged where it's cheapest.** A slow Fast build taxes *every*
  iteration — the most expensive place to put latency. A slow Proper build runs
  unattended at release and costs nothing. Tiering pushes slow work to where
  waiting is free.
- **Each tier is a superset.** Cheap runs everything Fast runs plus more;
  Preflight everything Cheap runs plus more. So a green slow tier implies a
  green fast tier — no need to re-run the cheap checks to trust the expensive
  ones.
- **It separates "iterate" from "trust."** The Fast/Cheap builds are for the
  author to iterate; the Preflight build is for the *project* to decide
  admission (the `yegor-merge-gate` discipline). Different jobs, different
  speeds, different triggers.

## The 8+2 CI-maturity ladder

A separate but complementary lens: *where is this repo's pipeline, really?*
Yegor's ladder is diagnostic — each rung is a prerequisite for the next, so you
fix the **lowest missing rung first** rather than chasing the top.

1. The build runs with **one command** — no manual steps.
2. Source lives in **Git** (or equivalent VCS).
3. **Master is read-only** — changes arrive only through PRs (philosophy_11).
4. Every PR gets a **mandatory review** (philosophy_08).
5. Every change **ships with a test** (philosophy_09 + testless-PR gate,
   philosophy_16).
6. A **static-analysis threshold** fails the build (philosophy_19,
   zero-tolerance gate).
7. **Pre-flight builds** — the branch is tested *merged into* master before it
   actually lands.
8. The gate runs in a **containerized, production-like** environment.
9. (+1) **Automated stress / load tests.**
10. (+2) **Automated security / penetration tests.**

The two models meet at rung 7–8: the *Preflight build* of the four-build model
is the *pre-flight, prod-like* rung of the ladder.

## Canonical rules

- **Keep the Fast build in seconds** — unit-only, no network/containers. It is
  the loop you live in.
- **Don't cram all test types into one job** — mutation/load/security belong in
  Preflight/Proper, not the inner loop.
- **The Preflight build is the merge gate** — slow is fine; it runs once per
  merge.
- **Each tier is a superset of the cheaper one** — green slow ⇒ green fast.
- **Match the build to the cost of latency** — push slow checks down the tiers
  to where waiting is free.
- **Audit by the ladder** — find and fix the lowest missing rung first.

## Translating for solo + AI work

- **A Fast build is the biggest lever on agent throughput.** An agent iterating
  against a 10-minute build spends the loop waiting. A seconds-long unit build
  is the first thing to wire up.
- **Slow checks at the gate, not the loop.** Mutation/load/security run once, at
  Preflight, when the change is otherwise done — never on every agent iteration.
- **Two speeds is the minimum.** You don't need four named jobs solo: a
  seconds-long local unit build and a slower pre-merge gate already capture the
  core split. Four tiers is the target, not a day-one requirement.

## Actionable guidelines

### How Claude should use this

- **When a loop is slow:** propose splitting out a Fast unit-only build and
  moving integration/load tests to the gate. "You're iterating against the whole
  suite — let's give you a seconds-long unit build and run the heavy stuff at
  pre-merge."
- **When auditing CI:** walk the 8+2 ladder and name the lowest missing rung,
  not the most impressive one. "Master isn't read-only yet (rung 3) — fix that
  before mutation tests (rung 9)."
- **When checks are one job:** recommend tiering them by speed and trigger.

## Pitfalls

- **One mega-build** — every check in a single job, so the inner loop pays
  release-grade latency.
- **A slow Fast build** — integration/network/containers leaking into the
  seconds-long loop.
- **Aspirational laddering** — chasing rung 10 while rung 3 is unmet.
- **Gate-grade checks in the loop** — mutation/load tests on every save instead
  of once at Preflight.

## Integration with the other philosophies

- + [Merge gate](./philosophy_11_merge_gate_readonly_master.md): the Preflight
  build *is* the gate; this doc says what runs there vs earlier.
- + [Unit tests](./philosophy_09_unit_tests_anti_patterns.md): the Fast build is
  the unit suite — it must be able to fail and run in seconds.
- + [Review](./philosophy_08_review_serious_code_reviewer.md): rung 4 of the
  ladder; review and the build together form admission.
- + [Microtasks](./philosophy_03_microtasks_microtasking.md): small changes keep
  every tier fast.

## One-line summary for Claude

> Don't make one build do everything: run a Fast unit build (seconds, the loop),
> a Cheap PR build (minutes), a Preflight gate (slow, pre-merge — the merge
> gate), and a Proper release build (full regression). Speed early, thoroughness
> late; audit the pipeline by fixing the lowest missing rung of the 8+2 ladder.
