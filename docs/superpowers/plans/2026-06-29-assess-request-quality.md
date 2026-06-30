# assess-request-quality Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build the `assess-request-quality` skill — a rubric skill that diagnoses whether an incoming work-request is actionable and emits clarifying questions instead of guessing.

**Architecture:** A single `SKILL.md` (prose rubric, like `assess-goal`): a front gate (request / goal / question / complaint) → disambiguation count → six binary checks → verdict → no-fabrication output → tiered behavior. "Tests" are **behavioral evals** run through the existing router-subagent harness (see `evals/routing/README.md`), not unit tests.

**Tech Stack:** Markdown skill file; JSON eval sets; the router-subagent eval harness already in `evals/routing/`.

**Source of truth:** `docs/superpowers/specs/2026-06-29-assess-request-quality-design.md` (committed `a8a70f6`). This plan transcribes that spec into a skill; where a section says "per spec §X," the spec's wording is authoritative — do not re-invent it.

## Global Constraints

[Copied verbatim from the spec — every task implicitly includes these.]

- **Single file:** `skills/assess-request-quality/SKILL.md` — no `references/` or `scripts/`.
- **Trigger on real ambiguity (`N ≥ 2`), NOT on `M < 6/6`.** The perfect `6/6` bar is reserved for gate-mode; suggest-mode surfaces only the single most-divergent gap-question.
- **No-fabrication:** emit gap-questions, never an invented rewrite. Only assemble a sharpened request from the human's answers.
- **Yegor quotes:** use the verified wording from `docs/superpowers/specs/2026-06-29-citation-vet.md`. Do not introduce new quotes.
- **Time-box v1 to one sitting; ship minimal.** No new scope; expansion is gated on real-usage evidence.

---

## File Structure

- **Create** `skills/assess-request-quality/SKILL.md` — the skill (frontmatter + rubric).
- **Create** `evals/request-quality/evals.json` — seed behavioral eval set.
- **Create** `evals/request-quality/results-<date>.md` — eval run scorecard (produced by Task 4/5).
- **Modify** `evals/routing/skill_descriptions.md` + `evals/routing/evals-hard.json` — routing regression.
- **Modify** `README.md`, `GLOSSARY.md`, `skills/yegor-pm/SKILL.md` — family indexes / router.

---

### Task 1: Author `SKILL.md` (frontmatter + full rubric)

**Files:**
- Create: `skills/assess-request-quality/SKILL.md`

**Interfaces:**
- Produces: the skill's `name: assess-request-quality` and the final trigger-pushy `description` that the router reads.

- [ ] **Step 1: Write the frontmatter.** Use exactly this:

```yaml
---
name: assess-request-quality
description: Diagnose whether an incoming work-request — a casual task handed to an agent, a ticket, or an ask handed to a teammate — is clear enough to act on, before guessing. Runs a gate (request vs goal vs question vs complaint), counts how many materially-different deliverables the request could mean, and checks six concrete elements (target, now-state→outcome, done-check, acceptor, bounds), then emits the specific clarifying questions to close the gaps rather than fabricating a sharper version. Use when a handed-over task/request is genuinely ambiguous or visibly thin, or the user asks "is this clear enough to act on?", "what's missing from this ask?", "sharpen this request before we start" — lean toward firing on vague casual requests like "just make X better / less broken". NOT for personal goals (use assess-goal), already-filed GitHub issues (use issue-review-skill), or pure conceptual questions.
---
```

- [ ] **Step 2: Write the body** in this section order, transcribing the spec (do not re-invent wording):
  1. **One-paragraph purpose** — diagnose actionability with objective measurements; emit questions, never fabricate (spec §Purpose).
  2. **Front gate** — the 4-row routing table + assertion test (spec §Front gate). Goal→`assess-goal`, question→content skill, complaint→`yegor-bdd`/`yegor-tickets`, request→diagnostics.
  3. **Diagnostic 1 — disambiguation** — count `N` materially-different deliverables; `N ≥ 2` = under-specified; the readings ARE the questions (spec §Diagnostic 1).
  4. **Diagnostic 2 — six checks** — the verbatim table (Target / Now-state(A) / Outcome(B) / Done-check / Acceptor / Bounds) with the A→B pair note (spec §Diagnostic 2).
  5. **Verdict + trigger split** — full pass `N≤1 ∧ M=6/6` (gate-mode); everyday speak-up trigger `N≥2`; suggest-mode = top gap only (spec §Verdict).
  6. **No-fabrication rule** + **tiered behavior** (spec §Output / §Tiered).
  7. **Output format** — the exact code block (spec §Output format).
  8. **Grounding** — the verified Yegor anchors (spec §Why grounding, post-vet wording only).

