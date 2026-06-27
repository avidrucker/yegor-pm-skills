# Changelog -- yegor-small-repos

All notable changes to this skill are documented here.
Versioning follows Semantic Versioning (https://semver.org/).

## [0.1.0] -- 2026-06-26

### Added
- Initial release.
- The small-repo target: one problem scope, one language/technology, ~50k-line
  working ceiling, sub-minute build — small enough to hold in one mind.
- The AI-era argument (2025): a small repo fits inside an agent's context
  window, so the whole codebase is real context instead of a lossy retrieved
  slice — now a first-class reason, not a nice-to-have.
- Rules: one repo / one purpose; one language per repo; cap as a checkable
  signal (`cloc`/`tokei`) not a law; split along problem seams, not
  arbitrarily; don't auto-split a cohesive codebase to hit a number.
- Solo/AI adaptation: favor small over the convenience of a monorepo; use the
  cap as a prompt for the human to decide a split, not a tripwire.
- Distilled from Yegor Bugayenko's "Monolithic Repositories Are Evil" (2018)
  and "Smaller Repository, Higher Quality" (2025).
- Deep reference: research/philosophy_15_small_repos_higher_quality.md
