# Glossary — yegor-pm methodology

The vocabulary of the [XDSD](https://www.xdsd.org/)-derived disciplines these
skills encode. Terms are grouped by the discipline that owns them; each entry
names the **skill** to load for the full rule and, where useful, the primary
Yegor source it's distilled from (see [`README.md`](./README.md) §Credits for
the source list).

This glossary is **methodology-only** — it defines the *ideas*, not any one
project's concrete tooling. (A project that implements these ideas — e.g. with a
`pdd` CLI, a status reconciler, or a velocity CSV — should keep its own
implementation glossary alongside its code.)

---

## Core discipline (XDSD)

### XDSD — eXtremely Distributed Software Development
Yegor Bugayenko's methodology for distributed teams: pay-per-task, all
communication mediated through the issue tracker, architect-led design, no
meetings and no informal help channels. These skills adapt it for a solo
developer working with AI agents — the "team" is you + Claude.

### Zerocracy
The tooling/operating model (`0pdd`, `0crat`, …) Yegor built to run XDSD in
practice: bots that scan code for puzzles, file tickets, assign work, and pay on
merge. The skills borrow the *disciplines*, not the bots.

---

## Puzzle Driven Development — `yegor-pdd`

### Puzzle
A single deferred sub-problem, recorded as a `@todo` comment **at the code site**
where the work was deferred, and tied to a tracked ticket. The unit of
not-yet-done work. *Source: "Puzzle Driven Development" (2010, 2017).*

### `@todo #N:Mm/ROLE` marker
The canonical puzzle shape: the `@todo` keyword, the ticket number `#N`, an
estimate `Mm` (minutes), and a `ROLE`. Written where the stub lives so the
deferral is visible in context, not buried in a backlog.

### Estimate
The minutes a puzzle is expected to take, baked into the marker. Always **≤60m**
(see microtasks); if it can't fit, decompose *before* writing the `@todo`.

### Resolution lifecycle
The fixed path of a puzzle: write `@todo` → ticket exists → resolve the work →
**delete the marker** → commit `Closes #N` → close the ticket. A ticket isn't
done while its marker still lives in the source.

### Blocked puzzle
A puzzle that can't proceed (waiting on an upstream answer, another ticket, an
external party). Its `@todo` **stays in the code** but it's skipped in priority
order — removing the marker would lose the deferral.

### Epic pipeline
PDD has no `@epic`. A large/fuzzy issue is handled by a pipeline:
**spike** (scope it) → **architect** (design + decompose) → N bounded ≤60m
tickets + `@todo` puzzles at exact code sites → resolve in priority order. Only
decompose when you're about to start — pre-decomposing everything is waste.

---

## Spikes — `yegor-spikes`

### Spike
A bounded **≤60-minute research session** run when scope or the code site is
unknown. Produces *findings*, not code: current state, candidate code sites,
open questions, ROI. The input a real puzzle needs before it can be written.
Gate large/fuzzy work behind a spike instead of guessing at a puzzle.

---

## Microtasks — `yegor-microtasks`

### Microtask
Any task capped at ~60 minutes (default 30). The budget is fixed **at creation**.

### Overrun → split
When a task runs past its budget: stop, split the leftover into new `@todo`
puzzles, and close the original with what's actually done. You never silently
extend a microtask — honesty about the boundary is the point.
*Source: "Microtasking" / XDSD.*

---

## Bug Driven Development — `yegor-bdd`

### Complaint
The shape every piece of work takes: **have X / should have Y / repro**. Not a
feature request, not a suggestion, not a question — a concrete statement of what's
wrong and how to reproduce it. *Source: "Stop Asking and Suggesting — Just
Complain" (2025).*

### Test-as-proof
The strongest form of a complaint is a **failing or disabled test** that proves
the bug exists. The fix is "make it green," and the test stays as the regression
guard.

