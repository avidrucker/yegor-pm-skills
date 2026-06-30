---
name: assess-request-quality
description: Diagnose whether an incoming work-request — a casual task handed to an agent, a ticket, or an ask handed to a teammate — is clear enough to act on, before guessing. Runs a gate (request vs goal vs question vs complaint), counts how many materially-different deliverables the request could mean, and checks six concrete elements (target, now-state→outcome, done-check, acceptor, bounds), then emits the specific clarifying questions to close the gaps rather than fabricating a sharper version. Use when a handed-over task/request is genuinely ambiguous or visibly thin, or the user asks "is this clear enough to act on?", "what's missing from this ask?", "sharpen this request before we start" — lean toward firing on vague casual requests like "just make X better / less broken". NOT for personal goals (use assess-goal), already-filed GitHub issues (use issue-review-skill), or pure conceptual questions.
---

# assess-request-quality

Diagnose whether an incoming work-request is actionable, using **objective measurements** rather than subjective quality scores, and emit the **specific questions** needed to make it actionable — instead of fabricating a sharper version from information that isn't there. Composes with `assess-goal` (for goals) and the content skills (for questions/complaints) rather than duplicating them.

**Boundary with `issue-review-skill`:** `issue-review-skill` reviews an **already-filed GitHub issue** for process/agent-readiness; `assess-request-quality` diagnoses a **live, in-conversation request** before it's even a ticket.

## Front Gate — classify before scoring

Two of the three motivating cases for this skill were not work-requests at all. Skipping this gate mis-frames them. Classify first; run diagnostics only on actual work-requests.

| Input is… | Route |
|---|---|
| **Goal** (a personal objective/intention) | → `assess-goal` |
| **Question** (asks for info/explanation) | → answer / relevant content skill (e.g. "what is done-done?" → `yegor-merge-gate`) |
| **Complaint** (a gripe with no concrete ask) | → emit one "complaint" verdict, then route by subject: software defect → `yegor-bdd`; process/decision → `yegor-tickets`; **both** if mixed |
| **Work-request** (asks for work to be done) | → run the diagnostics below |

