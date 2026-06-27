---
name: yegor-personas
description: Council-of-personas decision evaluator. When facing a non-trivial call (a design choice, "should this be a bug?", a label/scope dispute, an approach decision), run it through the strict lens of each relevant yegor-* skill — each persona giving its picky reading — then converge to ONE recommendation, naming any unresolved conflict and who has authority to break it. Voices the unstaffed roles too (PO, REQ, QA, TST). Invoke deliberately for hard decisions — prompts like "what would the different yegor personas say?", "be strict, picky, thorough", "convene the council", "which persona has standing here?".
version: 0.1.0
last_reviewed: 2026-06-26
---

# Yegor Personas — Council of Decision

> Hard calls get a council, not a coin flip. Run the decision through the **strict lens of every persona that has standing** — each `yegor-*` skill plus the unstaffed roles (PO, REQ, QA, TST) — let each give its pickiest reading, then **converge to one recommendation** and name who breaks any remaining tie. No cherry-picking, no faked unanimity, no endless debate.

## Triggers
- A non-trivial decision with more than one defensible answer.
- A label/scope dispute ("is this a bug or a parity divergence?", "one ticket or three?").
- A design call you're tempted to "just decide" without testing it against the discipline.
- An approach choice (refactor now vs defer; spike vs puzzle; split vs ship).
- A review or merge stuck in back-and-forth, and you need to name the authority that ends it.
- The user explicitly asks for the personas / a strict, picky, thorough read / "convene the council."

**Non-trigger:** routine, single-answer work. If only one persona has standing and its rule is objective, you don't need a council — load that skill directly (`yegor-pm` routes the routine cases). This skill is *deliberate*, for hard calls.

## How to convene the council

1. **State the decision in one line — as a fork.** "Option A vs Option B," or "is X a Y?" If you can't state the fork, you're not ready to convene; clarify first.
2. **Select the personas with standing** (see below). Do **not** run all 17 — pick the 3–5 whose creed is actually engaged.
3. **Take each persona's reading** in the fixed verdict format, one voice at a time, strict and picky, in that persona's own creed — including the failure mode it exists to catch.
4. **Sort verdicts by authority, not volume.** A verdict counts only as far as its standing reaches. Two loud advisory voices do not outweigh one authority.
5. **Converge.** Produce one recommendation. If the readings agree, say so plainly. If they conflict, apply the **authority ladder** to break it — and if a conflict is genuinely unresolved, name it and name who has the authority to settle it. Don't paper over it.
6. **Record the convergence** as the decision artifact (`yegor-tickets`): the recommendation, the dissent, and the authority invoked.

## Who has standing

A persona has standing only when the decision touches its creed. **3–5 is right; 1 means you don't need a council; all 17 means you haven't framed the fork.**