- [ ] **Step 3: Verify structure.** Run:

```bash
cd skills/assess-request-quality && \
grep -q '^name: assess-request-quality' SKILL.md && \
grep -q 'N ≥ 2' SKILL.md && grep -q '6/6' SKILL.md && \
grep -q 'never' SKILL.md && echo "STRUCTURE OK"
```
Expected: `STRUCTURE OK`

- [ ] **Step 4: Commit.**

```bash
git add skills/assess-request-quality/SKILL.md
git commit -m "feat(skills): add assess-request-quality SKILL.md (#36)"
```

---

### Task 2: Create the seed eval set

**Files:**
- Create: `evals/request-quality/evals.json`

**Interfaces:**
- Consumes: nothing. Produces: the labelled cases Task 3 runs.

- [ ] **Step 1: Write the eval set.** Each entry has `id`, `prompt`, `expected` (gate verdict + route or N/verdict), `note`:

```json
{
  "suite": "assess-request-quality seed",
  "evals": [
    {"id": "RQ1", "prompt": "honestly can you just make this test suite less embarrassing", "expected": {"type": "work-request", "verdict": "Under-specified", "N_min": 2, "fires": true}, "note": "the canonical weak request (was H2)"},
    {"id": "RQ2", "prompt": "how do i actually know when this is done done, not just done", "expected": {"type": "question", "route": "yegor-merge-gate", "fires": false}, "note": "gate routes out — not scored (was H3)"},
    {"id": "RQ3", "prompt": "we keep going back and forth about this in our group chat and nothing sticks", "expected": {"type": "complaint", "route": "yegor-tickets", "fires": false}, "note": "process complaint (was H4)"},
    {"id": "RQ4", "prompt": "In src/auth/session.ts the refresh-token rotation throws on expiry; change it so an expired refresh token returns 401 with code TOKEN_EXPIRED instead of throwing, and add a test that asserts the 401. Done when the new test passes and the existing suite stays green.", "expected": {"type": "work-request", "verdict": "Actionable", "fires": false}, "note": "positive control — should NOT fire"},
    {"id": "RQ5", "prompt": "Rename the function calcTax to calculateTax across the billing module and update its one caller in checkout.ts; no behaviour change, existing tests must still pass.", "expected": {"type": "work-request", "verdict": "Actionable", "fires": false}, "note": "positive control 2 — should NOT fire"},
    {"id": "RQ6", "prompt": "I want to get the codebase healthy this quarter", "expected": {"type": "goal", "route": "assess-goal", "fires": false}, "note": "goal — gated out to assess-goal"}
  ]
}
```

- [ ] **Step 2: Validate JSON.** Run:

```bash
python3 -c "import json,sys; d=json.load(open('evals/request-quality/evals.json')); print('OK', len(d['evals']), 'evals')"
```
Expected: `OK 6 evals`

- [ ] **Step 3: Commit.**

```bash
git add evals/request-quality/evals.json
git commit -m "test(request-quality): add seed eval set (#36)"
```

---

### Task 3: Run the seed evals (behavioral) and score

**Files:**
- Create: `evals/request-quality/results-2026-06-29.md`

**Interfaces:**
- Consumes: `SKILL.md` (Task 1), `evals.json` (Task 2).

- [ ] **Step 1: Run each eval.** For each entry, spawn an independent subagent that is given ONLY the skill's `SKILL.md` and the prompt, and asked to apply the skill and return JSON `{type, fires, verdict?, route?, N?}`. (Same independent-subagent method as `evals/routing/README.md`.)

- [ ] **Step 2: Score against `expected`.** Each eval passes if `type`, `fires`, and (`route` or `verdict`/`N_min`) match. Write `results-2026-06-29.md` as a scorecard table.

