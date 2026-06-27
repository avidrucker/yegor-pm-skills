# Changelog -- yegor-builds

All notable changes to this skill are documented here.
Versioning follows Semantic Versioning (https://semver.org/).

## [0.2.0] -- 2026-06-26

### Added
- "Trust-based dependency versioning" section: pin untrusted/low-reputation deps
  to fixed versions, allow ranges for trusted (semver-disciplined) ones, and
  record the trust rationale as a decision — avoiding both the pin-everything
  time bomb and the float-everything dependency hell. An agent can audit
  manifests and flag unjustified pins / risky floats.
- Cross-references to yegor-tickets and yegor-merge-gate.
- Distilled from Yegor Bugayenko's "My Recipe Against Dependency Hell" (2019).
- Deep reference: research/philosophy_24_dependency_trust.md

## [0.1.0] -- 2026-06-26

### Added
- Initial release.
- The four-tier build model: Fast (seconds, local, unit-only) → Cheap
  (minutes, every PR, +integration/style/coverage) → Preflight (the slow
  pre-merge gate, +mutation/load/security) → Proper (full regression, at
  release). Speed early, thoroughness late; the cheaper the build, the more
  often it runs.
- The 8+2 CI-maturity ladder as a self-audit checklist (one-command build →
  Git → read-only master → mandatory review → test-per-change →
  static-analysis threshold → pre-flight builds → prod-like containers →
  +stress → +security), with the rule to fix the lowest missing rung first.
- Solo/AI adaptation: give the agent a seconds-long Fast build to iterate in;
  push slow checks down to the gate. Minimum viable split is two speeds.
- Distilled from Yegor Bugayenko's "Four Builds" (2025) and "8+2 Maturity
  Levels of Continuous Integration" (2016).
- Deep reference: research/philosophy_12_four_builds_ci_maturity.md
