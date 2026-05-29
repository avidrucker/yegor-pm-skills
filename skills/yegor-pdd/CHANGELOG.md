# Changelog -- yegor-pdd

All notable changes to this skill are documented here.
Versioning follows Semantic Versioning (https://semver.org/).

## [0.3.0] -- 2026-05-28

### Added
- "Scan coverage" gotcha: a puzzle is only tracked if its file is inside pdd's source set and outside its `--exclude` globs. Puzzles in excluded paths (`*.md`, `docs/**`, …) are silently ignored — the pre-push hook can print "0 puzzle(s) tracked" while many exist. Confirm the path is scanned before trusting the count; otherwise the parent GH issue is the only backstop.
- "Puzzle-text trap" pitfall: never put a bare `@todo` / `TODO` / `TODO:` token in a puzzle's *description text* — pdd reads the second marker as a new malformed puzzle and aborts the whole scan. Write "build puzzles", not "build @todos".

### Fixed
- VERSION file drift: bumped from a stale 0.1.0 (frontmatter and CHANGELOG were already at 0.2.0) so all three version sources agree again.

## [0.2.0] -- 2026-05-27

### Added
- "Blocked puzzles" section: leave @todo in place, mark blocked in issue, skip in priority queue, resume when unblocked.
- "Puzzle lifecycle (close checklist)" section: remove @todo, commit with `Closes #N`, write resolution comment, verify pdd scan.
- Cross-reference to new `yegor-spikes` sub-skill.

## [0.1.0] -- 2026-05-23

### Added
- Initial release.
- Distilled from Yegor Bugayenko's primary sources (see SKILL.md for citations).
- Deep reference: research/philosophy_01_pdd_puzzle_driven_development.md
