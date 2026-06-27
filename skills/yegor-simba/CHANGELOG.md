# Changelog -- yegor-simba

All notable changes to this skill are documented here.
Versioning follows Semantic Versioning (https://semver.org/).

## [0.1.0] -- 2026-06-26

### Added
- Initial release.
- Hard work-in-progress caps (own ~≤3 artifacts / review ~≤4 / hold ~≤7
  total): past the cap you finish or drop before starting new work.
- Owner + reviewer as two distinct roles per artifact; completion is reported
  by the reviewer, not the owner (no-self-blessing at the planning layer).
- The evidence rule: every status claim links to a verifiable artifact (PR,
  commit, doc, passing build); effort verbs with no link are not progress.
- Small weekly report (≤~7 achievements, ≤~7 planned) as a sprawl signal.
- Solo/AI adaptation: the cap stops you + the agent from sprawling across
  half-finished branches; make the agent cite artifacts instead of asserting
  "done"; you review the agent's owned work.
- Distilled from Yegor Bugayenko's "SIMBA — Simplified Management By Artifacts"
  (2021).
- Deep reference: research/philosophy_13_simba_wip_caps_evidence.md
