# Philosophy 09 — Unit Test Quality & Anti-Patterns

> **Why this doc exists:** distill Yegor's unit-testing doctrine into actionable rules and a review-time checklist. Tests are first-class code; a test that can't fail is worse than none.
>
> **Primary sources:**
> - Yegor Bugayenko, *Unit Testing Anti-Patterns, Full List* (2018-12-11) — https://www.yegor256.com/2018/12/11/unit-testing-anti-patterns.html
> - Yegor Bugayenko, *Built-in Fake Objects* (2014-09-23) — https://www.yegor256.com/2014/09/23/built-in-fake-objects.html
> - Yegor Bugayenko, *Write Unit Tests, Don't Waste Our Money!* (2025-06-08) — https://www.yegor256.com/2025/06/08/pull-request-without-test.html

---

## The principle (paraphrased)

Unit tests are production code and deserve equal scrutiny. The point of a test
is to *fail when the code is wrong* — a test that passes regardless of the code
is a liability, because it gives false confidence. Coverage is a floor, never a
goal: 100% coverage full of assertion-free tests proves nothing.

## Positive rules (what a good test looks like)

- **Descriptive names** that state the behavior under test (not `test1`).
- **Real assertions** on output — every test must be able to fail for the right
  reason.
- **Boundaries and failure paths**, not just the happy path: edge cases,
  exceptions, error handling.
- **Isolation:** independent, order-randomizable, no shared mutable state, no
  leaking between tests.
- **Speed:** a slow "unit" test is an integration test in disguise.
- **Encapsulation-respecting:** test through the public surface; no reflection
  into private fields. A test that breaks on every refactor is testing the
  wrong thing.
- **Minimal setup:** excessive fixture signals a design problem in the unit.
- **One concern per test** without over-correcting into rigid one-assert dogma —
  assert what the single behavior requires.
- **Quiet:** no console spam on success; no swallowed exceptions or replaced
  stack traces.

## Fakes over mocks

Mock objects are a perfect *concept* for unit testing, but mock *frameworks*
frequently turn tests into an unmaintainable mess and, in the worst case, end up
testing the mocks instead of the code (the **Mockery** anti-pattern). Yegor's
recommendation: stay as far from mock frameworks as practical and instead build
**fake objects** — small, real, working implementations — and ship them
alongside production code (e.g. in the same package/JAR) so both the library and
its consumers can test against them. Reach for a mocking framework only when a
fake genuinely isn't feasible.

## The anti-pattern catalog

A review-time red-flag list (paraphrased from the full post):

- **The Liar** — passes regardless of code changes; validates nothing.
- **Line Hitter** — achieves coverage but performs no output analysis.
- **Secret Catcher** — no visible assertion; relies on an exception being thrown.
- **Happy Path** — only the success case; ignores boundaries and exceptions.
- **Mockery** — so many mocks/stubs the real subject isn't exercised.
- **Inspector** — violates encapsulation for coverage; brittle to refactoring.
- **Anal Probe** — reads private fields via reflection.
- **Excessive Setup** — hundreds of lines of setup per test.
- **The Giant** — one test spanning thousands of lines / many cases.
- **Free Ride** — new assertions bolted onto an existing test instead of a new one.
- **Generous Leftovers** — one test creates persistent data another reuses.
- **Sequencer** — depends on unordered items appearing in a fixed order.
- **Conjoined Twins** — "unit" tests with no isolation from each other.
- **Enumerator** — numerically named methods (`test1`, `test2`).
- **Slow Poke** — extremely long-running unit test.
- **Loudmouth** — clutters the console with diagnostics on passing runs.
- **Greedy Catcher** — catches/swallows exceptions or replaces stack traces.
- **Local Hero** — passes only in one specific dev environment.
- **Nitpicker** — compares the entire output when only a slice matters.
- **The Dodger** — tests minor side effects while avoiding the core behavior.
- **Cuckoo** — a test method that doesn't belong in its test class.
- **Forty-Foot Pole** — tests the unit through too many layers of abstraction.

## How Claude should use this when helping

- **Treat a test diff like a code diff.** Run the anti-pattern list over new or
  changed tests during review.
- **Demand a failing assertion.** If a proposed test would pass against the old
  (buggy) code, it isn't proving anything — see the test-as-proof rule in
  `yegor-bdd`.
- **Prefer fakes** when introducing test doubles; flag heavy mock-framework
  wiring as Mockery.
- **Never chase coverage numbers** at the expense of meaningful assertions.

## One-line summary for Claude

> Tests are first-class code that must be able to fail: descriptive names, real
> assertions, boundaries not just happy paths, isolation, speed, and fakes over
> mock frameworks — and run the anti-pattern catalog over every test diff.
