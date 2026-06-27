# Changelog -- yegor-merge-gate

All notable changes to this skill are documented here.
Versioning follows Semantic Versioning (https://semver.org/).

## [0.2.0] -- 2026-06-26

### Added
- The zero-tolerance quality bar: any single lint/static-analysis violation
  fails the whole gate (warnings == errors, no warnings-only mode, no severity
  downgrade, no growing allowlist). Reduces to one boolean — linter exits
  non-zero → reject. Added as a Core rule and a Pitfall ("warning creep").
- Cross-references to yegor-builds (the gate is the Preflight build; this is
  rung 6 of the CI-maturity ladder) and yegor-unit-tests (the test half of the
  gate, rung 5).
- Distilled from Yegor Bugayenko's "Strict Control of Java Code Quality" (2014)
  and "Don't Aim for Quality, Aim for Speed" (2018).
- Deep reference: research/philosophy_19_zero_tolerance_and_stale_tickets.md

## [0.1.0] -- 2026-06-26

### Added
- Initial release.
- Read-only master, author-never-self-blesses, full-suite gate in a clean
  environment, and never-merge-into-a-broken-master (build-fix ships alone),
  with the solo/AI adaptation: an author-agent must not merge its own PR
  without an impartial gate (CI + independent review).
- Distilled from Yegor Bugayenko's "Master Branch Must Be Read-Only" (2014),
  "Rultor" (2014), and "We Don't Merge into a Broken Master Branch" (2025).
- Deep reference: research/philosophy_11_merge_gate_readonly_master.md
