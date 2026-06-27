# Changelog -- yegor-pm

All notable changes to this skill are documented here.
Versioning follows Semantic Versioning (https://semver.org/).

## [0.6.0] -- 2026-06-26

### Added
- Registered one new sub-skill — now **17**: `yegor-personas` (council-of-personas
  decision evaluator: run a hard call through the relevant skills' strict lenses,
  converge via an authority ladder). Routing row, stack-ranking entry, and a
  deep-reference row for philosophy_20.
- Third-pass *strengtheners* reflected in the table copy and deep-reference map:
  `yegor-architect` 0.2.0 (authority layer — requirements-are-the-boss / two
  instruments / what-if-the-architect-is-wrong, philosophy_21), `yegor-nohelp`
  0.2.0 (doc structure — short/ordered/measurable, philosophy_22), `yegor-bdd`
  0.4.0 (report richness, philosophy_23), `yegor-builds` 0.2.0 (trust-based
  dependency versioning, philosophy_24).

## [0.5.0] -- 2026-06-26

### Added
- Registered four new sub-skills — now **16**: `yegor-builds` (tiered builds /
  CI-maturity ladder), `yegor-simba` (WIP caps + evidence-backed status),
  `yegor-projections` (forecast from velocity, not estimates), and
  `yegor-small-repos` (one repo / one purpose / ~50k LOC).
- Routing rows for all four (forecasting → projections; slow CI → builds;
  sprawl/unbacked status → simba; repo boundaries → small-repos),
  stack-ranking entries, and deep-reference rows for philosophy 12–15.
- Folded the second-batch *enhancements* into the routing/table copy and the
  deep-reference map: testless-PR gate + two-PR flow (review/unit-tests,
  philosophy_16), bug-title lint + Five Principles (bdd/tickets,
  philosophy_17), multi-metric velocity scorecard (velocity, philosophy_18),
  and the zero-tolerance quality bar + No-Obligations stale-work rule
  (merge-gate/stuck, philosophy_19).

## [0.4.0] -- 2026-06-26

### Added
- Registered two new sub-skills: `yegor-stuck` (the cut-corners / don't-be-a-hero
  stuck protocol) and `yegor-merge-gate` (read-only master, never self-bless a
  merge, never merge into a broken master). Now 12 sub-skills.
- Routing rows for both (blocked/thrashing → stuck; about-to-merge / CI red →
  merge-gate), stack-ranking entries, and deep-reference rows for philosophy
  10 (stuck) and 11 (merge-gate).

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