- [ ] **Step 3: Gate.** If any eval fails, fix the `SKILL.md` wording (not the eval) and re-run — the eval encodes the spec's intent. Pass condition: **6/6 evals route/score as labelled** (RQ1 fires Under-specified N≥2; RQ2→merge-gate; RQ3→tickets; RQ4/RQ5 Actionable, don't fire; RQ6→assess-goal).

- [ ] **Step 4: Commit.**

```bash
git add evals/request-quality/results-2026-06-29.md skills/assess-request-quality/SKILL.md
git commit -m "test(request-quality): seed evals pass 6/6 (#36)"
```

---

### Task 4: Routing regression (no cross-fire)

**Files:**
- Modify: `evals/routing/skill_descriptions.md`, `evals/routing/evals-hard.json`
- Create: `evals/routing/results-rq-regression-2026-06-29.md`

**Interfaces:**
- Consumes: the new skill description (Task 1).

- [ ] **Step 1: Refresh the descriptions snapshot** to include the new skill — run the refresh command in `evals/routing/README.md` (it globs `skills/yegor-*` → extend it, or append the new skill's name+description block manually so the router sees it).

- [ ] **Step 2: Add 3 probe prompts** to `evals/routing/evals-hard.json` that sit on the new skill's seams:
  - a vague casual request → `expected_primary: assess-request-quality`
  - an already-filed GitHub issue review ask → `expected_primary: issue-review-skill` (must NOT steal it)
  - a personal goal → `expected_primary: assess-goal` (must NOT steal it)

- [ ] **Step 3: Re-run the router harness** (per `evals/routing/README.md`) over the probes. Pass condition: the vague request routes to `assess-request-quality`, and the issue-review / goal probes do **not** cross-fire to it.

- [ ] **Step 4: Write `results-rq-regression-2026-06-29.md` and commit.**

```bash
git add evals/routing/skill_descriptions.md evals/routing/evals-hard.json evals/routing/results-rq-regression-2026-06-29.md
git commit -m "test(routing): add assess-request-quality regression, no cross-fire (#36)"
```

---

### Task 5: Wire into family indexes

**Files:**
- Modify: `README.md`, `GLOSSARY.md`, `skills/yegor-pm/SKILL.md`

**Interfaces:**
- Consumes: the finished skill.

- [ ] **Step 1:** Add a one-line entry for `assess-request-quality` to `README.md` (skills list) and `GLOSSARY.md`, and add it to the `yegor-pm` router's sub-skill list/table with its one-line "when to use" + the `issue-review-skill` boundary.

- [ ] **Step 2: Verify wiring.** Run:

```bash
grep -rl 'assess-request-quality' README.md GLOSSARY.md skills/yegor-pm/SKILL.md | wc -l
```
Expected: `3`

- [ ] **Step 3: Commit.**

```bash
git add README.md GLOSSARY.md skills/yegor-pm/SKILL.md
git commit -m "docs: wire assess-request-quality into family indexes (#36)"
```

---

### Task 6: Verify build definition-of-done & hand off

- [ ] **Step 1:** Walk the spec's build-DoD checklist (§Deliverable, paths & build definition-of-done). Confirm items 1–3 and 5 (item 4, quote-verification, already retired by the citation vet). All boxes ticked.
- [ ] **Step 2:** Confirm the two out-of-scope follow-ons are still tracked (H3/H4 relabel; eval-rubric "weak→assess" outcome) — do NOT do them here.
- [ ] **Step 3:** Stop. Closing the ticket (`pmtools close 36`, which lands on origin/main) is the user's call — do not auto-close.

---

## Self-Review

- **Spec coverage:** gate (Task 1.2.2), disambiguation (1.2.3), 6 checks (1.2.4), trigger split (1.2.5), no-fabrication+tiered (1.2.6), output format (1.2.7), grounding (1.2.8), seed evals incl. gate-out + positive controls (Task 2/3), routing regression (Task 4), index wiring (Task 5), DoD (Task 6). All spec sections map to a task.
- **Placeholder scan:** the frontmatter `description` is concrete; eval prompts are concrete; verification commands are exact. The SKILL.md body steps point to spec sections by number rather than re-pasting the rubric — intentional (the spec is the committed source of truth in this same repo; re-pasting would duplicate and risk drift).
- **Type consistency:** verdict labels (`Actionable` / `Under-specified`), `type` values (work-request/goal/question/complaint), and the `N`/`M` symbols match the spec and are used identically across tasks.
