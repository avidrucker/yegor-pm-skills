# Changelog -- yegor-tickets

All notable changes to this skill are documented here.
Versioning follows Semantic Versioning (https://semver.org/).

## [0.3.0] -- 2026-06-26

### Added
- "Closing discipline (Five Principles of Bug Tracking)" section: keep a ticket
  one-on-one (one reporter, one solver — not a forum), and never close a ticket
  empty-handed (always deliver some solution, even temporary/partial). Distilled
  from Yegor's "Five Principles of Bug Tracking" (2014).
- Deep reference: research/philosophy_17_bug_tracking_hygiene.md (shared with
  yegor-bdd, which carries the companion title-lint rule).

## [0.2.0] -- 2026-05-31

### Added
- "Correcting an existing description" section: when a second party finds a
  factual error in a ticket description, redline it non-destructively
  (strikethrough in place + `SEE COMMENTS FOR CORRECTIONS` banner + correction
  comment) rather than silently rewriting the body. Extends the skill's
  additive, in-the-tracker discipline. Originated in lccjs #300.

## [0.1.0] -- 2026-05-23

### Added
- Initial release.
- Distilled from Yegor Bugayenko's primary sources (see SKILL.md for citations).
- Deep reference: research/philosophy_04_tickets_ticket_as_conversation.md
