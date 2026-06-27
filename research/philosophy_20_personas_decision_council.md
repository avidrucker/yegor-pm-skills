# Philosophy 20 — The Personas Decision Council

> **Why this doc exists:** capture how Yegor's strict *role separation* — distinct
> people/agents holding distinct roles, never wearing two hats — becomes a
> decision technique: evaluate a hard call through the strict lens of each role
> that has standing, then converge through a fixed authority hierarchy rather than
> by averaging opinions. Translate it for a solo developer working with AI agents,
> where Claude can voice every role at once but must keep their authority straight.
> This is the deep reference for `yegor-personas`.
>
> **Primary sources:**
> - Yegor Bugayenko, *Key Roles in a Software Project* (2016-07-10) — https://www.yegor256.com/2016/07/10/software-project-roles.html
> - Yegor Bugayenko, *What if the Architect is Wrong?* (2019-01-15) — https://www.yegor256.com/2019/01/15/what-if-architect-is-wrong.html
> - Yegor Bugayenko, *Four NOs of a Serious Code Reviewer* (2015-02-09) — https://www.yegor256.com/2015/02/09/serious-code-reviewer.html
> - Related: *Who Is an Architect?* (2014), *Let the Bug Reporter Have the Last Word* (2025) — the rung-4 and rung-5 authorities.

---

## The principle (paraphrased)

XDSD assigns a software project a fixed set of **roles** — PM, PO, ARC
(architect), DEV (programmer), REQ (requirements/system analyst), QA, TST
(tester) — and insists they be held by **different actors**. The point is not
bureaucracy; it's that a single person cannot impartially judge a decision they
have a stake in. Conflicts between roles are a *feature*: they surface
disagreement early, before code is written. Crucially, XDSD does **not** resolve
those conflicts by consensus or by meeting in the middle. It resolves them through
a fixed **authority hierarchy**: requirements are the ultimate boss; the architect
breaks technical ties and "doesn't need to convince anyone"; the reporter has the
last word on their own ticket; the merge bot is binary. No compromise — one side
concedes, or the owning authority decides.

The `yegor-personas` skill turns this into a decision technique. For a hard call,
seat the roles (and the `yegor-*` skills that embody them) that have **standing**,
let each give its strictest reading against its own failure mode, then converge by
walking the authority ladder.

## Why it works

- **Different lenses catch different failures.** The bug-reporter lens hunts the
  faux-complaint; the reviewer lens hunts the missing proving test; the velocity
  lens hunts the gamed metric. One reasoner wearing one hat misses what another hat
  would have caught. Seating several strict lenses is a cheap way to widen the net
  before committing.