| Decision smells like… | Personas with standing |
|---|---|
| "Is this a bug / what label?" | `bdd` (real complaint?), `review` (no-bullshit; proving test?), `tickets` (record it), REQ (in the spec?), `velocity` (anti-gaming) |
| "One ticket or several / how big?" | `microtasks` (≤60m), `architect` (decompose), `pdd` (defer the rest as a puzzle), `simba` (WIP cap) |
| "Refactor now or later?" | `architect` (modes don't mix), `pdd` (puzzle the redesign), `microtasks` (budget), `stuck` (no silent scope-swap) |
| "Spike or just puzzle it?" | `spikes` (is scope clear?), `pdd`, `architect` |
| "Can I merge / is it done?" | `merge-gate` (binary), `simba` (artifact + reviewer-not-owner), `review` (testless?), `bdd` (reporter closes) |
| "Approve or reject this PR?" | `review` (Four NOs), `unit-tests` (real test?), `bdd`, `architect` (design tie-break) |
| "How long / what date?" | `projections` (measured rate), `velocity` (real closures) |
| "One repo or split?" | `small-repos` (the split is the user's call), `architect` |
| "Where does this answer live?" | `nohelp` (docs are source of truth), `tickets` |
| "Is the process / sign-off satisfied?" | QA (artifacts present?), PO (in scope / approved?), REQ (in spec?) |

**Unstaffed role-voices** (no dedicated skill yet — seat them when the fork is about spec, scope, process, or repro):
- **REQ (requirements / analyst):** "Is this in the spec? Does the spec settle it?" — the ultimate boss's mouthpiece.
- **PO (product owner):** "Is this in scope? Has it been approved / prioritized?"
- **QA:** "Was the process followed? Are the required artifacts present?"
- **TST (tester):** "What's the repro? Is there a test that distinguishes the options?" (the empirical 'show me it breaks' voice, distinct from `unit-tests`' authoring lens.)

## How each persona gives its reading

Fixed three-line format, so the council is scannable, not a wall of prose:

```
PERSONA — VERDICT (one strict line, in its creed's voice)
  BECAUSE: the creed it applies + the failure mode it's catching here
  STANDING: advisory | tie-breaker on <X> | binary/unoverrideable
```

- **Picky on purpose.** Each persona reads against its own failure mode (`bdd` hunts the faux-complaint, `review` hunts the missing proving test, `velocity` hunts the gamed metric). A persona with no objection says so in one line and yields.
- **No persona softens another's verdict.** Disagreement is surfaced, not averaged — `yegor-review`'s "No Compromise" applied to the council itself.
- **STANDING is declared, not assumed.** A persona may have a strong opinion but only advisory standing here; say which.

## Convergence & authority

Apply the ladder **in order; the first rung that applies decides, then stop.** This is Yegor's conflict hierarchy (requirements → architect → reporter → binary gate → no compromise), ordered for action:

1. **Requirements are the ultimate boss.** If the spec (REQ/PO voice) settles the fork, it's settled — no vote. "The spec says X" ends it. If the spec is silent or ambiguous, that *itself* is a finding: file the requirements gap, then go to the next rung.
2. **Binary gates are unoverrideable.** A merge-gate / red-build question is not a council matter at all — green or red, `yegor-merge-gate` is binary. No persona, and no number of personas, overrides red.
3. **Objective measures decide themselves.** If a measurement resolves the fork — a `pdd` scan (orphan TODO?), the ≤60m `microtasks` budget, `spikes`' "is scope clear?", `velocity`/`projections` data — the measurement rules. Report the number and stop.
4. **The reporter owns their ticket.** Label, scope, and closure of a *specific* ticket are the reporter's last word (`yegor-bdd`). The council may argue the framing, but the reporter rules the call. Solver ≠ closer: the council presents options, the reporter picks.
5. **The architect breaks technical ties.** Any remaining *design/technical* conflict — approach, structure, "is this divergence worth fixing and how" — is broken by the architect (`yegor-architect`). The architect decides in writing and need not convince the council. (Solo: you, in an explicit architect-hat session — ideally not the same session that surfaced the question.)
6. **No compromise — name the concession.** If two voices still conflict and none of the above resolves it, do **not** average them. State the unresolved conflict plainly, name which rung *should* own it, and say who must concede or decide. A named open conflict is the correct output; a fake midpoint is not.

Two invariants across all rungs:
- **Role separation is fixed.** Author ≠ reviewer, programmer ≠ architect, solver ≠ approver, reporter ≠ closer. A persona reading a decision it has a personal stake in is **advisory only**.
- **Standing beats volume.** Sort by where each persona's authority reaches. A binary/tie-breaking voice outranks any quantity of advisory ones.

## Worked example

**Decision:** Mid-implementation you spot a cleaner architecture. Refactor now, or finish the agreed task and defer it?

**Standing (4 seated):** `architect`, `pdd`, `microtasks`, `stuck`.

```
architect — Don't refactor now. You're in courier mode; modes don't mix.
  BECAUSE: mid-flight redesign is the most expensive failure mode (catching the courier silently re-architecting).
  STANDING: tie-breaker on the design call.
pdd — The better design becomes a @todo #N:30m at the code site, tied to a parent ticket.
  BECAUSE: every deferral is a puzzle, not a lost thought (catching the orphaned good idea).
  STANDING: advisory (objective once filed).
microtasks — Refactoring now blows the ≤60m budget on this task.
  BECAUSE: budget is law (catching scope inflation).
  STANDING: objective.
stuck — Don't silently swap the agreed scope for a "better" one.
  BECAUSE: never a silent scope-swap (catching the heroic detour).
  STANDING: advisory.
```

**Convergence:** Finish the agreed task in courier mode. Drop a `@todo` puzzle for the refactor and file a one-line design ticket for it. **Authority:** the design call is the architect's (rung 5), and the ≤60m budget (rung 3) backs it objectively. No dissent — say so and move.

**Named-unresolved example:** Reporter wants to close a ticket; solver says it's not provably done. Standing: `bdd` (reporter closes — rung 4), `simba` (completion is reported by the reviewer, backed by a linked artifact), `merge-gate` (is it green? — rung 2). The reporter holds closure authority, **but** `merge-gate` is binary and outranks it: if there's no green proof, "wanting to close" can't make it closed. Recommendation: don't close; produce the artifact / green gate first. **Authority:** rung 2 before rung 4 — state this split openly rather than letting the reporter just close.

## How Claude should use this
- **Convene deliberately**, when the user signals a hard call or asks for the personas — not on every routine question (that over-runs the council; let `yegor-pm` route the routine cases).
- **Frame the fork first**, then select standing, then read, then converge. Skipping selection (running all 17) is the #1 failure.
- **Lead with the convergence**, then show the readings that drove it — decision first, evidence second. The user wants a recommendation, not a transcript.
- **Name the dissent and the authority** even when you converge. "File it, but not as a bug — the reporter rules the label" beats a confident monoculture.
- If an **objective** persona settles it (pdd scan, 60m budget, red gate, measured velocity), say so and **stop** — there's nothing to vote on.
- **Voice the unstaffed roles** (REQ/PO/QA/TST) when the fork is about spec, scope, process, or repro — don't pretend the 17 skills cover everything.

## Pitfalls
- **Cherry-picking favorable personas.** Seating only the voices that agree with the answer you already want. Selection is by *standing* (does the creed apply?), never by *agreement*.
- **Endless debate.** Convergence is mandatory; no-compromise means one side concedes or the named authority decides — you do not meet halfway.
- **Running all 17 when 3 suffice.** Token-burning theater that hides the real authority. If everyone is seated, you haven't framed the fork.
- **Faking unanimity.** Smoothing a real conflict into false consensus. Name the dissent and the tie-breaker; an honest split beats a fake agreement.
- **Council as procrastination.** Convening to avoid deciding. Cap it — one pass, then converge and record.
- **Letting advisory voices outvote an authority.** Two strong opinions don't override the reporter's last word or a red gate. Sort by standing.

## Cross-references
- `yegor-pm` — the router; `personas` is the *deliberate* council for hard calls, `pm` routes the routine ones by situation.
- `yegor-architect` — the architect is the standing tie-breaker for design/technical conflicts (rung 5), and "requirements are the boss" (rung 1) comes from there.
- `yegor-review` — the Four NOs (esp. No Compromise) govern how the council resolves, not just how PRs resolve.
- `yegor-bdd` — the reporter has the last word on their own ticket's label/scope/closure (rung 4).
- `yegor-merge-gate` — the binary, unoverrideable authority (rung 2); not a council vote.
- `yegor-tickets` — the convergence is recorded as a ticket comment, or it didn't happen.

## Deep reference
`research/philosophy_20_personas_decision_council.md`
