# Changelog -- yegor-review

All notable changes to this skill are documented here.
Versioning follows Semantic Versioning (https://semver.org/).

## [0.2.0] -- 2026-06-26

### Added
- The testless-PR gate: a PR that changes production code but ships zero tests
  fails review on sight (binary, diff-checkable: prod changed, tests
  untouched → reject), with the "tests protect the employer's investment"
  justification; honest exception for tests/docs/config-only changes. Added as
  a Core rule and a Pitfall.
- Distilled from Yegor Bugayenko's "A Pull Request Without a Test Is a Waste"
  (2025); pairs with the "Code and Its Tests in Different Pull Requests" (2022)
  workflow now in yegor-unit-tests.
- Deep reference: research/philosophy_16_tests_as_warranty_separate_prs.md

## [0.1.0] -- 2026-05-28

### Added
- Initial release.
- Distilled from Yegor Bugayenko's primary sources (see SKILL.md for citations).
- The Four NOs, reject-don't-bless burden of proof, the 3-critical-problems
  scope rule, reviewers-don't-run-the-code, and the two-layer (peer +
  independent) review model.
- Deep reference: research/philosophy_08_review_serious_code_reviewer.md
