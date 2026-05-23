---
name: yegor-architect
description: Separate architect mode (design in writing) from courier mode (execute agreed design). One person decides, others deliver. Never mix the two modes in one session. When tempted to redesign mid-implementation, stop and drop a puzzle. Use when starting fuzzy work, mid-implementation, or reviewing a PR.
version: 0.1.0
last_reviewed: 2026-05-23
---

# Yegor Architect-then-Courier

One architect, decides in writing, doesn't need to convince anyone. Couriers deliver against accepted designs. Never mix the modes in one session — when tempted to redesign mid-implementation, stop and drop a puzzle.

## Triggers
- About to start work on a fuzzy task
- Mid-implementation and wanting to redesign
- Reviewing a PR
- Wearing multiple hats (solo developer especially)

## The two modes

**Mode A — Architect**
- Output: written design in the issue body + comments.
- Forbidden: opening branches, writing implementation code, starting PRs.
- Done when: a competent stranger could implement without further questions.

**Mode B — Courier**
- Output: code implementing the agreed design, in PR form.
- Forbidden: redesigning, expanding scope, second-guessing the issue.
- Done when: the PR merges cleanly with no rework.

**Never mix modes in one session.** When tempted to redesign mid-implementation: stop → drop a `@todo` puzzle → close current task with partial deliverable → re-enter architect mode in a fresh session.

## Architect's three deliverables (Yegor, 2015)
1. **Scope status** — Product Breakdown Structure, 4–8 items, percent complete each.
2. **Issues** — 4–8 current problems already affecting development.
3. **Risks** — 4–8 potential future problems with probability/impact ratings.

## Architect rules
- **One person.** Even on big teams. Solo: you ARE the architect, but the role is still distinct.
- **No persuasion needed.** Architect collects input but doesn't have to convince anyone. Decides; others execute. (Yegor: forcing the architect to convince causes "responsibility leakage.")
- **Decisions in writing.** Always as issue comments.
- **Decompose, don't solve.** Break complex problems into ≤60-minute courier tasks.
- **Blame, not credit.** Quality issues are the architect's personal fault. That's the price of authority.

## Courier rules
- **Don't open a PR before the design is accepted.** The acceptance is the ticket comment saying "this is the design — implement it."
- **Speed + cleanliness over creativity.** A clean 30-min delivery beats a clever 4-hour delivery.
- **Ready to rework.** If the architect says "redo," redo without arguing. The argument belonged to the design phase.

## Rules for Claude

**When the user describes a vague task:**
- Propose architect mode: "Let's design this in the issue first. I'll draft scope / approach / risks. We won't touch code until we agree."

**When the user says "let's just start coding":**
- Push back once: "Want 5 minutes locking the design in the ticket? Saves redesigns later."
- If declined, deliver in courier mode and mark uncertain spots with `@todo` puzzles.

**In courier mode, when a new design question arises:**
- Do NOT re-architect. Stop, add a puzzle, surface the question back to architect mode in a new ticket.

**For PR review, separate two checks:**
1. Does it match the agreed design? (courier check)
2. Was the agreed design right? (architect check)
- If (2) is wrong, that's a new issue, not a PR comment.

## Solo developer tactics
1. **Name the mode out loud.** "Architect mode now. Editor closed." / "Courier mode now. Design is locked."
2. **Use separate sessions.** Architect mode happens in the browser (issue tracker). Courier mode in the editor. Tab switch = mode switch.
3. **Sleep between modes.** Design today, implement tomorrow. Overnight is your best critic of yesterday's design.
4. **Redesign urge mid-implementation** → script: stop → puzzle → close partial → new issue → tomorrow.

## Pitfalls
- Designing forever (architect mode as procrastination). Cap design time per issue — usually one session.
- Two architects (solo: yesterday-self and today-self can't both be architect — yesterday-self wins until you formally reopen the design).
- Couriers redesigning (symptom: PRs wandering beyond the issue scope). Fix: reject PR, open new ticket.
- No written design ("we talked about it" is not architect output).
- Architect coding without switching hats deliberately.

## Cross-references
- `yegor-tickets` — architect output lives as ticket comments.
- `yegor-microtasks` — architect's decomposition produces ≤60-minute tickets for couriers.
- `yegor-pdd` — couriers hitting unresolved sub-problems drop puzzles instead of redesigning.

## Deep reference

`research/philosophy_05_architect_then_courier.md`
