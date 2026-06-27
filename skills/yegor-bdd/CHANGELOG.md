# Changelog -- yegor-bdd

All notable changes to this skill are documented here.
Versioning follows Semantic Versioning (https://semver.org/).

## [0.4.0] -- 2026-06-26

### Added
- "Report richness" section: a sharp title gets a complaint noticed, but the
  body makes it actionable. Three qualities — reproducible (clean-state steps,
  exact version/commit), rich (expected vs actual + environment), and effortful
  (reporter narrowed the case, attached output) — with the note that a
  failing/disabled test is all three in one artifact, and that an agent can lint
  a report for these like it lints the title.
- Distilled from Yegor Bugayenko's "The Right Way to Report a Bug" (2018).
- Deep reference: research/philosophy_23_bug_report_richness.md

## [0.3.0] -- 2026-06-26

### Added
- "Title lint" section: a bug title must be a declarative complaint, not a
  question, topic, or wish. Reject interrogative titles (`?` / why/how/what…),
  require a breakage signal (broken/fails/wrong/missing/instead/should/…), and
  auto-propose a rewrite at filing time — an agent is the ideal enforcer.
- Distilled from Yegor Bugayenko's "Good Title, Good Bug Report" (2025) and
  "Five Principles of Bug Tracking" (2014).
- Deep reference: research/philosophy_17_bug_tracking_hygiene.md

## [0.2.0] -- 2026-05-28

### Added
- Test-as-proof section: report a bug as a failing/disabled test; no code PR
  without a proving test (a test that fails against the old code); code and
  tests in separate PRs.
- Cross-references to the new `yegor-unit-tests` and `yegor-review` skills.

## [0.1.0] -- 2026-05-23

### Added
- Initial release.
- Distilled from Yegor Bugayenko's primary sources (see SKILL.md for citations).
- Deep reference: research/philosophy_02_bdd_bug_driven_development.md
