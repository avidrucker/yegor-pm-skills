# Changelog -- yegor-personas

All notable changes to this skill are documented here.
Versioning follows Semantic Versioning (https://semver.org/).

## [0.1.0] -- 2026-06-26

### Added
- Initial release.
- Council-of-personas decision evaluator: convene 3–5 personas *with standing*
  on a non-trivial decision, take each one's strict 3-line reading
  (VERDICT / BECAUSE / STANDING), sort by authority not volume, and converge to
  one recommendation.
- The authority ladder (first match decides): requirements are the ultimate boss
  → binary gates unoverrideable → objective measures decide themselves → the
  reporter owns their ticket → the architect breaks technical ties → no
  compromise (name the concession). Invariants: role separation; standing beats
  volume.
- Grounds the council in both the 17 existing yegor-* skills and Yegor's
  unstaffed roles (PO, REQ, QA, TST) so spec/scope/process/repro concerns get a
  voice.
- Two worked examples (a unanimous refactor-now-vs-defer call; a named-unresolved
  close dispute resolved by the binary gate outranking the reporter).
- Distilled from Yegor Bugayenko's "Key Roles in a Software Project" (2016),
  "What if the Architect is Wrong?" (2019), and "Four NOs of a Serious Code
  Reviewer" (2015).
- Deep reference: research/philosophy_20_personas_decision_council.md
