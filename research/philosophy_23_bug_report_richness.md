# Philosophy 23 — Bug-Report Richness

> **Why this doc exists:** the `yegor-bdd` skill shapes work as a complaint
> (have/should/repro) and lints the *title*; this doc adds the *body* discipline —
> a good report is reproducible, rich, and effortful — and translates it for solo
> + AI work, where an agent can lint a report for these qualities and draft the
> missing parts before the ticket is worked.
>
> **Primary source:**
> - Yegor Bugayenko, *The Right Way to Report a Bug* (2018-04-24) — https://www.yegor256.com/2018/04/24/right-way-to-report-bugs.html

---

## The principle (paraphrased)

A sharp title gets a complaint *noticed*; the body is what makes it *actionable*. A
one-line "X is broken" with no body just relocates the investigation onto the
solver, who must re-discover what the reporter already knew. Three qualities
separate a real bug report from a drive-by:

1. **Reproducible.** Steps from a clean, known state to the wrong behavior — exact
   inputs, exact commands, exact version/commit. "It sometimes fails" is not a
   repro.
2. **Rich.** Expected vs actual stated explicitly (the have/should gap spelled out),
   plus the environment that matters (OS, runtime version, config, data). The
   reader shouldn't need to ask a single clarifying question to begin.
3. **Effortful.** The reporter did the legwork — narrowed the case, attached the
   failing output/log/screenshot, removed the noise. A report that offloads all
   investigation onto the solver is low-effort.

The strongest report carries the proof inline: a failing/disabled test *is*
reproducible, rich, and effortful in one artifact (philosophy_02 test-as-proof).
When a test isn't yet possible, the body must still hit all three.

## Why it works

- **It moves the cost to where it's cheapest.** The reporter already has the context
  fresh; capturing it once is far cheaper than the solver reconstructing it cold.
- **It makes the complaint falsifiable.** A reproducible, rich report can be
  confirmed or refuted; a vague one can only be guessed at. (A non-reproducing
  report is itself a finding — `yegor-stuck` rung 4: prove-absent.)
- **Effort is a quality signal.** A report where the reporter narrowed the case is
  more likely to be real and is faster to fix; pushing back low-effort reports for
  narrowing protects the solver's time.

## Canonical rules

- **Reproducible** — clean-state steps, exact inputs, exact version/commit; "it
  sometimes fails" isn't a repro.
- **Rich** — expected vs actual + the relevant environment, so no clarifying
  question is needed to start.
- **Effortful** — narrowed case, attached output/logs; don't offload all
  investigation onto the solver.
- **Proof inline when possible** — a failing/disabled test is all three at once.

## Translating for solo + AI work

- **The agent lints the report, not just the title.** No repro steps? no
  expected-vs-actual? no environment? — flag it and either ask for them or draft
  them before the ticket is worked.
- **The agent does the narrowing.** When the user reports something vaguely, the
  agent's job is to reproduce, minimize, and capture the rich repro — turning a
  drive-by into a real report (this is also `diagnose`/`systematic-debugging`
  territory).
- **Prefer the test.** Whenever the agent can express the bug as a failing test, it
  should — that single artifact satisfies all three qualities and doubles as the
  regression guard.

## Actionable guidelines

### How Claude should use this

- **When filing a bug:** include clean-state repro steps, expected vs actual, and
  the environment; attach the failing output. Don't file "X is broken" alone.
- **When handed a vague report:** reproduce and minimize first; capture the rich
  repro before treating it as workable.
- **When reviewing an incoming report:** if it lacks repro/expected-actual/
  environment, push it back (or fill it in) before it's worked.

## Pitfalls

- **Title-only reports** — a great title with an empty body.
- **"Sometimes fails"** — non-deterministic hand-waving instead of a clean-state
  repro.
- **Missing expected-vs-actual** — forcing the solver to guess the intended
  behavior.
- **Offloaded investigation** — a low-effort report that makes the solver do the
  narrowing the reporter should have done.

## Integration with the other philosophies

- + [BDD](./philosophy_02_bdd_bug_driven_development.md): richness is the body
  discipline behind the complaint shape; the failing test is the richest form.
- + [Bug-tracking hygiene](./philosophy_17_bug_tracking_hygiene.md): the title lint
  is the headline; this is the body.
- + [Stuck](./philosophy_10_stuck_cut_corners.md): a non-reproducing report is the
  prove-absent rung, not a dead end.
- + [Unit tests](./philosophy_09_unit_tests_anti_patterns.md): the proving test must
  be a real test, able to fail.

## One-line summary for Claude

> A good title gets a bug noticed; a good *body* gets it fixed — make every report
> reproducible (clean-state steps + exact version), rich (expected vs actual +
> environment), and effortful (narrowed, with output attached). Best of all, file
> the failing test: it's all three in one artifact.
