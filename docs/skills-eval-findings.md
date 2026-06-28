# Skills Eval Findings — yegor-pm family

**Date:** 2026-06-28
**Scope:** Routing pilot (small) over the 18-skill `yegor-*` family + meta-orchestrator.
**Method:** Each prompt judged by an independent subagent acting as Claude's skill router, seeing only the real family descriptions. Approximates live triggering; not identical to it (see caveats).
**Tooling:** `skill-creator` skill — its eval/benchmark harness (trigger-routing, with-vs-baseline behavioral grading, blind A/B comparison).

---

## How we got here: the testing toolkit

`skill-creator` is not just an authoring tool — it ships a full eval harness with three capabilities relevant to improving this family:

| Capability | What it measures | Script |
|---|---|---|
| **Behavioral eval** | with-skill vs. baseline agent on a real prompt, graded against assertions; aggregates pass-rate, time, tokens (mean ± stddev, with delta) | `scripts/aggregate_benchmark.py` + `eval-viewer/generate_review.py` |
| **Trigger optimization** | does the skill *fire* when it should and *stay quiet* when it shouldn't — runs each query 3× for a stable rate, train/test split to avoid overfitting | `scripts/run_loop.py` |
| **Blind A/B comparison** | is v2 actually better than v1 — independent judge agent, doesn't know which is which | `agents/comparator.md` |

### The catch for *these* skills specifically
Most skill-creator examples are objective file-transforms (xlsx → chart). The yegor-* skills are **subjective process/methodology skills** — "did it work" means *did the agent's behavior shift in the disciplined direction*, not "is the output byte-correct." That changes which tests carry weight. Two dimensions actually matter:

1. **Trigger/routing accuracy — the biggest risk, most automatable.** 18 skills with heavy descriptive overlap (bdd / tickets / review all touch issues; pdd / spikes / microtasks all touch breakdown). Real failure modes are *cross-triggering* and the meta-`yegor-pm` mis-routing. The most valuable eval queries are the **near-misses** (share keywords with a skill but should route elsewhere). → **This pilot.**
2. **Behavioral discipline eval — does the doctrine change output?** Run a realistic prompt with-skill vs. baseline, grade with assertions that *encode the doctrine* (bdd: title names a breakage + repro + failing test? review: defaults to reject, auto-rejects a testless prod change? unit-tests: flags Liar/Inspector/Mockery?). Objectively gradable because the doctrine is a checklist. → **Not yet run.**

### "Cross-compare" means two different things
- **Version A/B** ("is strengthened v2 better than v1?") → blind comparison, or baseline = prior git revision in the behavioral harness. For *existing* skills the natural baseline is the previous git revision, not "no skill."
- **Skill-vs-skill** ("which skills collide?") → one **shared family trigger-suite**: run the same prompts past the whole family, see which skill(s) light up. Unique to having a big overlapping family; where the most bugs hide. → **This pilot is the first instance.**

---

## Pilot results (n=14, 1 router run each)

| # | area | expected | router → primary | conf | verdict |
|---|------|----------|------------------|------|---------|
| 1 | file a bug | yegor-bdd | yegor-bdd | high | ✅ exact |
| 2 | defer sub-problem | yegor-pdd | yegor-pdd | high | ✅ exact |
| 3 | vague big ticket | yegor-spikes | yegor-spikes | high | ✅ exact |
| 4 | when-done forecast | yegor-projections | yegor-projections | high | ✅ exact |
| 5 | productivity number | yegor-velocity | yegor-velocity | high | ✅ exact |
| 6 | review a PR | yegor-review | yegor-review | high | ✅ exact |
| 7 | fix over-mocked tests | yegor-unit-tests | yegor-unit-tests | high | ✅ exact |
| 8 | merge my own green PR | yegor-merge-gate | yegor-merge-gate | high | ✅ exact |
| 9 | grinding, tempted to hack | yegor-stuck | yegor-stuck | medium | ✅ exact |
| 10 | one giant CI job | yegor-builds | yegor-builds | high | ✅ exact |
| 11 | bug-or-feature, "be strict" | yegor-personas | yegor-bdd (personas=2nd) | medium | ⚠️ acceptable alt |
| 12 | where to record decision | yegor-tickets | yegor-tickets | high | ✅ exact |
| 13 | write a log-parser (neg) | none | none | high | ✅ correct no-fire |
| 14 | git merge vs rebase (neg) | none | none | high | ✅ correct no-fire |