- **Authority, not volume, decides.** Averaging opinions produces the worst
  outcome — a half-accepted bad answer (the Four NOs' "No Compromise"). A fixed
  ladder means the *right* role decides, regardless of how many advisory voices
  lean the other way. The output is decisive, not mushy.
- **Standing prevents theater.** Running every role on every decision is noise.
  Requiring *standing* (does this role's creed actually apply?) keeps the council
  to the 3–5 voices that matter and stops cherry-picking the friendly ones.
- **It's honest about open conflicts.** When the ladder doesn't resolve a fork, the
  technique's correct output is a *named* unresolved conflict plus who must decide
  — not a fabricated consensus.

## The authority ladder (first match decides, then stop)

1. **Requirements are the ultimate boss.** If the spec settles the fork, it's
   settled — no vote. Silence/ambiguity in the spec is itself a finding: file the
   requirements gap, then descend. (*What if the Architect is Wrong?* — "the only
   real boss of the architect is requirements.")
2. **Binary gates are unoverrideable.** A merge-gate/red-build question is not a
   council matter; green or red is binary (philosophy_11/19).
3. **Objective measures decide themselves.** A `pdd` scan, the ≤60m `microtasks`
   budget, a `spikes` "is scope clear?", `velocity`/`projections` data — the
   measurement rules; report it and stop.
4. **The reporter owns their ticket.** Label/scope/closure of a specific ticket is
   the reporter's last word (philosophy_02; *Let the Bug Reporter Have the Last
   Word*). The council presents options; the reporter picks.
5. **The architect breaks technical ties.** Remaining design/approach conflict is
   the architect's call, made in writing, without needing to convince
   (philosophy_05/21).
6. **No compromise — name the concession.** If still unresolved, don't average;
   state the open conflict and name who must concede or decide.

Invariants: **role separation** (a persona with a personal stake is advisory only)
and **standing beats volume**.

## Canonical rules

- **Seat 3–5 personas with standing** — never all 17; one means no council; all
  means the fork isn't framed.
- **Each persona reads against its own failure mode**, in a fixed VERDICT /
  BECAUSE / STANDING format.
- **Sort by authority, not volume.**
- **Converge via the ladder; name dissent and the deciding authority.**
- **Record the convergence** as a ticket artifact (philosophy_04).
- **Voice the unstaffed roles** (REQ/PO/QA/TST) when the fork is about spec, scope,
  process, or repro.

## Translating for solo + AI work

Solo, Claude is *every* role at once — which is exactly the hazard: a single
reasoner blurs the hats and rationalises toward the answer it already wants. The
council is the discipline that keeps the hats distinct:

- **Run it deliberately, on hard calls** — a decision with more than one defensible
  answer, or when the user asks for the strict/picky read. Routine work is a
  `yegor-pm` route, not a council.
- **Frame the fork, select standing, read, converge** — skipping selection (running
  all 17) is the most common failure.
- **Keep authority straight even when you hold every role.** The reporter-hat's
  last word still outranks the solver-hat's preference; the binary gate still
  outranks the reporter's wish. Claude must enforce the ladder against itself.
- **Lead with the convergence, then the readings** — the user wants a
  recommendation with its authority named, not a transcript.

## Actionable guidelines

### How Claude should use this

- When the user says "what would the personas say" / "be strict, picky, thorough,"
  convene: state the fork, seat 3–5 with standing, give each a 3-line reading, then
  converge with the deciding rung named.
- Stop early if an objective persona settles it ("the ≤60m budget decides this —
  no council needed").
- When the ladder leaves a real split, output the named conflict and the authority
  that owns it, not a fake midpoint.

### Anchor walkthrough — "is this a bug?" (the contract-vs-code label dispute)

A close/label dispute: code omits a `--force` flag its own written CONTRACT
specifies, but the divergence does not reproduce in the supported flow. Should it
be filed as a **bug**?

```
bdd — Not a bug; it's a faux complaint as framed.
  BECAUSE: a real complaint names a concrete current wrong behavior, not a
  hypothetical. "Teardown breaks" doesn't reproduce; the real wrong is "code ≠
  spec." And the only failing test you could write is contrived — a yellow flag.
  STANDING: tie-breaker on what counts as a valid complaint.
architect — A design call, not a courier fix.
  BECAUSE: the divergence raises a design question (should the contract even
  require --force, given the clean-tree guard?). A courier must not prescribe
  "add --force" — that pre-commits the architect's decision. Present both
  resolutions; the reporter rules.
  STANDING: tie-breaker on the design question (rung 5).
review — No bullshit; adding code needs a proving test.
  BECAUSE: dressing a non-reproducing issue as a bug is rejectable; the CONTRACT
  doc is docs-only, but adding --force is a prod change that needs a test, and the
  only honest one is the contrived lock scenario.
  STANDING: advisory.
velocity — Anti-gaming: don't inflate the bug counts.
  BECAUSE: filing-then-"fixing" something that never broke inflates
  bugs-reported/bugs-fixed; the validators would flag it.
  STANDING: advisory.
tickets — But don't let it vanish. Record it.
  BECAUSE: a real divergence shouldn't evaporate into chat.
  STANDING: advisory.
```

**Convergence:** File it — but **not** as a bug. Frame it as a **CONTRACT-vs-code
parity divergence**, mark the runtime impact honestly as *masked* (doesn't
reproduce in the supported flow), present **both** candidate resolutions (add
`--force`, or drop it from the contract since the clean-tree guard already
guarantees a clean tree), and prescribe **neither**. **Authority:** the label is
the reporter's last word (rung 4); the underlying "code should match spec" frame is
the REQ/requirements voice (rung 1); the architect (rung 5) owns which resolution
ships. This is the target quality: strict, picky, decisive, with the convergence
and its authority named.

## Pitfalls

- **Cherry-picking** the friendly personas instead of seating by standing.
- **Endless debate / faked unanimity** instead of converging via the ladder.
- **Running all 17** when 3 suffice — theater that hides the real authority.
- **Letting advisory volume outvote** the reporter's last word or a binary gate.
- **Blurring the hats** (solo) — rationalising toward a pre-chosen answer because
  one reasoner holds every role.

## Integration with the other philosophies

- + [Architect](./philosophy_05_architect_then_courier.md) &
  [Architect authority](./philosophy_21_architect_authority.md): the architect is
  the rung-5 tie-breaker; "requirements are the boss" is rung 1.
- + [Review](./philosophy_08_review_serious_code_reviewer.md): "No Compromise"
  governs how the council resolves, not just how PRs resolve.
- + [BDD](./philosophy_02_bdd_bug_driven_development.md): the reporter's last word
  is rung 4.
- + [Merge gate](./philosophy_11_merge_gate_readonly_master.md): the binary,
  unoverrideable rung 2.
- + [Tickets](./philosophy_04_tickets_ticket_as_conversation.md): the convergence
  is recorded, or it didn't happen.

## One-line summary for Claude

> For a hard decision, convene a council: seat the 3–5 personas with standing, take
> each one's strict reading against its own failure mode, then converge via the
> authority ladder (requirements → binary gate → objective measure → reporter →
> architect → name-the-concession). Authority decides, not volume; name the dissent
> and who breaks it; never fake unanimity.
