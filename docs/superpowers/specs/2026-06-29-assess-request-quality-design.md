# assess-request-quality — design spec

**Date:** 2026-06-29 · **Status:** design (pre-implementation) · **Origin:** routing finding #31 → spike #33.

## Purpose

Diagnose whether an incoming **work-request** is actionable, using **objective measurements** rather than subjective quality scores, and emit the **specific questions** needed to make it actionable — instead of fabricating a sharper version from information that isn't there. Composes with `assess-goal` (for goals) and the content skills (for questions/complaints) rather than duplicating them.

## Why (motivation, grounded)

- **#31 routing finding:** agents under-handle vague, casual work-requests (case H2: *"make this test suite less embarrassing"*).
- **Spike #33:** `assess-goal` does **not** cleanly cover work-requests — 4 misfires: (1) its *Responsible* axis is a free pass for any handed-off task, (2) its *Time-bound* axis penalizes clear-but-undated requests, (3) its "rewrite SMART" step **fabricates** on a vague request (the "dart in the dark"), (4) it has no disambiguation step. The novel, reusable value is the **disambiguation test**.
- **Design principle that fixes the subjectivity objection:** every check must be answerable by pointing at the request's literal text. No 1–5 taste scores.

**Yegor grounding (research spike #34, all source-verified):**
- *A→B formula* — "This is what we *have*, this is what we *should have* instead, so fix it" / "asking the project to move from point A to point B" ([Five Principles of Bug Tracking](https://www.yegor256.com/2014/11/24/principles-of-bug-tracking.html)).
- *Done = author acceptance* and the *0/100 rule* ([Definition Of Done](https://www.yegor256.com/2014/04/15/definition-of-done.html), [How Micro Is Your Tasking?](https://www.yegor256.com/2017/11/28/microtasking.html)).
- *"Definition of done / exit criteria / requirements / expectations … are all about our inability to define what exactly we expect"* — license for the skill's core thesis ([How Micro Is Your Tasking?](https://www.yegor256.com/2017/11/28/microtasking.html)).
- *Outcome not mechanism* ("You shouldn't tell me how to implement the functionality you desire"), *no questions in a spec* ("Specifications can't have any questions in them"), *name the actor* ("A good user story always has … a user") ([10 Typical Mistakes in Specs](https://www.yegor256.com/2015/11/10/ten-mistakes-in-specs.html) — note: 9 mistakes, not 10).
- *Actor/victim framing* — say "I can't use the class," not "the class is broken" ([The Right Way to Report a Bug](https://www.yegor256.com/2018/04/24/right-way-to-report-bugs.html)).
- *Ask up front, don't assume* — "Ask any and all questions of the task author in advance" and "Don't assume anything—ask if you're not sure" (two separate lines) — direct endorsement of gap-questions over a fabricated rewrite ([Definition Of Done](https://www.yegor256.com/2014/04/15/definition-of-done.html)).

## Scope / non-goals

- **In scope:** a single incoming work-request — a casual message to an agent, a ticket, or a task handed to a person.
- **Out of scope (route elsewhere):** personal goals → `assess-goal`; conceptual questions → the relevant content skill; a complaint with no ask → `yegor-bdd` (software defect) or `yegor-tickets` (process/decision); readiness/process-review of an *already-filed GitHub issue* → `issue-review-skill`.
- **Hard non-goal:** producing a finished rewrite from insufficient information. The skill never invents missing facts.

## Architecture

### Front gate — classify before scoring

The spike's biggest finding: 2 of 3 motivating cases weren't work-requests. Skipping this gate mis-frames them (exactly as `assess-goal` did). So classify first:

| Input is… | Route |
|---|---|
| **Goal** (a personal objective/intention) | → `assess-goal` |
| **Question** (asks for info/explanation) | → answer / relevant content skill (e.g. "what is done-done?" → `yegor-merge-gate`) |
| **Complaint** (a gripe with no concrete ask) | → emit one "complaint" verdict, then route by subject: software defect → `yegor-bdd`; process/decision → `yegor-tickets`; **both** if mixed |
| **Work-request** (asks for work to be done) | → run the diagnostics below |

**Assertion test (gate refinement, Yegor spec-mistake #2):** a request phrased as a question or musing ("could we maybe look into…?") is not yet a request — it's a discussion. Flag it "not-yet-a-request: restate as an assertion of what should be done," and don't run the diagnostics until it is one.

The gate stays deliberately simple: its job is to **not score non-requests**, not to perfectly triage them. It never forces a brittle defect-vs-decision branch — that routing happens in one downstream step (council convergence, 2026-06-29). 

### Diagnostic 1 — disambiguation test (core measurement)

Enumerate the materially-different deliverables a competent doer could hand back.
- **0–1 reading** → unambiguous on intent.
- **≥2 readings** → under-specified; **the divergent readings ARE the clarifying questions.**

Output: the count `N` and the list. (H2 → N=4: rename / add coverage / de-mock / speed up.)

### Diagnostic 2 — binary presence checklist (backup measurement)

Each item is yes/no, answerable from literal text — no taste. Six checks (Yegor grounding from research spike #34 in brackets):

| Check | Objective test | Grounding |
|---|---|---|
| **1. Target named?** | a concrete referent (path / function / URL / ticket-id), not "this" / "the code" | skill |
| **2. Now-state (A)?** | does it say what currently happens / what's wrong? | A→B formula |
| **3. Outcome observable (B)?** | strip evaluative adjectives (better/cleaner/embarrassing) *and* reject mechanism-only ("add Redis" with no "loads <1s") — is a concrete, observable end-state left? | A→B; "state the outcome, not the how" |
| **4. Done-check named?** | a stated way to verify — test/number/command/artifact — with a nameable *single moment* it flips to done (0/100 rule) | Definition-of-Done; 0/100 |
| **5. Acceptor named?** | who observes the outcome and signs off — the author who *accepts* the deliverable | "done = author acceptance"; actor/victim |
| **6. Bounds given?** | any statement of size, or what's explicitly in / out | skill's own (no direct Yegor source — labelled honestly) |

Checks 2 and 3 are the **A→B pair** — a target with no current-state, or a current-state with no observable target, is malformed even if each alone reads fine.

Score = count present, `M/6`.

### Verdict — two numbers, plus a trigger/verdict split (no subjective score)

- Report `N` readings and `M/6` present.
- **Full pass (Actionable):** `N ≤ 1` AND `M = 6/6` — perfect clarity. This is the **gate-mode** bar.
- **Speak-up trigger (everyday / suggest-mode):** fire on **real ambiguity — `N ≥ 2`** — *not* on `M < 6/6`. Rationale (pre-mortem 2026-06-29, user-approved, provisional): almost no real request scores 6/6, so triggering on imperfection makes the skill a nag; triggering on genuine ambiguity (two-plus valid readings) makes it speak up only when it matters.
- In suggest-mode, surface **only the single most-divergent gap-question**, not all six checks. The full 6/6 checklist is reserved for gate-mode and for an explicit "what's missing?" request.

**Perfect-or-spike rule** (governs gate-mode) — the only honest reasons to proceed below 6/6:
1. A missing fact is **knowable now** → emit gap-questions, get it, then proceed. (most cases)
2. A missing fact is **irreducible until work begins** (what's actually slow, where the bug lives, which approach is viable) → this is not a defective request, it's a **spike**: route to `yegor-spikes`, don't penalize it.
3. **Explicit, recorded waiver** — in suggest-mode the user may knowingly accept a *named* gap; per Yegor's "name the concession," the skill records which gap was waived, so it's a visible decision, never a silent shortcut.

### Output and the no-fabrication rule

- **Actionable:** say so; optionally restate it crisply using **only** the facts given.
- **Under-specified:** list the divergent readings + the missing checklist items as **pointed gap-questions**. Do **not** invent a rewrite. Only after the human answers do we assemble the sharpened request from their answers.

### Tiered behavior (suggest by default, gate on request)

- **Default (suggest):** fire only on real ambiguity (`N ≥ 2`); surface the single most-divergent gap-question; then proceed best-effort if the user still wants. Light touch — never a six-point interrogation.
- **Gate (opt-in):** on explicit "strict" mode, or a destructive / expensive / irreversible task — apply the full 6/6 bar and stop until the gaps are filled.

## Output format (mirrors `assess-goal` house style)

```
Request: "<restated as given>"
Type:    work-request   (gate: not a goal / question / complaint)

Readings (divergence): N
  - <reading 1>
  - <reading 2> …

Presence:
  1. Target named?        ✅/❌  <cite the request's words>
  2. Now-state (A)?       ✅/❌  <cite>
  3. Outcome observable(B)?✅/❌  <cite>
  4. Done-check named?    ✅/❌  <cite>
  5. Acceptor named?      ✅/❌  <cite>
  6. Bounds given?        ✅/❌  <cite>

Verdict: <Actionable | Under-specified>  (N readings, M/6 present)

Gap-questions (answer these to make it actionable):
  1. …
  2. …
```

## Triggering (frontmatter description — final)

- **Fire when:** a handed-over task/request/ticket is **genuinely ambiguous** (could mean two-plus different things) or visibly thin; or the user asks "is this clear enough to act on?", "what's missing from this ask?", "sharpen this request before we start". Lean toward firing on vague *casual* requests ("just make X better / less broken") — those are the ones agents otherwise silently guess at.
- **Don't fire when:** it's a personal goal (→ `assess-goal`), a clearly well-formed/unambiguous request, or a pure conceptual question.
- **Boundary vs `issue-review-skill` (load-bearing — nearest neighbour):** `issue-review-skill` reviews an **already-filed GitHub issue** for process/agent-readiness; `assess-request-quality` diagnoses a **live, in-conversation request** before it's even a ticket. One line in *each* description must state this split (pre-mortem Risk-4 fix).
- **Other boundaries:** `assess-goal` (goals) · `yegor-bdd` (bug-complaint shape) · `yegor-spikes` (the *code* is fuzzy → investigate, vs the *request* is fuzzy → clarify).

## Deliverable, paths & build definition-of-done

- **Path:** `skills/assess-request-quality/SKILL.md` — a single file, **no `references/` or `scripts/`** (a rubric skill like `assess-goal`).
- **Eval set:** `evals/request-quality/evals.json` (the seed set below).
- **Frontmatter:** `name: assess-request-quality` + a final, trigger-pushy `description` (see Triggering).
- **Build definition-of-done (0/100 — the skill is *done* when):**
  1. `skills/assess-request-quality/SKILL.md` exists with the frontmatter above and the full rubric (gate → disambiguation → 6 checks → verdict → no-fabrication → tiered).
  2. All seed evals route as labelled (H2 under-specified; H3→merge-gate; H4→tickets; positive controls don't fire; goal→assess-goal).
  3. The routing regression passes (no cross-fire with `issue-review-skill` / `assess-goal`).
  4. The 2–3 load-bearing Yegor quotes are spot-verified against their source URLs.
  5. It's wired into the family indexes (`README.md`, `GLOSSARY.md`, `yegor-pm` router) — or a conscious note says why not.

## Build constraints (from the pre-mortem)

- **Time-box v1 to one sitting; ship minimal as the spike.** No new scope mid-build. Expansion (calibration set, extra checks) is gated on real-usage evidence — the skill is itself a modest-ROI request, so it follows its own ship-minimal-to-learn doctrine.
- **Anti-fabrication at build:** verify Yegor quotes; quote exactly or paraphrase-and-attribute, never invent.
- **Track usage:** if the skill never fires in real sessions within a few weeks, retire it rather than maintain a non-firing skill.

## Testing / evals

Seed eval set (behavioural):
- **H2** — under-specified work-request (expect N=4, M=0/6; suggest-mode surfaces the top gap-question only).
- **H3** — question → gate routes to `yegor-merge-gate` (not scored).
- **H4** — process complaint → gate routes to `yegor-tickets` (not scored).
- **Positive controls** — 2–3 well-formed, unambiguous requests that should **not** fire / pass Actionable.
- **A goal** — should be gated out to `assess-goal`.

**Routing regression (pre-ship, pre-mortem Risk-4):** add `assess-request-quality` to `evals/routing/evals-hard.json` and re-run the router harness — confirm it does **not** cross-fire with `issue-review-skill` / `assess-goal`, and that the positive controls don't trigger it. Closes the loop with #31: the skill must not worsen the routing it was born from.

## Follow-on work (tracked separately)

- **Correct the round-2 eval:** relabel H3/H4 in `docs/skills-eval-findings.md` from "under-trigger miss" to "content-routing (merge-gate / tickets)" — a fix owed regardless of this skill.
- **Eval rubric upgrade:** add a "weak → assess/clarify" expected-outcome to the routing eval, so a prompt-quality response can score as correct.

## Resolved decisions (2026-06-29)

1. **Two-level threshold:** full pass = `N ≤ 1` AND `M = 6/6` (gate-mode); everyday speak-up triggers on **real ambiguity `N ≥ 2`**, not on imperfection. Perfect-or-spike governs gate-mode. *(was: single perfect threshold; revised by pre-mortem)*
2. **Gate emits one "complaint" verdict, routes by subject downstream** (defect→bdd, decision→tickets, both if mixed) — keeps the gate simple. *(council convergence)*
3. **Lives in the `yegor-pm-skills` repo**, Yegor-grounded framing.

## Resolved decisions (2026-06-29, cont.)

4. **6th check = ACCEPTOR** (who observes the outcome and signs off), from research #34 — supersedes the earlier "reporter effort" idea (which overlapped `yegor-bdd`). Threshold is now `M = 6/6`.
5. **Research #34 folded in**: A→B pairing (checks 2–3), 0/100 + author-acceptance (checks 4–5), outcome-not-mechanism (check 3), assertion-test gate refinement, and grounding anchors. `bounds` (check 6) is labelled the skill's own contribution — no direct Yegor source.
6. **Trigger decoupled from the perfect bar** (`N ≥ 2` to speak up; 6/6 only in gate-mode) — pre-mortem Risk-2 fix, user-approved 2026-06-29 (provisional, revisit with usage).
7. **Build is time-boxed and minimal** (pre-mortem): ship v1 from this spec in one sitting; verify Yegor quotes; add to the routing eval; wire into indexes; track usage; expand only on real-usage evidence.

## Review trail

Spec hardened by three passes (2026-06-29):
1. `issue-review-skill` (verdict NEEDS WORK 12/15 → all three required changes — build DoD, file paths, final frontmatter — folded in).
2. `murphy-jutsu` + `murphy-complexity-invoice` pre-mortem (6 risks; the nag-risk and tool-becomes-project risk drove the trigger split and the time-boxed-minimal build constraint).
3. `author-vet-this-source` on the Yegor citations: **no fabrications**; 7 quotes verbatim-verified; 2 paraphrases-dressed-as-quotes (A→B; "don't assume") corrected to real wording; 1 mis-attributed source (`right-way-to-report-bugs` → re-homed from A→B to actor/victim). This **retires build-DoD item 4** (quotes are now pre-verified).

## Open questions (resolve during implementation)

- Calibration set still to assemble (4–6 good *and* bad requests) to validate the perfect 6/6 threshold and seed the skill's worked examples.
- Whether `bounds` (check 6, unsourced) earns its place or should be dropped/replaced once the calibration set is in.
