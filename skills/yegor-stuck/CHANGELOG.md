# Changelog -- yegor-stuck

All notable changes to this skill are documented here.
Versioning follows Semantic Versioning (https://semver.org/).

## [0.2.0] -- 2026-06-26

### Added
- "Stale work — the No-Obligations rule" section: taking a ticket isn't a
  promise to finish it. Detect in-progress items idle past a threshold (~10
  days default; shorter for solo loops) with no closing deliverable, then take
  a rung or drop/re-scope them — never fake activity to keep a dead item alive.
  Pairs with yegor-simba WIP caps (a stale item is what must be shed to free a
  slot).
- Cross-references to yegor-simba and yegor-velocity.
- Distilled from Yegor Bugayenko's "No Obligations" principle (2014).
- Deep reference: research/philosophy_19_zero_tolerance_and_stale_tickets.md

## [0.1.0] -- 2026-06-26

### Added
- Initial release.
- The cut-corners ladder (block → demand docs → reproduce-as-skipped-test →
  prove-absent → disable-and-ship) plus the "never cut unit tests" rule and the
  "never fabricate green" guardrail for AI agents.
- Distilled from Yegor Bugayenko's "How to Cut Corners and Stay Cool" (2015).
- Deep reference: research/philosophy_10_stuck_cut_corners.md
