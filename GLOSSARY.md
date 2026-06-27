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

### Title lint
A bug title must be a **declarative complaint** that names the breakage — not a
question (`?`, why/how/what…), a bare topic ("Date parsing"), or a wish ("Add
dark mode"). Lint and auto-rewrite weak titles at filing time; an agent is the
ideal enforcer. *Source: "Good Title, Good Bug Report" (2025).*

### Five Principles of Bug Tracking
The hygiene rules for a tracker: keep each ticket **one-on-one** (one reporter,
one solver), **close it fast** but **never empty-handed** (always deliver some
change), **@-address every comment**, and shape every report as
have/should/repro. *Source: "Five Principles of Bug Tracking" (2014); see also
`yegor-tickets`.*

### Report richness
A good title gets a bug *noticed*; the body gets it *fixed*. A real report is
**reproducible** (clean-state steps + exact version/commit), **rich** (expected
vs actual + environment), and **effortful** (reporter narrowed the case, attached
output). The richest form is a failing test — all three in one artifact. *Source:
"The Right Way to Report a Bug" (2018).*

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

### Requirements are the architect's boss
The architect owns *how*, but the *what* belongs to the requirements. A design
call is justified by pointing at the spec (or amending it), never by rank.
*Source: "What if the Architect is Wrong?" (2019).*

### Two instruments
The architect enforces design through exactly two tools — **filing bugs** and
**doing code reviews** — not meetings or DMs. A rule expressible as neither
should become a requirement. When the call is risky/contested, add independent
reviewers in proportion to the risk. *Source: "Two Instruments of a Software
Architect" (2015).*

---

## Velocity — `yegor-velocity`

### Velocity
**Closed tickets per week. Full stop.** Not commits, not hours, not lines of
code. The reporter verifies closure; the closing comment names the deliverable.
*Source: XDSD velocity model.*

### Multi-metric scorecard
A supplement to the headline close-rate: a small set of git/tracker-derived
dimensions — PRs merged, bugs fixed, bugs reported, **Cost-of-PR** (open→merge
time), docs — where **every count carries an anti-gaming validator** (usually
"a second actor confirmed it"). Used when one number would mislead. *Source: "To
Measure or Not to Measure: Individual Performance Metrics" (2020).*

### Cost-of-PR
A pull request's **open→merge time** — a pure timestamp subtraction. A rising
Cost-of-PR trend is the earliest warning that work is sprawling or stuck, often
before the close-rate drops.

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

### Doc structure
Docs are kept **short, ordered, and non-duplicative**: a README is ≤~2 pages with
sections in a fixed order (pitch → quick-start → usage → contribute → releases)
and links out to generated content instead of copying it. When a doc grows, trim
and link out rather than append. *Source: "Elegant READMEs" (2019).*

### Measurable requirements
A quality requirement is a **number**, not an adjective: "<300ms page load," not
"fast." An unmeasurable requirement can't pass or fail, so it isn't one. *Source:
"How We Write a Product Vision" (2014).*

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

### Testless-PR gate
A PR that changes production code but ships **zero tests** is auto-rejected — a
binary, diff-checkable gate (prod changed, tests untouched → reject). A test is
the **warranty** on the code; contributing untested code wastes the value it
adds. Exception: tests/docs/config-only changes. *Source: "A Pull Request
Without a Test Is a Waste" (2025).*

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

### Tests-first / two-PR workflow
For non-trivial work, land the **tests first — disabled — in their own PR**,
reviewed as *requirements*; a second PR makes them pass without editing the test
bodies. Guarantees the author couldn't bend the tests to fit the code; maps onto
a spec-first agent flow. *Source: "The Code and Its Tests in Different Pull
Requests" (2022).*

### Promote a private method to a class
If a private method holds behavior worth testing, don't reflect into it (the
Inspector smell) — **extract it into its own small class** with a public surface
and test it directly. *Source: "Each Private Static Method Is a Candidate for a
New Class" (2017).*

---

## Stuck protocol — `yegor-stuck`

### Cut corners, don't be a hero
When a task is impossible, too costly, or blocked, your duty is to **reveal the
problem**, not to grind silently or fake a fix. "Production errors aren't the
programmer's mistakes — delayed and hidden tickets are." *Source: "How to Cut
Corners and Stay Cool" (2015).*

### The cut-corners ladder
The escalating set of honest exits from "stuck," cheapest first: **block and
pause** → **demand documentation** → **reproduce as a skipped failing test** →
**prove-absent** (a passing test showing the code is correct as-designed) →
**disable the feature and ship**. Refusing the work entirely is the last resort.
Each rung leaves a visible artifact in the tracker.

### Never fake green / never cut tests
The two forbidden moves: fabricating a passing result (faking a test, swallowing
an error, hardcoding an expected value) and skipping unit tests. Every other
corner is negotiable under pressure; these two are not.

### No-Obligations / stale work
Taking a task is **not a promise** to finish it. An in-progress item idle past a
threshold (~10 days default) with no closing deliverable is dropped or
re-scoped, not held open — and you never **fake activity** (a token commit) to
reset the clock. Pairs with WIP caps. *Source: "No Obligations" (2014).*

---

## Merge gate — `yegor-merge-gate`

### Read-only master
The trunk branch accepts **no direct pushes** — not even from the repo owner.
Every change enters through an automated gate that runs the full suite in a clean
environment and merges only if green. *Source: "Master Branch Must Be Read-Only"
(2014); "Rultor" (2014).*

