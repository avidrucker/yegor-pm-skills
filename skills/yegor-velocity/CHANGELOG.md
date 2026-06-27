# Changelog -- yegor-velocity

All notable changes to this skill are documented here.
Versioning follows Semantic Versioning (https://semver.org/).

## [0.2.0] -- 2026-06-26

### Added
- "Beyond one number — the multi-metric scorecard" section: closed-tickets
  stays the headline, supplemented by PRs merged, bugs fixed, bugs reported,
  **Cost-of-PR (open→merge time)**, and docs — all git/tracker-derivable.
- The honesty rule: every count needs an anti-gaming validator (most reduce to
  "a second actor validated it" — `closed_by != opener`, merged-by-gate), the
  no-self-blessing logic applied to metrics.
- Cost-of-PR highlighted as the highest-signal addition (a timestamp
  subtraction whose growing trend is an early warning of stuck/oversized work).
- Cross-references to yegor-simba, yegor-merge-gate, and yegor-projections.
- Distilled from Yegor Bugayenko's "To Measure or Not to Measure: Individual
  Performance Metrics" (2020).
- Deep reference: research/philosophy_18_multi_metric_velocity.md

## [0.1.0] -- 2026-05-23

### Added
- Initial release.
- Distilled from Yegor Bugayenko's primary sources (see SKILL.md for citations).
- Deep reference: research/philosophy_06_velocity_closed_tickets.md
