# Philosophy 16 — Tests as Warranty & the Two-PR Workflow

> **Why this doc exists:** capture Yegor's argument that a pull request without a
> test is a waste (a test is the *warranty* on the code), the workflow of
> shipping tests and code in separate PRs, and the supporting structural rules
> (private-method-to-class, test layout, built-in fakes). Translate them for a
> solo developer working with AI agents, where the testless-PR gate is a binary
> check an agent can self-enforce and the two-PR flow maps onto spec-first work.
> This cluster enhances `yegor-review` (the gate) and `yegor-unit-tests` (the
> craft); it resolves IDEAS I-003 and I-004.
>
> **Primary sources:**
> - Yegor Bugayenko, *A Pull Request Without a Test Is a Waste* (2025-06-08) — https://www.yegor256.com/2025/06/08/pull-request-without-test.html
> - Yegor Bugayenko, *The Code and Its Tests in Different Pull Requests* (2022-08-04) — https://www.yegor256.com/2022/08/04/code-and-tests-different-pull-requests.html
> - Yegor Bugayenko, *Each Private Static Method Is a Candidate for a New Class* (2017-02-07) — https://www.yegor256.com/2017/02/07/private-method-is-new-class.html
> - Yegor Bugayenko, *On the Layout of Tests* (2023) — https://www.yegor256.com/2023/01/19/layout-of-tests.html
> - Yegor Bugayenko, *Built-in Fake Objects* (2014-09-23) — https://www.yegor256.com/2014/09/23/built-in-fake-objects.html

---

## The principle (paraphrased)

A test is the **warranty** on the code it covers. Working code has value to
whoever paid for it; that value survives the *next* change only if a test proves
the behavior still holds. So a pull request that adds or modifies production code
but ships **no test** wastes the very value it adds — the untested code is the
first thing to break on the next refactor, and nothing will catch it.

From this follow several rules:

1. **Every production change ships a test** — no "it's obviously correct"
   exemption (obvious code breaks too). This is a binary, diff-checkable gate:
   prod files changed + test files untouched → reject. The only honest exception
   is a change that is *only* tests, docs, or config.
2. **Tests and code can go in separate PRs.** PR #1 adds the tests, possibly
   *disabled*, and is reviewed as **requirements** ("is this the behavior we
   want?"). PR #2 makes them pass **without editing the test bodies**. The author
   physically cannot bend the tests to fit the code, because the tests were
   reviewed and frozen first.

## Why it works

- **It separates "what" review from "how" review.** Reviewing a disabled test
  asks "is this the right requirement?" — a different, cleaner question than
  "is this implementation good?". Mixing them in one PR muddies both.
- **It removes the bend-the-test temptation.** When code and test land together,
  a failing test is "fixed" by weakening the test. Freezing the test first makes
  that impossible.
- **The gate is mechanical.** "Did this PR touch a test?" is a one-line diff
  check — the cheapest possible quality gate, and an agent is the ideal enforcer.

## How this maps onto AI-agent work

The two-PR flow is a near-perfect fit for spec-first agent development:

- The agent writes the **failing spec first** (PR #1, disabled).
- A human or reviewer approves the **requirement** — not the implementation.
- A second pass turns it green **without touching the spec** (PR #2).

The agent never gets to define both the requirement and declare it met in one
unreviewed motion — the same no-self-blessing logic as the merge gate
(philosophy_11), applied to tests.

## Supporting structural rules

- **A private method is a candidate for a new class.** If a private method holds
  behavior worth testing, don't reflect into it (the Inspector anti-pattern,
  philosophy_09) — extract it into its own small class with a public surface and
  test it directly. Untestable privates are a design smell, not a testing
  problem.
- **Test layout discipline** (*On the Layout of Tests*): `FooTest` tests `Foo`
  (one test class per unit); methods are named for the **behavior**, never
  `test1`/`test2`; a test class contains only test methods (no helper
  masquerading as a test); each assertion carries a descriptive **message** so a
  failure reads as a sentence.
- **Ship fakes as production classes** (*Built-in Fake Objects*): a `FakeFoo`
  lives next to `Foo` in `src/`, part of the library's public surface, so
  downstream users test against your fake instead of rebuilding their own. A fake
  hidden in `test/` only helps you. This is the constructive complement to
  fakes-over-mocks (philosophy_09).
- **(Declined) Single-statement tests.** Yegor advocates collapsing each test to
  one statement; we deliberately decline the purist form — it fights "assert what
  the one behavior needs" and tends to produce unreadable one-liners. Keep tests
  short, not contorted.

## Canonical rules

- **Every production change ships a test** — binary gate, prod-changed +
  tests-untouched → reject (exception: tests/docs/config-only).
- **A test is a warranty** — it protects the value of working code across the
  next change.
- **Tests-first, two PRs for non-trivial work** — disabled tests reviewed as
  requirements first; code makes them pass without editing them.
- **Extract a tested private method into its own class** — don't reflect into it.
- **Test layout:** one `FooTest` per `Foo`, behavior-named methods, only test
  methods, descriptive assertion messages.
- **Fakes are production classes**, shipped in `src/` next to the real thing.

## Translating for solo + AI work

- **The agent self-enforces the gate.** Before proposing a merge, the agent
  checks its own diff: did it touch a test? If not, it adds one or flags the PR
  as testless. No human prompt needed.
- **Spec-first is the two-PR flow.** Have the agent write the disabled spec,
  approve the *requirement*, then let it implement to green without touching the
  spec.
- **Don't reflect to test internals.** When the agent reaches for reflection to
  test a private, that's the signal to extract a class instead.

## Pitfalls

- **Blessing a testless PR** because the code "looks right".
- **Bending the test to the code** when both land together — freeze the test
  first.
- **Reflecting into privates** instead of extracting a testable class.
- **Hiding fakes in `test/`** so downstream users can't reuse them.
- **Single-statement contortions** in pursuit of a rule that hurts readability.

## Integration with the other philosophies

- + [Review](./philosophy_08_review_serious_code_reviewer.md): the testless-PR
  gate is enforced at review; it's a binary reject condition.
- + [Unit tests](./philosophy_09_unit_tests_anti_patterns.md): the warranty
  rule, the two-PR flow, and the structural rules all sharpen the craft of the
  test itself.
- + [BDD](./philosophy_02_bdd_bug_driven_development.md): the disabled test that
  proves a bug is exactly PR #1 of the two-PR flow.
- + [Merge gate](./philosophy_11_merge_gate_readonly_master.md): "every change
  ships a test" is rung 5 of the CI-maturity ladder (philosophy_12); the gate
  enforces it, and freezing the test first is no-self-blessing applied to tests.

## One-line summary for Claude

> A PR that changes production code but ships no test is a waste — reject it (a
> test is the warranty on the code). For non-trivial work, land the tests first,
> disabled, reviewed as requirements; then make them pass without editing them —
> the spec-first two-PR flow. Extract tested privates into their own class, ship
> fakes as production classes, and give every assertion a message.
