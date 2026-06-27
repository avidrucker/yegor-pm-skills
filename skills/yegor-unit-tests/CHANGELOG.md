# Changelog -- yegor-unit-tests

All notable changes to this skill are documented here.
Versioning follows Semantic Versioning (https://semver.org/).

## [0.2.0] -- 2026-06-26

### Added
- "A test is a warranty" section: every production change ships a test (the
  test side of yegor-review's testless-PR gate), plus the tests-first **two-PR
  workflow** (disabled tests land first as reviewed *requirements*; a second PR
  makes them pass without editing the test bodies) — maps onto a spec-first
  agent workflow.
- "Structural rules" section: promote a tested private method to its own class
  (don't reflect into it); test-layout discipline (`FooTest` tests `Foo`,
  behavior-named methods, only test methods in the class, descriptive
  assertion messages); and a note that we considered and **declined** the
  single-statement-test purism.
- "Ship fakes as production classes" (a `FakeFoo` next to `Foo` in `src/`, not
  hidden in `test/`), the constructive complement to fakes-over-mocks.
- Distilled from Yegor Bugayenko's "A Pull Request Without a Test Is a Waste"
  (2025), "The Code and Its Tests in Different Pull Requests" (2022), "Each
  Private Static Method Is a Candidate for a New Class" (2017), "On the Layout
  of Tests" (2023), and "Built-in Fake Objects" (2014). Resolves IDEAS I-003
  and I-004.
- Deep reference: research/philosophy_16_tests_as_warranty_separate_prs.md

## [0.1.0] -- 2026-05-28

### Added
- Initial release.
- Distilled from Yegor Bugayenko's primary sources (see SKILL.md for citations).
- Positive test-quality rules, the fakes-over-mocks rule, and the full
  anti-pattern catalog (the Liar, Inspector, Mockery, Happy Path, Giant, etc.)
  as review red flags.
- Deep reference: research/philosophy_09_unit_tests_anti_patterns.md
