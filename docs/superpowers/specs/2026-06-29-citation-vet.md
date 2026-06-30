# Citation vet — Yegor grounding for `assess-request-quality`

**Date:** 2026-06-29 · **Skill:** `author-vet-this-source` · **Target:** the Yegor citations in `2026-06-29-assess-request-quality-design.md` (origin: research spike #34).
**Method:** independently re-fetched all 5 cited yegor256.com posts and checked each quote against the live page.

## Source ledger

| Claim (as used in spec) | Verified? | Tier · basis | Note |
|---|---|---|---|
| Done = author acceptance | ✅ verbatim | ✅-as-Yegor-rep · Normative | "the task is done iff its author accepts the deliverables" — exact ([DoD](https://www.yegor256.com/2014/04/15/definition-of-done.html)). Keep. |
| 0/100 rule | ✅ verbatim | ✅ · Normative | "either 'in progress' or 'complete'. There can be nothing in the middle." ([microtasking](https://www.yegor256.com/2017/11/28/microtasking.html)). Keep. |
| "inability to define what we expect" | ✅ verbatim | ✅ · Normative | Exact ([microtasking](https://www.yegor256.com/2017/11/28/microtasking.html)). Keep. |
| Outcome not mechanism (specs #6) | ✅ verbatim | ✅ · Normative | "You shouldn't tell me how to implement…" ([specs](https://www.yegor256.com/2015/11/10/ten-mistakes-in-specs.html)). Keep. |
| No questions in a spec (specs #2) | ✅ verbatim | ✅ · Normative | "Specifications can't have any questions in them." Keep. |
| Name the actor (specs #7) | ✅ verbatim | ✅ · Normative | "A good user story always has … a user." Keep. |
| Actor/victim ("I can't use the class") | ✅ verbatim | ✅ · Normative | Real — in [right-way-to-report-bugs](https://www.yegor256.com/2018/04/24/right-way-to-report-bugs.html). Keep. |
| "9 mistakes, not 10" | ✅ correct | ✅ · factual | Confirmed 9 numbered items. Keep. |
| **A→B "explain where point A and point B are"** | ⚠️ paraphrase-as-quote | caveat → **FIXED** | Concept real (✅) but quoted words were ours. Replaced with his: "what we *have* … what we *should have* instead" / "move from point A to point B" ([bug-tracking](https://www.yegor256.com/2014/11/24/principles-of-bug-tracking.html)). The 2nd citation (right-way) did **not** support A→B — re-homed to actor/victim. |
| **"Don't assume anything — ask … in advance"** | ⚠️ stitched quote | caveat → **FIXED** | Two separate real sentences merged with an ellipsis. Split into the two actual quotes ([DoD](https://www.yegor256.com/2014/04/15/definition-of-done.html)). |

## Trust verdict
- **Keep (7):** all verbatim doctrine quotes — solid as faithful representations of Yegor's methodology.
- **Caveat → fixed (2):** A→B paraphrase-in-quotes; stitched "don't assume" quote. Both corrected in the spec.
- **Drop (0):** nothing fabricated.
- **Framing caveat:** these are Yegor's *normative* methodology claims (basis = Ethos/Normative, not empirical). The skill must present them as *"the Yegor doctrine holds…"*, not as proven facts — which the spec does (explicitly "Yegor-grounded"). No tier upgrade for authority or convergence.

## Bottom line
No fabricated citations. The pre-mortem's "hallucinated grounding" risk surfaced in the mild form (paraphrase dressed as quote) and is now corrected. Build-DoD item 4 (spot-verify quotes) is retired by this pass.
