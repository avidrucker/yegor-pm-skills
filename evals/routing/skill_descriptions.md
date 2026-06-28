### yegor-architect
Separate architect mode (design in writing) from courier mode (execute agreed design). One person decides, others deliver. Never mix the two modes in one session. When tempted to redesign mid-implementation, stop and drop a puzzle. The architect's only boss is the requirements; the architect enforces design through two instruments — filing bugs and reviewing code — and when the call is contested, more eyes are added in proportion to the risk. Use when starting fuzzy work, mid-implementation, reviewing a PR, or resolving who decides a design conflict. 

### yegor-bdd
Apply Bug Driven Development. Frame every piece of work as a complaint with shape "have X / should have Y / repro". No feature requests, no suggestions, no questions. The complaint is best expressed as a failing/disabled test that proves the bug. A bug title must be a complaint (names the breakage), not a question or a topic — lint and rewrite weak titles at filing time. A good report is also reproducible, rich (expected vs actual + environment), and carries visible reporter effort. Use when filing, reviewing, or closing issues. Only the reporter closes a ticket. 

### yegor-builds
One build can't serve every need — use a tiered set. From Yegor Bugayenko's "Four Builds" — a Fast build (seconds, local, unit-only) for the inner loop, a Cheap build (minutes, on every PR, +integration/style), a Preflight build (the slow pre-merge gate, +mutation/load/security), and a Proper build (full regression, at release). Speed early, thoroughness late. Pairs with the 8+2 CI-maturity ladder, and with trust-based dependency versioning (pin untrusted deps to fixed versions, allow ranges for trusted ones, record the rationale). Use when setting up or fixing CI, when a test loop is too slow, when all checks are crammed into one job, when deciding what to run where, or when choosing how to pin a dependency. 

### yegor-merge-gate
The trunk (master/main) is read-only and the author never blesses their own merge. From Yegor Bugayenko — no one merges by hand; an automated gate runs the full suite in a clean environment and merges only if green. The gate is zero-tolerance — any single lint/static-analysis violation fails it (warnings == errors, no allowlist). Never merge into a broken master — when the build is red, the only allowed change is the one that fixes it. Use when deciding a PR is ready, before merging, when CI/master is red, or when an agent is about to declare its own work done. 

### yegor-microtasks
Cap every task at ~60 minutes (default 30). Budget is fixed at creation. If overrun, stop, split leftover work into @todo puzzles, close the original with what's done. Use when estimating, planning, starting work, or when a task is running longer than budgeted. 

### yegor-nohelp
Knowledge sharing happens through documentation, not by tapping experts. Questions become tickets; answers land in docs (NOTES.md minimum). When you'd search or ask twice, write it down. Docs are kept short, ordered, and non-duplicative (a README is ≤~2 pages with sections in a fixed order); quality requirements are written as measurable numbers, not adjectives. Use when answering project-specific questions, debugging, discovering non-obvious behavior, or writing/reviewing a README or spec. 

### yegor-pdd
Apply Puzzle Driven Development. Convert deferred sub-problems into structured @todo puzzle comments at the code site. Use when writing stubs, reviewing TODO comments, or deferring sub-problems during implementation. Each puzzle references a parent ticket and has an estimate in minutes. 

### yegor-personas
Council-of-personas decision evaluator. When facing a non-trivial call (a design choice, "should this be a bug?", a label/scope dispute, an approach decision), run it through the strict lens of each relevant yegor-* skill — each persona giving its picky reading — then converge to ONE recommendation, naming any unresolved conflict and who has authority to break it. Voices the unstaffed roles too (PO, REQ, QA, TST). Invoke deliberately for hard decisions — prompts like "what would the different yegor personas say?", "be strict, picky, thorough", "convene the council", "which persona has standing here?". 

### yegor-pm
Project management and engineering-discipline skill set distilled from Yegor Bugayenko's XDSD methodology. Meta-orchestrator for 17 sub-skills (yegor-pdd, yegor-spikes, yegor-bdd, yegor-microtasks, yegor-tickets, yegor-architect, yegor-velocity, yegor-projections, yegor-nohelp, yegor-review, yegor-unit-tests, yegor-stuck, yegor-merge-gate, yegor-builds, yegor-simba, yegor-small-repos, yegor-personas). Triggers when planning work, breaking down tasks, managing issues, forecasting timelines, reviewing progress/code, writing tests, setting up CI/builds, handling blockers, capping work-in-progress, gating merges, deciding repo boundaries, evaluating a hard decision through multiple role lenses, or deciding on workflow approach. 

