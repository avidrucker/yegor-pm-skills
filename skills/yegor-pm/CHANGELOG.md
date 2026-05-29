# Changelog -- yegor-pm

All notable changes to this skill are documented here.
Versioning follows Semantic Versioning (https://semver.org/).

## [0.3.0] -- 2026-05-28

### Added
- Registered two new sub-skills: `yegor-review` (code-review discipline) and
  `yegor-unit-tests` (test quality + anti-patterns). Now 10 sub-skills.
- New "engineering-discipline layer" section tying review + tests to the
  bdd test-as-proof rule; routing rows and stack-ranking entries for both.
- Deep-reference rows for philosophy 08 (review) and 09 (unit tests).

### Changed
- Reconciled the source-repo copy with the live `claude-config` copy, which had
  drifted ahead (0.2.0): folded in `yegor-spikes`, the epic-handling pipeline,
  and the updated routing/stack-ranking tables that previously existed only in
  the live copy.

## [0.1.0] -- 2026-05-23

### Added
- Initial release.
- Distilled from Yegor Bugayenko's primary sources (see SKILL.md for citations).
- Deep reference: research/all philosophy_NN_*.md (orchestrator)
