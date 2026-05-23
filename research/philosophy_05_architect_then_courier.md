# Philosophy 05 — Architect-then-Courier (Design then Deliver)

> **Why this doc exists:** distill Yegor's view that design decisions are made by one person (the architect) before any delivery starts, and that the PR is delivery — not design. Turn this into a temporal discipline a solo developer (and Claude) can follow.
>
> **Primary sources:**
> - Yegor Bugayenko, *Three Things I Expect From a Software Architect* (2015-05-11) — https://www.yegor256.com/2015/05/11/software-architect-responsibilities.html
> - Yegor Bugayenko, *What if the Architect is Wrong?* (2019-01-15) — https://www.yegor256.com/2019/01/15/what-if-architect-is-wrong.html
> - Yegor Bugayenko, *Couriers, Not Coders* (2026-05-03) — https://www.yegor256.com/2026/05/03/no-mercy.html
> - Talk: *eXtremely Distributed Software Development* (DevTernity 2016), takeaway @ 22:16

---

## The principle (paraphrased)

There is exactly one architect per project. The architect makes all design decisions and is personally responsible for technical quality — Yegor calls this "the architect carries the blame." Other contributors are *couriers*: they deliver flawless work against decisions that are already made.

The PR is delivery, not design. A pull request opens only after the feature has been accepted by the architect; the PR's job is to embody an already-agreed solution, not to propose one.

Yegor's framing in *Couriers, Not Coders* (2026): trust is earned by delivering work that merges without re-checking. The discipline is *speed of delivery + readiness to rework*, not negotiation.

Yegor's framing in *What if the Architect is Wrong?*: the architect must NOT have to convince anyone. If forced to convince, "responsibility leakage" occurs — the architect can no longer be fully responsible for the outcome.

## Why it works

- **Eliminates mid-flight redesign.** The single most expensive failure mode in software is changing your mind during implementation. Separating design from delivery makes that change impossible without re-entering the design phase.
- **Single source of accountability.** If quality is bad, you know who is responsible. No diffusion across a committee.
- **Faster delivery.** Couriers don't deliberate; they execute. Once design is locked, execution becomes mechanical.
- **Better for AI integration.** AI agents (including Claude) are excellent couriers. They struggle when forced to also be the architect of a fuzzy problem. Separating the modes plays to AI's strengths.

## The architect's three deliverables (Yegor, 2015)

The architect doesn't write code — they write three things, refreshed multiple times per week:

1. **Scope status** — a Product Breakdown Structure with 4–8 items showing what's done, what's in progress, and the percent complete for each.
2. **Issues** — a prioritized list of 4–8 current problems already affecting development (performance, staffing, blockers).
3. **Risks** — 4–8 *potential* future problems with probability and impact ratings.

This is the architect's job. Not coding. Not reviewing PRs (well — they can, but the design call is upstream).

## Actionable guidelines

### The temporal split (for any developer, including solo)

Run two distinct modes — never simultaneously:

**Mode A — Architect**
- Output: a written design (issue body + comments) describing what will be built and how.
- Forbidden: opening branches, writing implementation code, starting PRs.
- Done when: the design is concrete enough that a competent stranger could implement it without further questions.

**Mode B — Courier**
- Output: code that implements the agreed design, in PR form.
- Forbidden: redesigning, expanding scope, second-guessing the issue.
- Done when: the PR merges cleanly with no rework.

The discipline is **never to mix the modes in one session**. When in courier mode, if you find yourself wanting to redesign, *stop* — that's a signal to drop a puzzle (`@todo`), close the current task with the partial deliverable, and re-enter architect mode in a fresh session.

### Architect rules

- **One person.** Even on a team of 50, exactly one architect per project. On a solo project, you ARE the architect — but the role is still distinct from the courier role.
- **No persuasion needed.** The architect collects input but doesn't have to convince anyone. They decide; others execute.
- **Decisions in writing.** Architect decisions live as issue comments (per [Ticket-as-conversation](./philosophy_04_tickets_ticket_as_conversation.md)).
- **Decompose, don't solve.** The architect's job is to break complex problems into small enough pieces that couriers can solve them.
- **Blame, not credit.** If quality is bad, the architect's name is on it. This is the price of authority.

### Courier rules

- **Don't open a PR before the design is accepted.** The acceptance is the ticket comment that says "this is the design — implement it."
- **Speed + cleanliness over creativity.** A clean delivery in 30 minutes beats a clever delivery in 4 hours.
- **Ready to rework.** If the architect says "redo," redo without arguing. The argument belonged to the design phase.

### How Claude should use this when helping

- **When the user describes a vague task,** propose entering architect mode: "Let's design this in the issue first. I'll draft a body covering scope / approach / risks. We won't touch code until we agree." This is the right separation.
- **When the user says "let's just start coding,"** push back gently *once*: "Want to spend 5 minutes locking the design in the ticket? It saves redesigns later." If they decline, deliver in courier mode but mark uncertain spots with puzzles.
- **When in courier mode** (executing an agreed ticket) **and a new design question arises**, do NOT re-architect. Stop, add a puzzle, surface the question back to architect mode in a new ticket.
- **For PR reviews**, separate two checks: (1) does it match the agreed design? (courier check), (2) was the agreed design right? (architect check). If (2) is wrong, that's a new issue, not a PR comment.

### For a solo developer

You play both roles. Tactics:

1. **Name the mode out loud.** "I'm in architect mode now. I will not open my editor." / "I'm in courier mode now. I will not change the design."
2. **Use separate sessions.** Architect mode happens in the issue tracker (browser tab). Courier mode happens in the editor. Switching tabs is your mode-switch signal.
3. **Sleep between modes.** If possible, design today; implement tomorrow. Overnight is your best critic of yesterday's design.
4. **When tempted to redesign mid-implementation, run the script:** stop → puzzle → close partial → new issue → tomorrow.

## Pitfalls

- **Designing forever.** Architect mode can become procrastination. Cap design time per issue — usually one session.
- **Two architects.** The moment two people both think they have the final say, the project is in trouble. Choose. (Solo: even your "yesterday-self" and "today-self" can't both be architect — yesterday-self wins until you formally reopen the design.)
- **Couriers redesigning.** The most common failure mode. Symptom: PRs that wander beyond the issue. Fix: reject the PR, open a new ticket for the wander.
- **No written design.** "We talked about it" is not architect output. Architect output is text in the issue.
- **Architect coding.** Architects can code, but when they do, they're wearing the courier hat. Switch deliberately.

## Integration with the other philosophies

- + [Ticket-as-conversation](./philosophy_04_tickets_ticket_as_conversation.md): architect output lives as ticket comments.
- + [Micro-tasking](./philosophy_03_microtasks_microtasking.md): the architect's decomposition produces ≤60-minute tickets for couriers.
- + [PDD](./philosophy_01_pdd_puzzle_driven_development.md): couriers who hit unresolved sub-problems drop puzzles instead of redesigning.

## One-line summary for Claude

> One architect, decides in writing, no need to convince. Couriers deliver against accepted designs. Never mix the modes in one session — when tempted to redesign mid-implementation, stop and drop a puzzle.
