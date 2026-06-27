# Yegor-PM family — deferred ideas

A flat list of enhancements considered for the yegor-pm family of skills
(yegor-pdd, yegor-spikes, yegor-bdd, yegor-microtasks, yegor-tickets,
yegor-architect, yegor-velocity, yegor-nohelp, puzzle-velocity) that we
chose not to implement now. Each entry: what, why deferred, when to revisit.

Add new ideas here rather than as scattered TODOs in the SKILL.md files.

---

## I-001 — Pre-commit hook: reject files containing conflict markers

**What:** A repository-level `pre-commit` hook that runs
`git diff --cached --check` (or a plain `grep -lE '^<<<<<<<|^=======|^>>>>>>>'`
against the staged file list) and aborts the commit if any staged file still
contains raw conflict markers.

**Why it would help:** belt-and-suspenders for the `puzzle-velocity` skill's
CSV merge-conflict resolution path. The skill's protocol (v0.4.0) already
prescribes a `grep` guard between resolution and `git add`, but a hook would
catch the failure mode mechanically — even when an agent (or human) forgets
the guard, or when an upstream tool fails silently (e.g. an Edit that didn't
apply, leaving the markers in place).

**Why deferred:**
- The 0.4.0 protocol guard catches the same failure mode at the right step
  (before `git add`), and has now been documented across the skill + the
  lccjs `docs/puzzle-velocity.md` mirror. We want to see whether the
  protocol-level fix is enough in practice before adding hook machinery.
- A hook is per-repo infrastructure; the skill protocol is portable across
  every project that adopts puzzle-velocity. Fixing it at the protocol layer
  scales further with no per-project install step.
- Hooks have a small but real maintenance cost (installing, keeping in sync
  across worktrees, handling `--no-verify` bypasses). Not worth paying that
  cost without evidence the protocol guard isn't enough.

**When to revisit:**
- If a second incident ships conflict markers despite the v0.4.0 protocol —
  that's the signal the protocol alone isn't enough and the hook should be
  built.
- Or if a project picks up puzzle-velocity and explicitly asks for the hook
  as part of the setup.

**Surfaced by:** lccjs #139 close (2026-05-28); see `puzzle-velocity`
0.4.0 CHANGELOG entry and lccjs commit `a19d115` for the failure-mode trace.

**Owner / scope when revisited:** small DEV puzzle, ~10–15m H, single file
(`.git/hooks/pre-commit` or `.husky/pre-commit` depending on the project).

---

## I-002 — OOP / "Elegant Objects" corpus kept out of scope

**What:** A skill (or skills) encoding Yegor's code-design rules — *Getters/Setters
Is Evil*, *Why NULL Is Bad*, *Objects Should Be Immutable*, *No -ER class names*,
*Constructors Must Be Code-Free*, *ORM/DAO/ActiveRecord is an anti-pattern*,
*DTOs are a shame*, *No DI containers*, *Singletons must die*, *Fail fast*,
*Inject the logger*, *Composition over inheritance*, and the rest of the
[Elegant Objects](https://www.elegantobjects.org/) rule set (master catalog:
*Anti-Patterns in OOP*, 2014).

**Why it would help:** this is Yegor's single largest and *most-read* body of
work — by external citation/debate footprint, *Getters/Setters. Evil. Period.* is
his most famous post, and the `oop` tag holds ~100 posts. A coverage review
(2026-06-26) found this cluster at ~0% covered while the process/PM half sits at
~85–90%. It is also genuinely *checkable*: an agent can mechanically flag static
utility classes, field/setter injection, singletons, static loggers, getter-only
data bags, config-flag objects, swallowed exceptions, etc.

**Why deferred (decided 2026-06-26 — a deliberate non-goal, not an oversight):**
- The family is intentionally **stack-agnostic** (commit `cfe6616`). Much of this
  corpus is Java/OOP-specific (no-ORM, no-getters, printers-instead-of-getters)
  and translates poorly to idiomatic Python/Clojure/Node or functional styles.