### yegor-projections
Forecast from measured delivery rate, not from a spec-derived guess. From Yegor Bugayenko's "How to Estimate Software Cost" — up-front estimates are dishonest because software has no fully-knowable finish line; instead make projections from observed velocity ("we close ~N tickets/week, ~M remain, so ~M/N weeks") and re-issue them as the rate is re-measured. A projection is a falsifiable forecast with an as-of date, not a promise. Use when asked "how long will this take", when tempted to estimate a whole feature up front, or when re-forecasting a roadmap. 

### yegor-review
Code-review discipline from Yegor Bugayenko. The reviewer's job is to REJECT, not to bless — burden of proof is on the reviewer. Apply the Four NOs (no fear, no compromise, no bullshit, no offense), find the 3 most critical problems, never run the code (a runtime-only bug is a missing test, file it), and auto-reject any PR that changes production code but ships no test. Use when reviewing a PR/diff, giving or receiving review feedback, or deciding how to respond to a review. 

### yegor-simba
Cap work-in-progress and back every status claim with evidence. From Yegor Bugayenko's SIMBA (Simplified Management By Artifacts) — manage by artifacts each with an owner and a reviewer, enforce hard caps on how many things are in flight at once, and require that every progress claim links to verifiable evidence (a PR, a doc, a file, a passing build). Completion is reported by the reviewer, not the owner. Use when work is sprawling across too many in-flight items, when a status report asserts progress without links, when an agent claims "done" without proof, or during a weekly review. 

### yegor-small-repos
Prefer many small single-purpose repositories over one monorepo. From Yegor Bugayenko's "Monolithic Repositories Are Evil" and "Smaller Repository, Higher Quality" — a repo capped around ~50k lines, one language/technology, one problem scope, builds in under a minute. Small repos get stricter style, deeper tests, better reviews, faster onboarding — and, in the AI era, fit inside an agent's context window. Use when a repo is sprawling across many concerns/languages, when builds crawl, when onboarding (human or agent) is hard, or when deciding whether to split. 

### yegor-spikes
Research/scope spikes for large or fuzzy issues. Run a bounded ≤60min investigation session to discover code sites, current state, open questions, and ROI before writing any @todo puzzle. Use when a GH issue is too vague or too large to add a meaningful @todo — scope it first, puzzle later. 

### yegor-stuck
What to do when you're blocked, stuck, or tempted to grind heroically or fabricate a fix. The cut-corners protocol from Yegor Bugayenko — your duty is to REVEAL the problem, not heroically conceal it. An escalating ladder of honest, principled ways to stop being stuck (block, demand docs, reproduce-as-skipped-test, prove-absent, disable-and-ship) instead of thrashing, plus the No-Obligations rule for stale in-progress work (idle past a threshold → drop or re-scope, don't hold the slot). Use when work is impossible/too costly, when you've been grinding on the same problem, when a ticket has gone quiet for days, or when about to hack around a blocker. 

### yegor-tickets
All meaningful project communication lives in the issue tracker. No Slack, DMs, or meetings as the primary channel. Decisions don't exist until written as a ticket comment. Use when making a design decision, changing direction, answering a project question, or proposing a new approach. 

### yegor-unit-tests
Unit-test quality discipline from Yegor Bugayenko. A checklist of named anti-patterns (Liar, Inspector, Mockery, Happy Path, Giant, Free Ride, ...) plus the positive rules — descriptive names, real assertions, test boundaries not just the happy path, isolation, speed, and fakes over mock frameworks. Also: a test is a warranty on the code (every change ships one), the tests-first / two-PR workflow, promoting private methods to their own testable class, test-layout rules, and shipping fakes as production classes. Use when writing, reviewing, or refactoring unit tests. 

### yegor-velocity
Velocity is closed tickets per week, full stop. Commits don't count. Hours don't count. Lines don't count. Reporter verifies; closure comment names the deliverable. For a richer picture, a multi-dimensional scorecard (PRs merged, bugs fixed, bugs reported, Cost-of-PR = open→merge time, docs) supplements the headline number — each dimension carrying an anti-gaming validator. Use when reviewing progress, answering "how's it going", or measuring productivity. 