### Scorecard
- **Trigger direction correct: 14/14** — every should-trigger fired; both negatives stayed quiet.
- **Exact-primary match: 13/14.**
- **No false positives** on the two keyword-trap negatives (`builds` / `merge-gate` keywords present, both correctly → none).
- **No cross-trigger failures** on the classic overlap seams — including the mirror-image pairs:
  - bdd vs tickets (#1) — separated
  - review vs unit-tests (#6/#7) — separated, mirror-image clean
  - merge-gate vs builds (#8/#10) — separated, mirror-image clean
  - projections vs velocity (#4/#5) — separated, mirror-image clean
- **Confidence well-calibrated**: the only two `medium` calls (#9, #11) are the two genuinely fuzzy prompts. The router "knows" where it's unsure.

### The one soft spot: #11 (personas vs bdd)
"Should 'dashboard feels slow' be a **bug or a feature**? be strict and settle it" routed to **yegor-bdd** with **yegor-personas** as secondary. Defensible — bdd holds the bug-vs-feature stance and can settle it directly; personas is for genuinely *contested* calls. A real boundary ambiguity, not a clear miss.

**Decision for the maintainer:** is "be strict / settle a contested classification" personas' turf, or bdd's?
- If **personas** → its description should explicitly claim bug-vs-feature / scope classification disputes.
- If **bdd** → the label was just too strict; routing is correct.

### Caveats (don't over-read a 14/14)
1. **Router-judge ≈ live triggering, not identical.** Live harness also weighs "is this hard enough to need a skill" and sees the meta `yegor-pm` + all non-yegor skills competing. This pilot isolated the family.
2. **n=1 per prompt.** No variance estimate. Real eval (`run_loop.py`) runs each 3× for a stable rate.
3. **Single model.** One session's model only.
4. **Easy by construction.** Pilot prompts were clear archetypes. The next set should be deliberately nastier — under-specified prompts, prompts that legitimately need two skills in sequence, and prompts where the meta-orchestrator must route down.

---

## Round 2 — adversarial set (issue #31, 2026-06-28)

Built to *break* routing rather than confirm it: 18 prompts across under-specified, two-in-sequence, meta-route-down, harder-negative, and boundary-straddler categories. Full detail in `evals/routing/results-hard-2026-06-28.md`.

**Headline:** negatives **4/4** (no false positives, including a CI-config near-miss); should-trigger **11/14 into expected-or-acceptable**; **3 under-triggered to `none`** (one hard miss). The structured-but-hard cases held perfectly — meta-route-down **3/3**, two-in-sequence picked the correct *first* responder every time, boundary-straddlers **4/4**.

**Finding 1 — under-triggering on terse/colloquial phrasing (the real bug).** The router is reliable on explicit phrasing but conservative when a request is casual/under-specified, declining to a skill it only lists as *secondary*. Clearest case: H2 *"honestly can you just make this test suite less embarrassing"* → `none` (with `yegor-unit-tests` as secondary, reasoned as "generic implementation"). This — failing to fire at all on casual phrasing — is the dominant real-world failure mode for this family, not cross-firing to the wrong skill. Candidate fix: broaden `yegor-unit-tests`' description to claim informal test-quality phrasing. **Filed as a follow-up so the description change gets its own review (do not edit description text under #31).**

**Finding 2 — the personas/bdd/architect boundary is well-drawn; pilot #11 resolves as "working as intended".** Across four straddlers the router cleanly separated three adjacent decision skills: bug-vs-feature *classification* → `bdd` (H15, H17); contested *team-split* call → `personas` (H16); design conflict needing one *owner* → `architect` (H18). The pilot's #11 (routed `bdd` where the label said `personas`) was the label being too strict, not a routing bug.

---

## Next steps (pick one)

- **Harden the routing set** — write deliberately nastier prompts (under-specified, two-skills-in-sequence, meta-orchestrator-must-route-down) and re-run. Where bugs will actually surface; today's set was too kind. **(Recommended next.)**
- **Move to behavioral evals** — pick 2–3 skills (bdd / review / pdd natural first) and run with-skill vs the *prior git revision* on real tasks, graded against doctrine assertions. Tests whether the doctrine *changes output*, not just whether it triggers.
- **Resolve #11 first** — decide the personas/bdd boundary, tighten one description, re-test that prompt.
- **Commit the harness** — promote `evals.json` + the router method into the repo (e.g. `evals/routing/`) as a reusable, version-controlled regression suite instead of leaving it in scratchpad.

**Recommendation:** commit the harness, then harden the routing set — the easy cases pass, so the next dollar is best spent trying to break it.

---

## Artifacts (version-controlled)
- `evals/routing/evals.json` — the 14 labeled prompts (expected_primary / acceptable / trap / should_trigger).
- `evals/routing/skill_descriptions.md` — the 18 real family descriptions the router judged against.
- `evals/routing/results-2026-06-28.md` — pilot scorecard.
- `evals/routing/evals-hard.json` — the 18-prompt adversarial set (issue #31).
- `evals/routing/results-hard-2026-06-28.md` — adversarial-round scorecard.
- `evals/routing/README.md` — how to refresh the snapshot and re-run the suite.

> Promoted from session scratchpad into `evals/routing/` on 2026-06-28 so the suite is durable and re-runnable. Refresh `skill_descriptions.md` whenever any skill's `description:` changes, then re-run.