### No self-blessing
The author of a change never declares it merge-ready and admits it themselves —
writing the code and admitting it to the trunk are separate roles. Solo/AI form:
an author-agent must not merge its own PR; an **impartial gate** (CI + an
independent review) proves it first.

### Never merge into a broken master
When the build is red, the **only** change allowed in is the one that fixes it;
build-fixes ship in their own isolated PR. Stacking work on a red trunk makes
later failures unattributable. *Source: "We Don't Merge into a Broken Master
Branch" (2025).*

### Zero-tolerance quality bar
The gate is **binary**: any single lint/static-analysis violation fails the whole
build. No warnings-only mode, no severity downgrade, no growing allowlist —
warnings are errors. Lets a fast-moving agent move without being trusted to
self-police. *Source: "Strict Control of Java Code Quality" (2014); "Don't Aim
for Quality, Aim for Speed" (2018).*

---

## Tiered builds — `yegor-builds`

### The four builds
A build can't be both fast and thorough, so run a tier: **Fast** (seconds,
local, unit-only — the inner loop) → **Cheap** (minutes, every PR,
+integration/style) → **Preflight** (the slow pre-merge gate, +mutation/load/
security) → **Proper** (full regression, at release). The cheaper the build, the
more often it runs. *Source: "Four Builds" (2025).*

### CI-maturity ladder (8+2)
A rung-by-rung self-audit of a pipeline (one-command build → Git → read-only
master → mandatory review → test-per-change → static-analysis threshold →
pre-flight builds → prod-like containers → +stress → +security). Fix the
**lowest missing rung first**. *Source: "8+2 Maturity Levels of Continuous
Integration" (2016).*

### Trust-based versioning
Pin dependencies by trust: **fixed** versions for untrusted/low-reputation deps
(cap the blast radius of a bad release), **ranges** for trusted, semver-disciplined
ones (take fixes for free) — and record the reason. Avoids both the
pin-everything *time bomb* and the float-everything *dependency hell*. *Source:
"My Recipe Against Dependency Hell" (2019).*

---

## WIP caps + evidence — `yegor-simba`

### Work-in-progress (WIP) cap
A hard ceiling on how many artifacts are in flight at once (Yegor's SIMBA: own
~≤3, review ~≤4, hold ~≤7 total). Past the cap you **finish or drop** before
starting new work — the mechanism that forces convergence. *Source: "SIMBA:
Simplified Management By Artifacts" (2021).*

### Evidence-backed status
Every progress claim **links to a verifiable artifact** (a PR, commit, doc,
passing build). Effort verbs with no link ("worked on", "looked into") are not
progress. "Done" is a claim about an artifact — so show it.

### Reviewer-reported completion
The **owner** of an artifact does not report how done their own work is; the
**reviewer** does. The producer is the worst judge of their own progress —
no-self-blessing at the planning layer.

---

## Projections — `yegor-projections`

### Projection (vs estimate)
An **estimate** is a spec-derived promise about an unknowable future; a
**projection** is a forecast from measured delivery rate — `weeks ≈ open tickets
÷ closed-per-week` — stamped with an **as-of date** and a range, and re-issued as
the data changes. No velocity history → you can't project; say so and measure
first. *Source: "How to Estimate Software Cost" (2015).*

---

## Small repos — `yegor-small-repos`

### One repo, one purpose
A repository holds **one problem, one language, ~50k lines, a sub-minute
build** — small enough to hold in one mind. A second unrelated concern gets its
own repo. The ~50k cap is a checkable **signal to look for a seam**, not a law.
*Source: "Monolithic Repositories Are Evil" (2018).*

### Fits the context window
The AI-era argument for small repos: a small codebase fits **inside an agent's
context window**, so the whole thing is real context instead of a lossy retrieved
slice — now a first-class reason, not a nice-to-have. *Source: "Smaller
Repository, Higher Quality" (2025).*

---

## Decision council — `yegor-personas`

### Council of personas
A decision technique: for a hard call, run it through the **strict lens of each
persona with standing** (each relevant `yegor-*` skill, plus the unstaffed roles
PO/REQ/QA/TST), let each give its pickiest reading, then **converge** to one
recommendation. Invoked deliberately, not on every decision. *Source: "Key Roles
in a Software Project" (2016).*

### Standing
A persona has **standing** on a decision only when its creed is actually engaged.
Seat the 3–5 personas with standing — not all 17; one means no council is needed,
all means the fork isn't framed. Selection is by standing, never by which voices
agree with you.

### Authority ladder
The ordered rule for converging a council (first match decides, then stop):
**requirements** are the ultimate boss → **binary gates** are unoverrideable →
**objective measures** decide themselves → the **reporter** owns their ticket →
the **architect** breaks technical ties → **no compromise** (name the concession).
Authority, not volume, decides; a persona with a stake is advisory only. *Source:
"What if the Architect is Wrong?" (2019); "Four NOs of a Serious Code Reviewer"
(2015).*

### Unstaffed role-voices (PO / REQ / QA / TST)
Yegor's project roles that have no dedicated skill yet but get a voice in the
council: **REQ** ("is it in the spec?"), **PO** ("in scope / approved?"), **QA**
("process followed / artifacts present?"), **TST** ("what's the repro?").

---

## Meta — `yegor-pm`

### `yegor-pm` (meta-orchestrator)
The daily entry point. Doesn't carry rules itself — it **routes** a situation to
the right sub-skill(s) (planning → architect+microtasks, fuzzy issue → spikes,
writing stubs → pdd, reviewing → review, etc.). See [`README.md`](./README.md)
for the full routing table.