- It is Yegor's **most contested** material. Folding it in would shift this repo
  from a process/discipline toolkit into a code-style opinion engine — a
  different product with a different audience and a much larger maintenance
  surface (and a higher chance of giving an agent bad, dogmatic advice in a stack
  where the rule doesn't apply).
- The process/quality-gate disciplines already shipped are higher-leverage for
  the actual use case (solo dev + AI agents) and carry no stack coupling.

**When to revisit:**
- If the repo's scope deliberately broadens to "Yegor's code-design opinions,"
  the cleanest first cut is a **stack-agnostic subset only**: immutability,
  fail-fast (no swallowed errors), no-NULL/absence-handling, small cohesive
  objects / no god-objects, composition-over-inheritance. Leave the Java-bound
  rules (ORM/DAO, annotations, printers) as reference links, not active rules.
- Or if a consuming project is specifically a Java/OOP codebase and wants the
  full catalog as a local skill.

**Surfaced by:** the 2026-06-26 coverage review (research agents mapped Yegor's
top-~20 posts against the 11 shipped skills). README §"Deliberate non-goal"
points here.

---

## I-003 — Unit-test refinements not yet folded into `yegor-unit-tests` — ✅ RESOLVED 2026-06-26

**Resolved in `yegor-unit-tests` 0.2.0** (commit pending): folded in the
private-method-to-class rule, the test-layout rules (FooTest/behavior names/
assertion messages), and shipping fakes as production classes; explicitly
declined the single-statement-test purism with a one-line note. See
`research/philosophy_16_tests_as_warranty_separate_prs.md`. Original entry kept
below for the trail.

---

## I-003 (original) — Unit-test refinements not yet folded into `yegor-unit-tests`

**What:** Three concrete testing rules from Yegor that the current
`yegor-unit-tests` (0.1.0) doesn't state, plus one he advocates that we
deliberately reject:
- **Don't test private methods — promote them to their own class** and test that
  (*Each Private Static Method Is a Candidate for a New Class*, 2017).
- **Test layout & assertion messages** (*On the Layout of Tests*, 2023):
  `FooTest` tests `Foo`; behavior-named methods (not `test1`); every assertion
  carries a descriptive message; test classes contain only `@Test` methods.
- **Ship fakes as production classes**, not in the test folder (*Built-in Fake
  Objects*, 2014) — the constructive complement to the skill's existing
  "fakes over mocks."
- **Single-statement tests** (*Single Statement Unit Tests*, 2017) — *rejected*
  on purpose: the skill already pushes back on one-assert dogma. Worth a one-line
  note that we considered and declined the purist form.

**Why deferred:** the coverage review flagged these as in-scope and cheap, but the
user's 2026-06-26 build pass scoped to `yegor-stuck`, `yegor-merge-gate`, and the
tickets nuggets. These are a clean follow-up minor bump to `yegor-unit-tests`
(→ 0.2.0).

**When to revisit:** next time `yegor-unit-tests` is touched, or when a real test
diff trips one of these (e.g. a private method begging to be a class).

**Surfaced by:** the 2026-06-26 coverage review.

---

## I-004 — "Code and tests in separate PRs" workflow — ✅ RESOLVED 2026-06-26

**Resolved as a `yegor-bdd` + `yegor-unit-tests` expansion** (not a new skill):
the tests-first two-PR flow now lives in `yegor-unit-tests` 0.2.0 ("A test is a
warranty" section) and the testless-PR auto-reject gate in `yegor-review` 0.2.0,
with the shared deep reference
`research/philosophy_16_tests_as_warranty_separate_prs.md`. Decided it's an
expansion of the existing test/review skills, not a standalone skill. Original
entry kept below for the trail.

---

## I-004 (original) — "Code and tests in separate PRs" workflow

**What:** A skill (or a `yegor-bdd` extension) encoding *The Code and Its Tests in
Different Pull Requests* (2022): PR #1 is **tests only, added disabled**, reviewed
as *requirements* ("is this the right behavior?"); PR #2 is the implementation
that un-disables them **without editing the test bodies**. The pipeline guarantees
the author couldn't bend the tests to fit the code.

**Why it's interesting:** maps cleanly onto spec-first AI workflows — an agent
writes the failing spec first (a human/reviewer approves the *requirement*), then
a second pass makes it green without touching the spec. It separates "what"
review from "how" review.

**Why deferred:** overlaps the existing `yegor-bdd` test-as-proof rule (which
already says "code and tests in separate PRs" in its 0.2.0 changelog); needs a
design decision on whether it's a new skill or a `yegor-bdd` expansion, and the
2026-06-26 pass didn't select it.

**When to revisit:** if the two-phase (requirement-review then implementation)
flow becomes a repeated friction point, or when `yegor-bdd` is next revised.

**Surfaced by:** the 2026-06-26 coverage review.

---

## I-005 — Second-batch articles considered and deliberately NOT built (2026-06-26)

**What:** A 2026-06-26 research pass mined the *next ~20* Yegor articles (beyond
the original top-20). It shipped 4 new skills (`yegor-builds`, `yegor-simba`,
`yegor-projections`, `yegor-small-repos`) and 4 enhancement clusters
(philosophy_16–19). The following candidates surfaced in that pass but were
**deliberately declined** — recorded here so they aren't re-litigated from
scratch:

- **Standalone `yegor-quality-gate`** (*Strict Control of Java Code Quality*,
  2014). **Declined as a separate skill** — folded into `yegor-merge-gate`
  0.2.0 as the zero-tolerance bar. A standalone skill would overlap merge-gate
  and re-introduce the stack-coupling I-002 avoids (it leans Java/Qulice).
- **Standalone CI-maturity skill** (*8+2 Maturity Levels*, 2016). **Declined** —
  folded into `yegor-builds` as the self-audit ladder rather than its own skill.
- **Daily-reports / anti-standup skill** (*The Pain of Daily Reports*, 2020;
  *Daily Stand-up Meetings Are a Good Tool for a Bad Manager*, 2015). The
  enforceable nugget ("deliverables not activity, status lives in the tracker")
  is already covered by `yegor-tickets` + `yegor-velocity` + `yegor-simba`; the
  social-pressure mechanics are moot solo.
- **Definition of Done** (2014). Its enforceable rule (reporter accepts → close)
  is already `yegor-bdd`'s reporter-closes + `yegor-tickets`' never-close-empty.
- **Hits-of-Code** (2014) as a velocity dimension. Easy to compute but low
  marginal value over closed-tickets; left as a possible future scorecard column
  in `yegor-velocity` rather than a rule.
- **Greed-Based Planning / Calibrated Achievement Points / Incremental Billing /
  Hourly Pay Is Slavery** — pay-per-task and comp mechanics with no solo
  analogue; values arguments, not checkable rules.
- **Robots vs. Programmers** (2023) — qualitative AI prediction; good framing for
  *why* an agent-in-the-pipeline is legitimate, but no enforceable rule. Could
  seed a README/`yegor-pm` context note if ever wanted.
- **Educational Static Analysis** (2018, "forbid auto-fixers") and *Imprisonment
  for Irresponsible Coding* (2015) — out of scope: anti-automation stance
  conflicts with the AI-agent workflow, and the concrete content is OOP-style
  polemic (cf. I-002).

**Why deferred/declined:** each is either already covered by a shipped skill,
moot for solo+AI work, a values argument with no mechanical check, or
stack-coupled in a way I-002 rules out.

**When to revisit:** if a consuming project specifically wants the team-era
mechanics (pay-per-task, daily reports), or if the velocity scorecard grows and
Hits-of-Code earns a column.

**Surfaced by:** the 2026-06-26 "next-20" research pass (two parallel research
agents; see `research/philosophy_12`–`19`).

---

## I-006 — Pre-commit/CI lint helpers for the new mechanical gates

**What:** Several second-batch rules are *mechanically checkable* and could ship
as optional repo tooling rather than living only as skill prose:
- a **testless-PR check** (diff touches `src/**` but no `test/**` → fail) for the
  `yegor-review` gate;
- a **bug-title lint** (reject `?`/interrogative titles, require a breakage
  keyword) for `yegor-bdd`, runnable as a GH issue-form/Action;
- a **stale-ticket detector** (in-progress + idle > N days → flag) for
  `yegor-stuck` / `yegor-simba`;
- a **Cost-of-PR** reporter (open→merge timestamps) for the `yegor-velocity`
  scorecard.

**Why deferred:** same reasoning as I-001 — the skills are portable across every
project; per-repo tooling is an install cost worth paying only once a consuming
project asks. Prove the prose-level rules in practice first.

**When to revisit:** when a project adopts these skills and wants the gates
enforced mechanically in CI, or if an agent repeatedly violates one of the
prose-only gates.

**Surfaced by:** the 2026-06-26 "next-20" research pass.

---

## I-007 — Requirements / spec-authoring discipline (deferred)

**What:** A discipline (skill or fold-in) for *authoring requirements and specs* —
the one XDSD role with no dedicated skill. Sources:
- *How We Write a Product Vision* (2014) — a ≤2-page vision: product statement
  (<60 words), stakeholders+needs, actors+features, and **≤6 measurable quality
  requirements**.
- *10 Typical Mistakes in Specs* (2015) — a spec-smell checklist.
- *Incremental Requirements With Requs* (2014) — the REQ role: translate the PO's
  vague wishes into formal, unambiguous, manual-like specs; demonstrate against
  them.

**Why it's a real gap:** scope creep is rampant and nothing in the family owns the
*what* (only the *how* — architect — and the deferral/decomposition — pdd/spikes).
`yegor-personas` even seats an unstaffed **REQ** voice ("is it in the spec?"), so
the methodology already leans on a role we don't encode.

**Why deferred (decided 2026-06-26):** the user scoped this pass to *strengthen
existing skills first* and build `yegor-personas`. The cheapest measurable nugget
— **quality requirements must be numbers, not adjectives** — was already folded
into `yegor-nohelp` 0.2.0 (philosophy_22), which covers the most checkable part.

**When to revisit:** if a consuming project needs formal specs/PRDs, or if the
REQ persona in `yegor-personas` repeatedly needs a spec that doesn't exist. The
cleanest first cut is a new `yegor-requirements` skill (product-vision template +
spec-mistakes checklist + measurable-requirements rule), or a deeper fold into
`yegor-architect` (the architect designs against the spec) + `yegor-spikes` (scope
before puzzle).

**Surfaced by:** the 2026-06-26 "next-20" (third) research pass.

---

## I-008 — Speculative / stack-coupled third-pass candidates (declined)

**What:** Third-pass articles that surfaced but were **deliberately declined**
(2026-06-26), recorded so they aren't re-litigated:

- **LLM "Code Interpretability Score" build gate** (*Comments Considered Harmful
  in the Age of LLMs*, 2026): "fail the build if an LLM can't explain a function
  at ≥90% confidence." Declined — the 90% threshold is arbitrary/unstable, the
  idea is speculative (2026-vintage), and a flaky LLM-judged gate fights the
  zero-tolerance *binary* gate (philosophy_19). The stack-agnostic kernel —
  *code should be clear enough to read without comments* — is already implicit in
  `yegor-nohelp` / `yegor-unit-tests`.
- **9-step "refactoring-as-learning" sequence** (*Learning by Refactoring*, 2018):
  partly **OOP-coupled** (remove-NULLs, immutabilify, remove-statics) — the exact
  Elegant-Objects material I-002 keeps out of scope. The stack-neutral steps
  (shorten names, add tests, run static analysis) are already covered by
  `yegor-review` / `yegor-unit-tests` / `yegor-merge-gate`.
- **Management/comp polemics** — *Altruism Kills!* (2019), *How to Fire Someone
  Right* (2015): out of scope (team-comp/HR, no solo or mechanically-checkable
  analogue), same rationale as the I-005 pay-per-task cluster.

**When to revisit:** if the repo's scope deliberately broadens to code-design
opinions (then see I-002's stack-agnostic-subset note), or if a consuming project
specifically wants an LLM-clarity gate and accepts its flakiness.

**Surfaced by:** the 2026-06-26 third research pass.
