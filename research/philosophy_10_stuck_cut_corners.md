# Philosophy 10 — Cut Corners, Don't Be a Hero (the stuck protocol)

> **Why this doc exists:** capture Yegor's rule that a stuck/blocked developer's
> duty is to *reveal* the problem, not heroically conceal it by grinding — and
> turn his escalating "acceptable corner-cuts" into a protocol Claude can follow
> when it would otherwise thrash or fabricate a fix.
>
> **Primary sources:**
> - Yegor Bugayenko, *How to Cut Corners and Stay Cool* (2015-01-15) — https://www.yegor256.com/2015/01/15/how-to-cut-corners.html
> - Yegor Bugayenko, *Definition of Done* (2014-04-15) — https://www.yegor256.com/2014/04/15/definition-of-done.html (acceptance, not "I think it works")
> - Related: emergency disable-then-repay from *Write Unit Tests, Don't Waste Our Money!* (2025) — see philosophy_09.

---

## The principle (paraphrased)

When a task becomes impossible, too expensive, or blocked, the professional move
is to **reveal the obstacle**, not to disappear into heroic grinding or to ship a
fix that hides the problem. Yegor's framing: *production errors are not the
programmer's mistakes — delayed and concealed tickets are.* Being a professional
does not mean you can solve everything; it means you are **honest about what you
can't**, immediately and visibly.

A "hero" who silently burns a day forcing an impossible task is not admirable —
they have converted a cheap, revealable blocker into an expensive, hidden delay.

## Why it works

- **Revealed blockers are cheap; concealed ones compound.** A block surfaced in
  five minutes costs five minutes. The same block hidden for a day costs a day —
  plus the trust lost when it finally surfaces.
- **Every exit produces an artifact.** Each rung leaves a visible, trackable
  trace (a block, a question, a skipped test, a proof test, a disable + ticket).
  Nothing is lost; the next person (or session) can pick it up.
- **It kills the two worst failure modes.** Grinding (wasted time) and faking
  green (a lie shipped to production). Both come from refusing to admit "stuck."
- **It's the honest version of "done."** Done is acceptance, not "I think it
  works" — so a cut corner is declared, not smuggled.

## The escalating ladder (cheapest principled exit first)

Take the **lowest rung that honestly applies**:

1. **Block and pause.** File an explicit blocking dependency; move to the next
   unblocked task. The block is visible on the ticket.
2. **Demand documentation.** If the requirement is undefined, file a question and
   demand the spec rather than guessing. The ambiguity becomes someone's job.
3. **Reproduce as a skipped failing test, then move on.** A real, reproducible
   bug you can't fix now becomes a disabled test that *proves* it, plus a filed
   complaint. Pinned down, not lost.
4. **Prove-absent and close.** A complaint you *cannot* reproduce gets a *passing*
   test showing the code behaves as designed, attached as evidence, and the
   ticket closes "can't reproduce — see test."
5. **Disable the feature and ship.** A broken feature that can't be fixed in
   budget is disabled; the rest ships; a re-enable ticket is filed.

**Refusing the work entirely** is the last resort, only when no rung applies.

## The one corner you must never cut

**Unit tests.** Every other corner is fair under pressure; tests are not. The
only exception is a genuine production-down emergency, and even then the disabled
test is a debt repaid in the *very next* task (see philosophy_09).

## Actionable guidelines

### How Claude should use this

- **Detect thrashing early.** Repeated failed attempts, growing scope, "just one
  more try" — that's the signal to stop and pick a rung, announcing which one.
- **Never silently absorb a blocker.** If you can't do what was asked, say so and
  choose a rung. Don't quietly swap in an easier task and report it as progress.
- **Never fabricate green.** Faking a pass, swallowing an exception, hardcoding an
  expected value — this is the exact thing the skill exists to prevent. A truthful
  red/skipped test beats a lying green one.
- **Produce the rung's artifact.** No artifact means the corner was cut
  dishonestly. The block, the question, the skipped/proof test, the re-enable
  ticket — one of them must exist.

## Pitfalls

- **Hero mode.** Grinding silently to avoid admitting you're stuck.
- **Fake-it-to-green.** Bending test or code to fake success — the forbidden cut.
- **Silent scope-swap.** Doing an easier adjacent thing and calling it the task.
- **Artifact-less exit.** Declaring "blocked / can't repro / disabled" without the
  ticket or test that makes it real and trackable.

## Integration with the other philosophies

- + [Microtasks](./philosophy_03_microtasks_microtasking.md): an overrun is a cue
  to stop and split, not to grind — this is what "stop" concretely looks like.
- + [BDD](./philosophy_02_bdd_bug_driven_development.md): rungs 3 & 4 produce the
  complaint-as-test (failing/disabled, or proving-absent).
- + [PDD](./philosophy_01_pdd_puzzle_driven_development.md): leftover work from a
  cut corner becomes a `@todo` puzzle / ticket.
- + [Tickets](./philosophy_04_tickets_ticket_as_conversation.md): every rung's
  artifact lives in the tracker.

## One-line summary for Claude

> When stuck, reveal it — don't grind and don't fake green. Take the cheapest
> honest rung (block, demand docs, reproduce-as-skipped-test, prove-absent,
> disable-and-ship) and leave the artifact that proves it. Never cut unit tests.