### Reporter closes
Only the person who filed the complaint may close it — they verify the fix
against their original repro. The implementer proposes "done"; the reporter has
the last word. *Source: "Let the Bug Reporter Have the Last Word" (2025).*

---

## Tickets — `yegor-tickets`

### Ticket-as-conversation
The issue tracker is the *only* place project communication lives. Design
decisions, direction changes, and answers are recorded as ticket comments —
written **before** any chat reply or code.

### "If it isn't in the tracker, it didn't happen"
The governing rule: a decision that exists only in chat, a DM, or someone's head
does not exist. No Slack/meetings as the primary channel.
*Source: "Stop Chatting, Start Coding" (2014); "Five Principles of Bug Tracking"
(2014).*

---

## Architect / Courier — `yegor-architect`

### Architect mode
The mode in which design happens — **in writing**, in the ticket, before code.
One person decides the design.

### Courier mode
The mode in which an agreed design is executed faithfully — delivered, not
redesigned. *Source: "Couriers, Not Coders" (2026).*

### Never mix the modes
The core rule: don't redesign mid-implementation. When tempted to change the
design while coding, **stop, drop a puzzle, and switch back to architect mode**
deliberately. *Source: "Three Things I Expect From a Software Architect" (2015).*

---

## Velocity — `yegor-velocity`

### Velocity
**Closed tickets per week. Full stop.** Not commits, not hours, not lines of
code. The reporter verifies closure; the closing comment names the deliverable.
*Source: XDSD velocity model.*

---

## Documentation-first — `yegor-nohelp`

### NoHelp
Knowledge sharing happens through **documentation, not by tapping experts**. A
question becomes a ticket; its answer lands in the docs. When you'd search or ask
the same thing twice, write it down.

### `NOTES.md`
The minimum documentation surface a project must keep — where non-obvious,
discovered-the-hard-way facts go so the next person (or agent) doesn't re-derive
them. *Source: XDSD "no help" principle.*

---

## Code review — `yegor-review`

### Reject, don't bless
The reviewer's job is to **find reasons to reject**, not to approve. The burden
of proof is on the reviewer to show the change is good — silence is not approval.
*Source: "Four NOs of a Serious Code Reviewer" (2015).*

### The Four NOs
The reviewer's stance: **no fear** (reject senior authors' code too), **no
compromise** (don't approve "good enough"), **no bullshit** (demand clarity), **no
offense** (rejection is about the code, not the person).

### Three critical problems
A focusing heuristic: surface the **3 most critical problems** in a diff rather
than an exhaustive nitpick list. Depth over breadth.

### Never run the code
The reviewer does **not** hand-QA the change. A bug that only shows up at runtime
is a **missing test** — file it as a complaint rather than discovering it by
running. *Source: "Does Code Review Involve Testing?" (2019).*

---

## Unit-test quality — `yegor-unit-tests`

### Tests must be able to fail
A test that can't fail is not a test. Tests are **first-class code** held to the
same bar as production code. *Source: "Write Unit Tests, Don't Waste Our Money!"
(2025).*

### Anti-pattern catalog
Named test smells to reject: **Liar** (passes despite broken code), **Inspector**
(reaches into internals), **Mockery** (more mock than test), **Happy Path** (only
the easy case), **Giant** (tests everything at once), **Free Ride** (a new assert
hitchhiking on an existing test), and others. *Source: "Unit Testing
Anti-Patterns, Full List" (2018).*

### Fakes over mocks
Prefer **built-in fake objects** (real, simple stand-ins shipped with the code)
over mock-framework scaffolding, which couples tests to implementation detail.
*Source: "Built-in Fake Objects" (2014).*

---

## Meta — `yegor-pm`

### `yegor-pm` (meta-orchestrator)
The daily entry point. Doesn't carry rules itself — it **routes** a situation to
the right sub-skill(s) (planning → architect+microtasks, fuzzy issue → spikes,
writing stubs → pdd, reviewing → review, etc.). See [`README.md`](./README.md)
for the full routing table.
