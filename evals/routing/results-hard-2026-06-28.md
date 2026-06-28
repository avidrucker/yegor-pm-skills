# yegor-pm routing — adversarial set results (issue #31)

**Date:** 2026-06-28 · **n=18, 1 router run each** · same independent-router harness as the pilot.

## Per-prompt verdicts

| id | category | expected | router → primary | conf | verdict |
|----|----------|----------|------------------|------|---------|
| H1 | under-specified | yegor-stuck | yegor-stuck | med | ✅ exact |
| H2 | under-specified | yegor-unit-tests | **none** (unit-tests 2nd) | med | ❌ under-trigger |
| H3 | under-specified | yegor-merge-gate *(soft)* | none | med | ⚠️ soft — defensible none |
| H4 | under-specified | yegor-tickets *(soft)* | none (tickets 2nd) | med | ⚠️ soft — defensible none |
| H5 | two-in-sequence | yegor-spikes | yegor-spikes | high | ✅ exact (correct first responder) |
| H6 | two-in-sequence | yegor-bdd *(soft)* | yegor-review | med | ✅ acceptable-alt |
| H7 | two-in-sequence | yegor-spikes *(soft)* | yegor-spikes | med | ✅ exact (scope-before-estimate) |
| H8 | meta-route-down | yegor-pm *(soft)* | yegor-pm | high | ✅ exact |
| H9 | meta-route-down | yegor-pm | yegor-pm | high | ✅ exact |
| H10 | meta-route-down | yegor-pm *(soft)* | yegor-pm | high | ✅ exact |
| H11 | harder-negative | none *(soft)* | none | high | ✅ correct no-fire |
| H12 | harder-negative | none | none | high | ✅ correct no-fire |
| H13 | harder-negative | none | none | high | ✅ correct no-fire |
| H14 | harder-negative | none | none | high | ✅ correct no-fire |
| H15 | boundary-straddler | yegor-bdd *(soft)* | yegor-bdd | med | ✅ exact |
| H16 | boundary-straddler | yegor-personas | yegor-personas | med | ✅ exact |
| H17 | boundary-straddler | yegor-bdd | yegor-bdd | med | ✅ exact |
| H18 | boundary-straddler | yegor-architect *(soft)* | yegor-architect | med | ✅ exact |

## Scorecard
- **Negatives (should NOT fire): 4/4 correct** — including H11 (a CI-config request that shares heavy surface with `yegor-builds`). No false positives, even on harder near-misses than the pilot used.
- **Should-trigger (14): 11 routed into expected-or-acceptable (79%)**; **3 under-triggered to `none`** (H2, H3, H4).
- **Only 1 hard miss: H2.** H3 and H4 were pre-labeled `soft` (genuinely ambiguous); the router's `none` is defensible for both.
- **Structured-but-hard cases held perfectly:**
  - meta-route-down: **3/3** correctly engaged `yegor-pm` (the layer the pilot had isolated out).
  - two-in-sequence: correct **first** responder every time (spikes before pdd/projections; H6 chose review, within acceptable).
  - boundary-straddlers: **4/4**, and they cleanly separate three adjacent decision skills (see below).

## Finding 1 — under-triggering on terse / colloquial phrasing (the real bug)
The adversarial set's payoff. The router is reliable on explicit phrasing but **conservative when the request is casual and under-specified**, declining to a skill it lists as merely *secondary*:

- **H2 "honestly can you just make this test suite less embarrassing"** → `none`, with `yegor-unit-tests` named as secondary, reasoning *"generic implementation work with no explicit discipline trigger."* This is a clear under-trigger: test-quality cleanup is exactly `yegor-unit-tests`' job, but the colloquial framing read as plain coding.
- **H3 / H4** show the same shape more mildly (abstract "done done"; venting "in our group chat") and are defensible declines.

**Why it matters:** this is the dominant real-world failure mode for this family — not cross-firing to the *wrong* skill, but failing to fire at all when a user speaks casually. Consistent with skill-creator's documented "skills tend to under-trigger" caveat.

**Candidate fix (separate ticket, separate review):** make `yegor-unit-tests`' description claim informal test-quality phrasing ("clean up / improve / fix flaky / make tests better"), not just "writing, reviewing, or refactoring unit tests." Filed as **#32** (not edited under #31 — routing changes get their own review).

## Finding 2 — the personas / bdd / architect boundary is actually well-drawn
The pilot's open #11 question resolves favorably. Across four straddlers the router separated three adjacent decision skills consistently:

- **bug-vs-feature classification** → `yegor-bdd` (H15 sluggish-on-old-phones, H17 file-slow-load-as-bug).
- **contested team-split call, "weigh both sides strictly"** → `yegor-personas` (H16 IE11).
- **design conflict needing one owner with authority** → `yegor-architect` (H18 REST-vs-GraphQL).

So the pilot's #11 (which routed to `bdd` where the label said `personas`) was **the label being too strict, not a routing bug** — `bdd` rightly owns bug-classification; `personas` is reserved for genuinely contested calls. Recommend closing the #11 concern as "working as intended."

## Caveats (unchanged from pilot)
Router-judge ≈ live triggering, not identical · n=1 per prompt (no variance) · single model · the live harness also weighs task difficulty and sees non-yegor skills competing (a few subagents spontaneously named `issue-review-skill` / `author-*` as alternates — evidence the family competes against the wider skill set in reality).
