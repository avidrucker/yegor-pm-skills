# Task 1 Report — assess-request-quality SKILL.md

**Date:** 2026-06-29
**Commit:** 4773233
**File produced:** `skills/assess-request-quality/SKILL.md`

## What was written

### Frontmatter
Used the exact `name` and `description` from Task 1 Step 1 of the plan verbatim.

### Body sections (in order per Task 1 Step 2)
1. **One-paragraph purpose** — diagnose actionability with objective measurements; emit questions, never fabricate. Plus the load-bearing `issue-review-skill` boundary sentence (pre-mortem Risk-4 fix from spec §Triggering).
2. **Front gate** — 4-row routing table (Goal/Question/Complaint/Work-request) + assertion test with Yegor spec-mistake #2 quote.
3. **Diagnostic 1 — disambiguation** — count N materially-different deliverables; N ≥ 2 = under-specified; readings ARE the questions. Includes the H2 example (N=4).
4. **Diagnostic 2 — six checks** — verbatim table with all 6 checks (Target/Now-state A/Outcome B/Done-check/Acceptor/Bounds), objective test and grounding columns. A→B pair note included. Check 6 (bounds) labelled as skill's own with no direct Yegor source.
5. **Verdict + trigger split** — full pass N≤1 ∧ M=6/6 (gate-mode); speak-up trigger N≥2 NOT M<6/6; suggest-mode = top gap only. Perfect-or-spike rule (3 sub-cases).
6. **No-fabrication rule + tiered behavior** — actionable vs under-specified paths; NEVER an invented rewrite; default suggest (N≥2, single top gap) vs gate opt-in (full 6/6 bar).
7. **Output format** — exact code block from spec §Output format.
8. **Grounding anchors** — all 9 verified Yegor anchors from citation-vet, using post-vet wording only. Framed as Yegor's normative methodology claims.

## Structure-check output

```
STRUCTURE OK
```

Command run:
```bash
cd skills/assess-request-quality && \
grep -q '^name: assess-request-quality' SKILL.md && \
grep -q 'N ≥ 2' SKILL.md && grep -q '6/6' SKILL.md && \
grep -qi 'never' SKILL.md && echo "STRUCTURE OK"
```

## Self-review notes

**Six checks — all present?**
1. Target named? ✅ (row 1 of table)
2. Now-state (A)? ✅ (row 2, A→B pair noted)
3. Outcome observable (B)? ✅ (row 3, mechanism-only rejection included)
4. Done-check named? ✅ (row 4, 0/100 rule)
5. Acceptor named? ✅ (row 5, author acceptance)
6. Bounds given? ✅ (row 6, labelled as skill's own)

**Trigger split stated correctly?**
- N ≥ 2 to speak up (suggest-mode) ✅
- 6/6 gate-only (not the everyday trigger) ✅
- Suggest-mode = top gap-question only (not all six) ✅

**No fabricated/invented rewrite path?**
- No-fabrication rule section: "Do **not** invent a rewrite. **Never** produce a finished rewrite from insufficient information." ✅

**Boundary with issue-review-skill stated?**
- In the body (after purpose paragraph): one dedicated sentence ✅

**Verified Yegor quotes only?**
- All quotes sourced from citation-vet file; A→B wording uses post-vet form ("what we *have*, what we *should have* instead"); "don't assume" split into two separate sentence attributions ✅
- Check 6 (bounds) explicitly labelled as skill's own with no direct Yegor source ✅

**No fabrications introduced?**
- No new quotes beyond what citation-vet verified ✅

## Concerns

None. All six checks are present. Trigger split is correctly stated (N≥2 for suggest, 6/6 for gate). No-fabrication rule is explicit. Boundaries are stated. Yegor quotes use only post-vet wording.
