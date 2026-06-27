---
name: yegor-unit-tests
description: Unit-test quality discipline from Yegor Bugayenko. A checklist of named anti-patterns (Liar, Inspector, Mockery, Happy Path, Giant, Free Ride, ...) plus the positive rules — descriptive names, real assertions, test boundaries not just the happy path, isolation, speed, and fakes over mock frameworks. Also: a test is a warranty on the code (every change ships one), the tests-first / two-PR workflow, promoting private methods to their own testable class, test-layout rules, and shipping fakes as production classes. Use when writing, reviewing, or refactoring unit tests.
version: 0.2.0
last_reviewed: 2026-06-26
---

# Yegor Unit Tests

Tests are first-class code. A test that can't fail is worse than no test — it lies. Use this when writing OR reviewing tests; most anti-patterns are review red flags.

## Triggers
- Writing new unit tests
- Reviewing tests in a PR (a test diff deserves the same scrutiny as code)
- A test "passes" but you're unsure it proves anything
- Refactoring or deleting tests

## Positive rules (what a good test is)

- **Descriptive name.** The name states the behavior under test. No `test1`/`test2` (Enumerator).
- **Real assertions.** Every test asserts on output. No test that passes regardless of the code (Liar), hits lines without checking results (Line Hitter), or relies only on "didn't throw" (Secret Catcher).
- **Test boundaries and failures, not just the Happy Path.** Edge cases, exceptions, and error paths — not only the expected-success route.
- **Isolation.** Each test is independent: no shared mutable state (Generous Leftovers), no order dependence (Sequencer), no leaking into a sibling (Conjoined Twins). Order-randomizable.
- **Fast.** A slow unit test (Slow Poke) is an integration test in disguise — move it or mock the boundary.
- **Encapsulation-respecting.** Test through the public surface; no reflection to poke private fields (Anal Probe / Inspector). Tests that break on every refactor test the wrong thing.
- **Minimal setup.** Hundreds of lines of fixture (Excessive Setup) signals a design problem in the unit, not the test.
- **One concern per test, one test per concern.** Don't bolt extra asserts onto an existing test (Free Ride); don't pack thousands of cases into one method (Giant). (But don't over-correct into rigid one-assert-per-method either — assert what the *one behavior* requires.)
- **Quiet.** No console spam on success (Loudmouth); no swallowed exceptions or replaced stack traces (Greedy Catcher).
- **Test the core, at close range.** Don't test trivial side effects while dodging the real behavior (Dodger), and don't test through five layers of abstraction (Forty-Foot Pole).

## Fakes over mocks

Mock *frameworks* turn tests into an unmaintainable mess and often end up testing the mocks, not the code (Mockery). Prefer **fake objects** — real, simple working implementations — shipped alongside production code so both the library and its users can test against them. Reach for a mocking framework only when a fake genuinely isn't practical.

**Ship fakes as production classes**, not buried in the test folder. A fake is a first-class part of the library's public surface: a `FakeFoo` lives next to `Foo` in `src/`, so downstream users can test against your library without rebuilding their own stand-ins. A fake hidden in `test/` only helps your own tests.

## A test is a warranty — every change ships one

A test is not an optional extra; it is the **warranty** on the code. Untested production code is the first thing to break on the next refactor, so a change contributed without a test quietly wastes the value it adds.

- **Every production change ships a test.** No exceptions for "it's obviously correct" — obvious code breaks too, and the test is what proves it still works after the next change. (This is the `yegor-review` testless-PR gate, stated from the test side.)
- **Tests-first, in a separate PR (the two-PR workflow).** Where the change is non-trivial, land the **tests first — added disabled — in their own PR**, reviewed purely as *requirements* ("is this the right behavior?"). A second PR makes them pass **without editing the test bodies**. This guarantees the author couldn't bend the tests to fit the code: the "what" is reviewed before the "how" exists. It cleanly separates requirement-review from implementation-review, which maps well onto a spec-first agent workflow (agent writes the failing spec; a human/reviewer approves the *requirement*; a second pass turns it green without touching the spec).

## Structural rules

- **A private method is a candidate for a new class.** Don't reach into private methods with reflection to test them (that's the Inspector/Anal Probe anti-pattern). If a private method has behavior worth testing, that's a signal it wants to be its **own small class** with a public surface — extract it and test it directly.
- **Test layout discipline.** `FooTest` tests `Foo` (one test class per unit). Test methods are named for the **behavior** under test, never `test1`/`test2` (Enumerator). A test class contains only test methods — no stray helpers masquerading as tests (Cuckoo). Prefer a descriptive **assertion message** on each assert so a failure reads as a sentence, not a bare `expected X got Y`.
- **(Considered and declined) Single-statement tests.** Yegor advocates collapsing each test to one statement. We *don't* adopt the purist form — it fights the "assert what the one behavior needs" rule below and tends to produce unreadable one-liners. Keep tests short, but don't contort them to hit a single statement.

## The anti-pattern catalog (review red flags)

| Anti-pattern | Smell |
|---|---|
| The Liar | Passes regardless of code changes; validates nothing |
| Line Hitter | 100% coverage, zero output analysis |
| Secret Catcher | No visible assertion; relies on an exception being thrown |
| Happy Path | Only the success case; no boundaries/exceptions |
| Mockery | So many mocks the real subject isn't exercised |
| Inspector / Anal Probe | Reflection into private state; brittle to refactors |
| Excessive Setup | Hundreds of lines of fixture per test |
| Giant | One test, thousands of lines / many cases |
| Free Ride | New assertions bolted onto an existing test |
| Generous Leftovers | One test leaves data another depends on |
| Sequencer | Depends on unordered items in a fixed order |
| Conjoined Twins | "Unit" tests with no isolation from each other |
| Enumerator | Numbered names (`test1`, `test2`) |
| Slow Poke | Long-running "unit" test |
| Loudmouth | Console clutter on passing runs |
| Greedy Catcher | Swallows exceptions / drops stack traces |
| Local Hero | Passes only on one dev's machine/env |
| Nitpicker | Asserts the whole output when only a slice matters |
| Dodger | Tests side effects, dodges the core behavior |
| Cuckoo | Test method that doesn't belong in its class |
| Forty-Foot Pole | Tests the unit through too many layers |

## Pitfalls
- **Coverage as the goal.** 100% coverage with Liars/Line Hitters proves nothing. Coverage is a floor, not a target.
- **Over-mocking.** If the test is mostly mock wiring, you're testing the wiring.
- **One-assert dogma.** Don't split one behavior across many tests just to obey a rule — assert what the behavior needs.

## Cross-references
- `yegor-review` — a runtime-only bug means the suite is too weak; these rules say how. The testless-PR gate (warranty rule) is enforced there at review time.
- `yegor-bdd` — a bug is reported as a failing/disabled test (test-as-proof); the two-PR workflow lands that disabled test first.
- `yegor-pdd` — gaps in the suite are filed as `@todo` puzzles or tickets, not ignored.
- `yegor-merge-gate` — "every change ships a test" is rung 5 of the CI-maturity ladder; the gate enforces it mechanically.

## Deep reference
- `research/philosophy_09_unit_tests_anti_patterns.md`
- `research/philosophy_16_tests_as_warranty_separate_prs.md` (warranty rule + two-PR workflow)
