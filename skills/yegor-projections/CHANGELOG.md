# Changelog -- yegor-projections

All notable changes to this skill are documented here.
Versioning follows Semantic Versioning (https://semver.org/).

## [0.1.0] -- 2026-06-26

### Added
- Initial release.
- The core distinction: an estimate is a spec-derived promise; a projection is
  a forecast from measured velocity (`weeks ≈ open tickets ÷ closed-per-week`),
  stamped with an as-of date and a range, and re-issued as the data changes.
- Rules: don't estimate the whole from the spec; project from the measured
  close-rate; no velocity history → say "can't project yet, measure first";
  re-project rather than defend a stale number; keep micro-estimates (≤60min)
  separate from aggregate projections.
- Solo/AI adaptation: the agent computes the projection from the tracker
  (open count ÷ close rate) and shows the arithmetic instead of asserting a
  confident deadline.
- Distilled from Yegor Bugayenko's "How to Estimate Software Cost" (2015) and
  the projections-vs-estimates argument (Shift-M/44, 2020).
- Deep reference: research/philosophy_14_projections_no_estimates.md