**Assertion test (gate refinement):** a request phrased as a question or musing ("could we maybe look into…?") is not yet a request — it's a discussion. Flag it "not-yet-a-request: restate as an assertion of what should be done," and don't run the diagnostics until it is one. (Yegor's spec-mistake #2: "Specifications can't have any questions in them.")

The gate stays deliberately simple: its job is to **not score non-requests**, not to perfectly triage them.

## Diagnostic 1 — Disambiguation Test (core measurement)

Enumerate the materially-different deliverables a competent doer could hand back given this exact request.

- **0–1 reading** → unambiguous on intent.
- **≥2 readings** → under-specified; **the divergent readings ARE the clarifying questions.**

Output: the count `N` and the list.

Example — "make this test suite less embarrassing" → N=4: rename tests / add coverage / de-mock / speed up.

## Diagnostic 2 — Binary Presence Checklist (backup measurement)

Each check is yes/no, answerable by pointing at the request's literal text — no taste scores.

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

## Verdict + Trigger Split

Report `N` readings and `M/6` present.

- **Full pass (Actionable):** `N ≤ 1` AND `M = 6/6` — perfect clarity. This is the **gate-mode** bar.
- **Speak-up trigger (everyday / suggest-mode):** fire on **real ambiguity — `N ≥ 2`** — *not* on `M < 6/6`. Rationale: almost no real request scores 6/6, so triggering on imperfection makes the skill a nag; triggering on genuine ambiguity (two-plus valid readings) makes it speak up only when it matters.
- In suggest-mode, surface **only the single most-divergent gap-question**, not all six checks. The full 6/6 checklist is reserved for gate-mode and for an explicit "what's missing?" request.

**Perfect-or-spike rule** (governs gate-mode) — the only honest reasons to proceed below 6/6:
1. A missing fact is **knowable now** → emit gap-questions, get it, then proceed. (most cases)
2. A missing fact is **irreducible until work begins** (what's actually slow, where the bug lives, which approach is viable) → this is not a defective request, it's a **spike**: route to `yegor-spikes`, don't penalize it.
3. **Explicit, recorded waiver** — in suggest-mode the user may knowingly accept a *named* gap; the skill records which gap was waived, so it's a visible decision, never a silent shortcut.

## No-Fabrication Rule

- **Actionable:** say so; optionally restate it crisply using **only** the facts given.
- **Under-specified:** list the divergent readings + the missing checklist items as **pointed gap-questions**. Do **not** invent a rewrite. **Never** produce a finished rewrite from insufficient information. Only after the human answers do we assemble the sharpened request from their answers.

## Tiered Behavior

- **Default (suggest):** fire only on real ambiguity (`N ≥ 2`); surface the single most-divergent gap-question; then proceed best-effort if the user still wants. Light touch — never a six-point interrogation.
- **Gate (opt-in):** on explicit "strict" mode, or a destructive / expensive / irreversible task — apply the full `6/6` bar and stop until the gaps are filled.

## Output Format

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

## Grounding Anchors (Yegor doctrine — verified citations only)

All quotes verified against source pages in citation vet (2026-06-29). Present as Yegor's normative methodology claims, not as proven empirical facts.

- **A→B formula** — the Yegor doctrine holds: a request should say "what we *have*, what we *should have* instead" / "asking the project to move from point A to point B." ([Five Principles of Bug Tracking](https://www.yegor256.com/2014/11/24/principles-of-bug-tracking.html)) — grounds checks 2 and 3.
- **Done = author acceptance** — "the task is done iff its author accepts the deliverables." ([Definition Of Done](https://www.yegor256.com/2014/04/15/definition-of-done.html)) — grounds check 5.
- **0/100 rule** — "either 'in progress' or 'complete'. There can be nothing in the middle." ([How Micro Is Your Tasking?](https://www.yegor256.com/2017/11/28/microtasking.html)) — grounds check 4.
- **"inability to define what we expect"** — the doctrine holds that definition-of-done, exit criteria, requirements, and expectations are "all about our inability to define what exactly we expect programmers to do." ([How Micro Is Your Tasking?](https://www.yegor256.com/2017/11/28/microtasking.html)) — license for the skill's core thesis.
- **Outcome not mechanism** — "You shouldn't tell me how to implement the functionality you desire." ([10 Typical Mistakes in Specs](https://www.yegor256.com/2015/11/10/ten-mistakes-in-specs.html)) — grounds check 3's mechanism-only rejection.
- **No questions in a spec** — "Specifications can't have any questions in them." ([10 Typical Mistakes in Specs](https://www.yegor256.com/2015/11/10/ten-mistakes-in-specs.html)) — grounds the assertion test.
- **Name the actor** — "A good user story always has … a user." ([10 Typical Mistakes in Specs](https://www.yegor256.com/2015/11/10/ten-mistakes-in-specs.html)) — grounds check 5 (acceptor).
- **Actor/victim framing** — say "I can't use the class," not "the class is broken." ([The Right Way to Report a Bug](https://www.yegor256.com/2018/04/24/right-way-to-report-bugs.html)) — grounds check 5.
- **Ask up front, don't assume** — "Ask any and all questions of the task author in advance." and "Don't assume anything—ask if you're not sure." (two separate lines, [Definition Of Done](https://www.yegor256.com/2014/04/15/definition-of-done.html)) — direct endorsement of gap-questions over a fabricated rewrite.

## Cross-references

- `assess-goal` — for personal goals (not work-requests)
- `issue-review-skill` — for already-filed GitHub issues (not live requests)
- `yegor-bdd` — for software defect complaints
- `yegor-tickets` — for process/decision complaints
- `yegor-spikes` — when the code (not the request) is fuzzy and investigation is needed
